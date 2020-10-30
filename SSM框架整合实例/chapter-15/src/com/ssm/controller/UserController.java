package com.ssm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.po.User;
import com.ssm.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	/*
	 *	根据 id 查询用户详情
	 */
	@RequestMapping("/findUserById")
	public String findUserById(Integer id,Model model) {
		User user = userService.findUserById(id);
		model.addAttribute("user", user);
		return "user";
	}
	
	@RequestMapping("/hello")
	public String hello() {
		return "success";
	}
}
