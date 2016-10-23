<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Course Grades</title>
</head>
<body>
	<h2>
		<a href="../index.html">OnCourse</a>
	</h2>
	<h3>Course Grades</h3>
	<table border="1">
		<tr>
			<th>Student</th>
			<th>Grade</th>
			<th>Operations</th>
		</tr>
		<c:forEach items="${gradeRecords}" var="gradeRecord">
			<tr>
				<td>${gradeRecord.student.firstName},
					${gradeRecord.student.lastName }</td>
				<td><c:choose>
						<c:when test="${empty gradeRecord.grade}">No grade assigned.</c:when>
						<c:otherwise>${gradeRecord.grade.symbol }</c:otherwise>
					</c:choose></td>
				<td><a href="editGradeRecord.html?id=${gradeRecord.id }">Edit</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
