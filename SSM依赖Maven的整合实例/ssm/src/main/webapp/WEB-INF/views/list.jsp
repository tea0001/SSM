<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!-- web路径：
不以‘/’开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
以‘/’开始的相对路径，找资源，以服务器的路径为基准（http://localhost:3306）需要加上项目名
						http://localhost:3306/ssm
 -->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.5.1.js"></script>
<!-- 引入样式 -->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>依赖Maven的SSM框架-增删改查</h1>
			</div>
		</div>
		<!-- 两个按钮 -->
		<div class="row">
			<div class="col-md-2 col-md-offset-9">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-info  btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
								</button>
								<button class="btn btn-danger  btn-sm">
									<span class="glyphicon glyphicon-trash " aria-hidden="true"></span>删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 显示信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6">
				当前第 ${pageInfo.pageNum } 页，共 ${pageInfo.pages } 页，总 ${pageInfo.total } 条记录。
			</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				  	 <c:if test="${pageInfo.hasPreviousPage}">
					  	 <li>
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				  	 </c:if>
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
				    	<c:if test="${page_Num==pageInfo.pageNum }">
				    		<li class="active"><a href="#">${page_Num }</a></li>
				    	</c:if>
				    	<c:if test="${page_Num!=pageInfo.pageNum }">
				    		<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num }</a></li>
				    	</c:if>
				    	
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage }">
				    	<li>
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				    </c:if>
				    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
				  </ul>
				</nav>
			</div>
			
		</div>
	</div>

</body>
</html>