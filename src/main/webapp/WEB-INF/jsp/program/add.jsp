<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add User</title>
</head>
<body>
	<form action="add.html" method="post">
		Name: <input type="text" name="name" /> <br />
		Description:<textarea name="description"></textarea>
		Department: <select name="departmentId">
			<c:forEach items="${departments }" var="department">
			<option value="${department.id }">${department.name }</option>
			</c:forEach>
		 </select>
		<input type="submit" name="add" value="Add Program" />
	</form>
</body>
</html>
