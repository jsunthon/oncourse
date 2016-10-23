<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Courses</title>
</head>
<body>
<h2><a href="../index.html">OnCourse</a></h2>
<h3>Courses</h3>
<table border="1">
<tr><th>Code</th><th>Name</th><th>Units</th><th>Operations</th></tr>
<c:forEach items="${courses}" var="course">
<tr>
  <td>${course.code}</td>
  <td>${course.name}</td>
  <td style="text-align: center;">${course.units}</td>
  <td><a href="studentGrades.html?id=${course.id }">Manage Student Grades</a></td>
</tr>
</c:forEach>
</table>
</body>
</html>
