<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Grade</title>
</head>
<body>
	<form action="editGradeRecord.html" method="post">
		<input type="hidden" name="gradeRecordId" value="${gradeRecord.id }" />
		<p>Student: ${gradeRecord.student.firstName }, ${gradeRecord.student.lastName }</p>
		<br/>
		Select grade: <select name="gradeId">
			<c:forEach items="${grades }" var="grade">
				<c:choose>
					<c:when test="${(not empty gradeRecord.grade) and gradeRecord.grade eq grade }">
						<option selected value="${grade.id }">${grade.symbol }</option>
					</c:when>
					<c:otherwise>
							<option value="${grade.id }">${grade.symbol }</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select> <input type="submit" name="Edit" value="Edit Grade" />
	</form>
</body>
</html>
