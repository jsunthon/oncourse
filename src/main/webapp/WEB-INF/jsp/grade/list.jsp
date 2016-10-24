<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Grades</title>
</head>
<body>
	<h2>
		<a href="../index.html">OnCourse</a>
	</h2>
	<h3>${user.name}'sGrades</h3>
	<table border="1">
		<tr>
			<th>Term</th>
			<th>Course</th>
			<th>Grade</th>
			<th>Operations</th>
		</tr>
		<c:forEach items="${gradeRecords}" var="gradeRecord">
			<tr>
				<td>${gradeRecord.term.fullName}</td>
				<td>${gradeRecord.course.code}-${gradeRecord.course.name }</td>
				<td style="text-align: center">${gradeRecord.grade.symbol}</td>
				<td><security:authorize access="hasAnyRole('ADMIN','ADVISOR')">
						<a href="editGradeRecord.html?id=${gradeRecord.id }">Edit Grade</a>
					</security:authorize></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
