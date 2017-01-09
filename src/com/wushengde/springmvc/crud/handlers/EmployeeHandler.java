package com.wushengde.springmvc.crud.handlers;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.wushengde.springmvc.crud.dao.DepartmentDao;
import com.wushengde.springmvc.crud.dao.EmployeeDao;
import com.wushengde.springmvc.crud.entities.Employee;


@Controller
public class EmployeeHandler {
	
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private DepartmentDao departmentDao;
	
	
	
	@ModelAttribute
	public void getEmployee(@RequestParam(value="id",required=false) Integer id,Map<String,Object> map){
		if (id!=null) {
			map.put("employee", employeeDao.get(id));
		}
	}
	
	
	@RequestMapping(value="/emp",method=RequestMethod.PUT)
	public String update(Employee employee){
		employeeDao.save(employee);
		return "redirect:/emps";
	}
	
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public String input(@PathVariable("id") Integer id,Map<String,Object> map){
		map.put("employee", employeeDao.get(id));
		map.put("departments", departmentDao.getDepartments());
		return "input";
	}
	
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	public String delete(@PathVariable("id") Integer id){
		employeeDao.delete(id);
		return "redirect:/emps";
	}
	
	/**
	 * BindingResult:用来存储错误信息,如果出错可以查看什么错误
	 * 需校验的 Bean 对象和其绑定结果对象或错误对象时成对出现的，它们之间不允许声明其他的入参
	 * 本例中：Employee与BindingResult两个入参必须挨着
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	public String save(@Valid Employee employee,BindingResult result,Map<String,Object> map){
		System.out.println("save"+employee);
		if(result.getErrorCount() > 0){
			System.out.println("出错了！");
			
			for(FieldError error:result.getFieldErrors()){
				System.out.println(error.getField()+":"+error.getDefaultMessage());
			}
			//如果出错了，则转向定制的页面
			map.put("departments", departmentDao.getDepartments());
			return "input";
		}
		employeeDao.save(employee);
		return "redirect:/emps";
	}
	
	
	@RequestMapping(value="/emp",method=RequestMethod.GET)
	public String input(Map<String, Object> map){
		//将所有的部门存入map中
		map.put("departments", departmentDao.getDepartments());
		//无论是否做表单回显都在请求域中加入input.jsp页面中对应属性的对象
		map.put("employee", new Employee());
		return "input";
	}
	
	
	@RequestMapping("/emps")
	public String list(Map<String, Object> map){
		map.put("employees", employeeDao.getAll());
		return "list";
	}
}
