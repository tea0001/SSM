package com.ssm.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;
import com.ssm.bean.Msg;
import com.ssm.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 	导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmppsWithJson(@RequestParam(value = "pn", defaultValue = "1")Integer pn) {
		//这不是一个分页查询
		//引入PageHelper分页插件
		//在查询前只需要调用PageHelper.startPage(传入页码, 数据数量)
		PageHelper.startPage(pn, 5);
		//startPage紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		//查询完成后可以使用PageInfo包装，只需要PageInfo交给页面就行了
		//封装了详细的分页信息。包括我们查询出来的数据。传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo", page);
	}
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value="/emps",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	/**
	 *	查询员工数据（分页查询）
	 * @param pn
	 * @param model
	 * @return
	 */
	/*
	 * @RequestMapping("/emps") public String getEmpps(@RequestParam(value = "pn",
	 * defaultValue = "1")Integer pn, Model model) { //这不是一个分页查询 //引入PageHelper分页插件
	 * //在查询前只需要调用PageHelper.startPage(传入页码, 数据数量) PageHelper.startPage(pn, 5);
	 * //startPage紧跟的这个查询就是一个分页查询 List<Employee> emps = employeeService.getAll();
	 * //查询完成后可以使用PageInfo包装，只需要PageInfo交给页面就行了 //封装了详细的分页信息。包括我们查询出来的数据。传入连续显示的页数
	 * PageInfo page = new PageInfo(emps,5); model.addAttribute("pageInfo",page);
	 * 
	 * return "list"; }
	 */
}
