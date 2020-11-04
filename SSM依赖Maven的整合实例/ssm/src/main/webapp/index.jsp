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
	<!-- 新增员工：模态框	-->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	      	<!-- 表单 -->
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="name">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@gmail.com">
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
					<input type="radio" name="gender" id="gender1_add_input" value="M"checked="checked"> 男
				  </label>
				  <label class="radio-inline">
					<input type="radio" name="gender" id="gender2_add_input" value="W"> 女
				  </label>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
			      <!-- 部门提交部门id即可 -->
			      <select class="form-control" name="dId" id="dept_add_select">
			        
				  </select>
			    </div>
			  </div>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
	      </div>
	    </div>
	  </div>
	</div>

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
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="emps_table_tbody">
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
		var totalRecord;
		//1、页面加载完成后，发送一个Ajax请求，要到分页数据
		$(function() {
			//去首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"get",
				success:function(result){
					// console.log(result);
					//1、解析并显示员工数据
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析并显示分页条
					build_page_nav(result);
					
				}
			});
		}
		
		function build_emps_table(result) {
			//清空数据
			$("#emps_table_tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info  btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
								.append("编辑");
				var delBtn = $("<button></button>").addClass("btn btn-danger  btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
								.append("删除");
				var btnTd = $("<td></td>").append(editBtn)
								.append(" ")
								.append(delBtn);
				$("<tr></tr>").append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
			});
		}
		//解析分页信息
		function build_page_info(result){
			//清除分页信息
			$("#page_info_area").empty();
			$("#page_info_area")
				.append("当前第 "+result.extend.pageInfo.pageNum
						+" 页，共 "+result.extend.pageInfo.pages
						+"  页，总 "+result.extend.pageInfo.total
						+" 条记录。");
			totalRecord = result.extend.pageInfo.total;
		}
		//解析分页条
		function build_page_nav(result) {
			//清除分页条
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
			}
			
			ul.append(firstPageLi).append(prePageLi);
			//1.2.3.4.5...
			$.each(result.extend.pageInfo.navigatepageNums,function(index, item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}else{
					numLi.click(function(){
						to_page(item);
					});
				}
				
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			$("#dept_add_select").empty();
			//发送Ajax请求，查出部门信息，显示在下拉列表中
			 getDepts();
			//弹出模态框
			$('#empAddModal').modal({
				backdrop:"static"
			});
		});
		//查出所以部门信息，显示在下拉列表中
		function getDepts() {
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					$.each(result.extend.depts,function(index,item){
						var deptNameOption = $("<option></option>").append(item.deptName).attr("value",item.deptId);
						deptNameOption.appendTo("#dept_add_select");
					});
					
				}
			});
		}
		
		function validate_add_form() {
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			alert(regName.test(empName));
			
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/ ;
			alert(regEmail.test(email));
			return false;
		}
		
		$("#emp_save_btn").click(function(){
			//1、将模态框中填写的数据，提交给服务器
			//进行校验
			if(!validate_add_form()){
				return ;
			}
			
			//2、发送Ajax请求保存员工数据
			$.ajax({
				url:"${APP_PATH}/emps",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//员工保存成功
					//1、关闭模态框
					$('#empAddModal').modal('hide');
					//2、来到最后一页
					to_page(totalRecord+1);
				}
			});
		});
	</script>
</body>
</html>