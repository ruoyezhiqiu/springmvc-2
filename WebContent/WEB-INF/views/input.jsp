<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<!-- 添加方式一：自定义类型转换 -->
	<p>添加方式一：自定义类型转换，将字符串转为employee对象</p>
	<br>
	<!-- 自定义类型转换器，将String类型转换为：employee对象，作用：直接输入一串字符串传给后台即可实现用户添加 -->
	<form action="testConversionServiceConverer" method="POST">
		<!-- 格式：lastname-email-gender-department.id 例如：GG-gg@atguigu.com-0-105 -->
		
		Employee:<input type="text" name="employee"/><br>
		<p style="color:red;">注 格式：lastname-email-gender-department.id; 其中gender值(0,表示female;1,表示male),department.id(值：101、102、103、104、105) </p><br>
		<input type="submit" value="添加"/>
	</form>
	<br><br><br><br>

<!-- 
      该页面使用springMVC的表单标签:需要引入：springMVC的表单标签
      
	1.为什么使用springMVC的表单标签：可以更快速的开发出表单页面，而且可以更方便的实现表单值的回显。
	2.可以通过 modelAttribute 属性指定绑定的模型属性,
	若没有指定该属性，则默认从 request 域对象中读取command 的表单 bean,
	如果该属性值也不存在，则会发生错误。
	注：需指定form的modelAttribute属性必须与handler方法中创建在请求域中的键一致。本例中该键为：employee，若不指定，默认的该键为：command。
-->
	<!-- 解决不支持：PUT 方法：action中使用了 ${pageContext.request.contextPath}-->
	<p>添加方式二：springMVC表单添加</p>
	<form:form action="${pageContext.request.contextPath}/emp" method="POST" modelAttribute="employee" >
		

		<c:if test="${employee.id == null }">
			<!-- path属性对应html 表单标签的name属性 -->
			LastName:<form:input path="lastName"/>
			<form:errors path="lastName" cssStyle="color:red;"></form:errors>
		</c:if>
		
		<c:if test="${employee.id != null }">
			<form:hidden path="id"/>
		<!-- 
			对于_method 不能使用form:hidden标签 因为：modelAttribute 对应的bean中没有_method这个属性
			此处应该使用html自带的 input标签，因为：html中的input不跟springMVC 自带的form表单标签关联！
		-->
			<input type="hidden" name="_method" value="PUT"/>
		</c:if>
		<br>
		Email:<form:input path="email"/>
		<form:errors path="email" cssStyle="color:red;"></form:errors>
		<br>
		<%
			Map<String,String> genders= new HashMap<String,String>();
			genders.put("1", "Male");
			genders.put("0", "Female");
			request.setAttribute("genders", genders);
		%>
		Gender:<form:radiobuttons path="gender" items="${genders }"/>
		<br>
		Department:<form:select path="department.id" items="${departments }" itemLabel="departmentName" itemValue="id"></form:select>
		<br>
		<!-- 
			1.此处涉及到数据类型转换：字符串类型转换为日期类型
			2.数据类型格式化的问题
			3.数据校验问题：符合实际逻辑规律
				a.如何校验？注解方式     步骤： 
					1. 使用JSR 303 验证标准; 
					2.加入Hibernate Validator框架的  jar 包
					3.在springMVC配置文件中添加：<mvc:annotation-driven>配置
					4.需要在bean的属性上添加对应的注解
					5.在目标方法bean类型的前面添加@Valid 注解
				b.验证错误转向哪个页面？
				c.错误消息如何显示？
		-->	
		Birth:<form:input path="birth"/>
		<form:errors path="birth" cssStyle="color:red;"></form:errors>
		<br>
		Salary:<form:input path="salary"/>
		<br>
		
		<input type="submit" value="提交"/>
	</form:form>
</body>
</html>