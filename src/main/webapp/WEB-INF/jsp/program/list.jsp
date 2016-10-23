<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Programs</title>
</head>
<body>
	<h2>
		<a href="../index.html">OnCourse</a>
	</h2>
	<h3>Programs</h3>
	<table border="1">
		<tr>
			<th>Department</th>
			<th>Name</th>
			<th>Operations</th>
		</tr>
		<c:forEach items="${programs}" var="program">
			<tr>
				<td>${program.department.name}</td>
				<td>${program.name}</td>
				<td><a href="delete.html?id=${program.id }">Delete</a> | <a
					href="edit.html?id=${program.id }">Edit</a> |
					<a href="view.html?id=${program.id }">View</a>
			</tr>
		</c:forEach>
	</table>
	<a href="add.html">Add Program</a>
</body>
</html>
