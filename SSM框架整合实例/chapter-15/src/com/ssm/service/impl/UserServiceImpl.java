package com.ssm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.dao.UserDao;
import com.ssm.po.User;
import com.ssm.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService{
	//依赖注入
	@Autowired
	private UserDao userDao;
	//查询客户
	@Override
	public User findUserById(Integer id) {
		return this.userDao.findUserById(id);
	}

	
}
