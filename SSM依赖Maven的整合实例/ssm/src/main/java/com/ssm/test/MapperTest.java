package com.ssm.test;

import java.util.Random;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.bean.Department;
import com.ssm.bean.Employee;
import com.ssm.dao.DepartmentMapper;
import com.ssm.dao.EmployeeMapper;

/**
 * 	测试  dao 层的工作
 * @author tea
 *	推荐使用Spring的单元测试，可以自动注入我们需要的组件
 *	1、导入SpringTest模块
 *	2、@ContextConfiguration指定Spring配置文件的位置
 *	3、直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		/*
		 * //1、创建SpringIOC容器 ApplicationContext ioc = new
		 * ClassPathXmlApplicationContext("applicationContext.xml"); //2、从容器中取出Mapper
		 * DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		 */
		System.out.println(departmentMapper);
		
//		一、插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
//		departmentMapper.insertSelective(new Department(null, "人事部"));
//		departmentMapper.insertSelective(new Department(null, "前端设计部"));
		
//		二、生成员工数据，测试员工插入
//		employeeMapper.insertSelective(new Employee(null, "Jerry", "M","Jerry@gmail.com", 1));
		
//		三、批量插入多个员工，批量。使用可以执行批量操作的sqlSession
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		for (int i=0;i<1000;i++) {
//			String uid = UUID.randomUUID().toString().substring(0,5)+i;
//			mapper.insertSelective(new Employee(null, uid, "M",uid+"@gmail.com", 1));
//		}
		
//		四、修改员工信息
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		Random random = new Random();
//		Random random1 = new Random();
//		String str[] = {"M", "W"};
//		for (int i = 0; i < 400; i++) {
//			int j = random.nextInt(990);
//			int k = random1.nextInt(2);
//			mapper.updateByPrimaryKeySelective(new Employee(j, null, str[k], null,2));
//			mapper.updateByPrimaryKeySelective(new Employee(j+3, null, str[k], null,3));
//			mapper.updateByPrimaryKeySelective(new Employee(j+5, null, str[k], null,4));
//		}
		System.out.println("执行完成");
		
		
		
	}
}
