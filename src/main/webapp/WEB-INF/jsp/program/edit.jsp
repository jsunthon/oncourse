<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Program</title>
</head>
<body>
	<form action="edit.html" method="post">
		<input type="hidden" name="id" value="${program.id }" /> Name: <input
			type="text" value="${program.name}" name="name" /> <br />
		Description:
		<textarea name="description">${program.description }</textarea>
		Department: <select name="departmentId">
			<c:forEach items="${departments }" var="department">
				<c:choose>
					<c:when test="${program.department == department }">
						<option selected value="${department.id }">${department.name }</option>
					</c:when>
					<c:otherwise>
						<option value="${department.id }">${department.name }</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select> <input type="submit" name="Edit" value="Edit Program" />
	</form>
</body>
</html>
