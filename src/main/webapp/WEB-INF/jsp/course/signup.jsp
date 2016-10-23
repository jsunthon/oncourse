<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Course Signup</title>
</head>
<body>
	<h2>
		<a href="index.html">OnCourse</a>
	</h2>
	<h1>Course signup</h1>
	<table border="1">
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Units</th>
			<th>Operations</th>
		</tr>
		<c:forEach items="${courses}" var="course">
			<tr>
				<td>${course.code}</td>
				<td>${course.name}</td>
				<td style="text-align: center;">${course.units}</td>
				<td><a href="courseSignup.html?id=${course.id }">Signup</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
