package com.ssm.dao;

import com.ssm.po.User;
/*
 * User 接口文件
 */
public interface UserDao {

	/*
	 * 根据 id 查询用户信息
	 */
	public User findUserById(Integer id);
}
