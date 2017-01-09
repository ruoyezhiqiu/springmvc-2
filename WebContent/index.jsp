<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="scripts/jquery-1.12.3.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#testJson").click(function(){
			var url = this.href;
			var args = {};
			$.post(url, args, function(data){
				for(var i = 0; i < data.length; i++){
					var id = data[i].id;
					var lastName = data[i].lastName;
					
					alert(id + ": " + lastName);
				}
			});
			return false;
		});
	})
</script>
</head>
<body>
	<a href="emps">Show All Employee</a>
	<br><br>
	<a href="testJson" id="testJson">Test Json</a>
	<br><br>
	<p>演示文件上传：</p>
	<br><br>
	<form action="testHttpMessageConverter" method="POST" enctype="multipart/form-data">
		File:<input type="file" name="file"/>
		Desc:<input type="text" name="desc"/>
		<input type="submit" value="上传"/>
	</form> 
	<br><br>
	<p>演示文件下载：</p><br><br>
	<a href="testResponseEntity">下载</a>
</body>
</html>