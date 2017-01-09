package com.wushengde.springmvc.crud.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wushengde.springmvc.crud.dao.EmployeeDao;
import com.wushengde.springmvc.crud.entities.Employee;

@Controller
public class SpringmvcTest {

	@Autowired
	private EmployeeDao emploeeDao;
	
	@RequestMapping("/testConversionServiceConverer")
	public String testConverter(@RequestParam("employee") Employee employee){
		System.out.println("save: "+employee);
		emploeeDao.save(employee);
		return "redirect:/emps";
	}
	
}
