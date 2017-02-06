<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<p>要实现国际化，需要导入国际化标签：fmt</p><br>
	<fmt:message key="i18n.user"></fmt:message>
	<br><br>
	<a href="i18n2">I18N2 page</a>	
	
	<br><br>
	<a href="testExceptionHandlerExceptionResolver?i=10">TestExceptionHandlerExceptionResolver</a>	

</body>
</html>