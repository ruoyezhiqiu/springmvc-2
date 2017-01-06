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
<!-- 
      该页面使用springMVC的表单标签:需要引入：springMVC的表单标签
      
	1.为什么使用springMVC的表单标签：可以更快速的开发出表单页面，而且可以更方便的实现表单值的回显。
	2.可以通过 modelAttribute 属性指定绑定的模型属性,
	若没有指定该属性，则默认从 request 域对象中读取command 的表单 bean,
	如果该属性值也不存在，则会发生错误。
	注：需指定form的modelAttribute属性必须与handler方法中创建在请求域中的键一致。本例中该键为：employee，若不指定，默认的该键为：command。
-->
	<!-- 解决不支持：PUT 方法：action中使用了 ${pageContext.request.contextPath}-->
	<form:form action="${pageContext.request.contextPath}/emp" method="POST" modelAttribute="employee" >
		
		<c:if test="${employee.id == null }">
			<!-- path属性对应html 表单标签的name属性 -->
			LastName:<form:input path="lastName"/>
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
		<input type="submit" value="Submit"/>
	</form:form>
</body>
</html>