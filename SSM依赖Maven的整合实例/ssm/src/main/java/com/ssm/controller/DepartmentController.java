package com.ssm.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.bean.Department;
import com.ssm.bean.Msg;
import com.ssm.service.DepartmentService;

/**
 * 	处理和部门有关的请求
 * @author tea
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 	返回所以的部门
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDemps() {
		List<Department> dept = departmentService.getAll();
		return Msg.success().add("depts", dept);
	}
}
