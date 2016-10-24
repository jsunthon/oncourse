<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head><title>Users</title></head>
<body>
<p>Hello, <security:authentication property="principal.username" />!</p>
<table border="1">
<tr><th>ID</th><th>Username</th><th>Name</th><th>Operations</th></tr>
<c:forEach items="${users}" var="user">
<tr>
  <td>${user.id}</td>
  <td>${user.username}</td>
  <td>${user.firstName }, ${user.lastName }</td>
  <td>
    <security:authorize access="hasAnyRole('ADMIN', 'ADVISOR')">
      <a href="progress.html?id=${user.id}">Progress (on course status)</a> |
      <a href="grades.html?id=${user.id }">Manage Grades</a>
    </security:authorize>
  </td>
</tr>
</c:forEach>
</table>
</body>
</html>
