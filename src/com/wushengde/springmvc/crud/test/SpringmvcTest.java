package com.wushengde.springmvc.crud.test;

import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wushengde.springmvc.crud.dao.EmployeeDao;
import com.wushengde.springmvc.crud.entities.Employee;

@Controller
public class SpringmvcTest {

	@Autowired
	private EmployeeDao employeeDao;
	
	
	@ExceptionHandler(RuntimeException.class)
	public ModelAndView handleArithmeticException2(Exception ex){
		System.out.println("[出异常了]： "+ ex);
		ModelAndView mv=new ModelAndView("error");
		mv.addObject("exception",ex);
		return mv;
	}
	
	/**
	 *  1.在@ExceptionHandler 方法的入参中可以加入Exception 类型的参数，该参数就是对应的发生的异常对象
	 *  2.@ExceptionHandler 方法的入参不能传入 Map 如果希望将异常带到页面，需要使用ModelAndView 作为返回类型
	 *  
	 */
	@ExceptionHandler(ArithmeticException.class)
	public ModelAndView handleArithmeticException(Exception ex){
		System.out.println("出异常了： "+ ex);
		ModelAndView mv=new ModelAndView("error");
		mv.addObject("exception",ex);
		return mv;
	}
	
	
	//测试springMVC异常处理
	@RequestMapping("/testExceptionHandlerExceptionResolver")
	public String testExceptionHandlerExceptionResolver(@RequestParam("i") int i){
		System.out.println("result: " + (10/i));
		return "success";
	}
	
	
	//演示文件下载：
	@RequestMapping("/testResponseEntity")
	public ResponseEntity<byte[]> testResponseEntity(HttpSession session) throws IOException{
		byte [] body = null;
		ServletContext servletContext = session.getServletContext();
		InputStream inputStream=servletContext.getResourceAsStream("/files/abc.txt");
		body = new byte[inputStream.available()];
		inputStream.read(body);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment;filename=abc.txt");
		
		HttpStatus statusCode = HttpStatus.OK;
		
		ResponseEntity<byte[]> response = new ResponseEntity<byte[]>(body,headers,statusCode);
		return response;
	}
	
	
	//演示文件上传
	@ResponseBody
	@RequestMapping("/testHttpMessageConverter")
	public String testHttpMessageConverter(@RequestBody String body){
		System.out.println(body);
		return "helloworld!"+new Date();
	}
	
	
	//返回Json时用：@ResponseBody 注解
	@ResponseBody
	@RequestMapping("/testJson")
	public Collection<Employee> testJson(){
		return employeeDao.getAll();
	}
	
	
	//测试自定义类型转换
	@RequestMapping("/testConversionServiceConverer")
	public String testConverter(@RequestParam("employee") Employee employee){
		System.out.println("save: "+employee);
		employeeDao.save(employee);
		return "redirect:/emps";
	}
	
}
