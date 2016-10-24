<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Grades</title>
</head>
<body>
<h2><a href="../index.html">OnCourse</a></h2>
<h3>${user.name}'s Grades</h3>
<table border="1">
<tr><th>Term</th><th>Course</th><th>Grade</th></tr>
<c:forEach items="${gradeRecords}" var="gradeRecord">
<tr>
  <td>${gradeRecord.term.fullName}</td>
  <td>${gradeRecord.course.code} - ${gradeRecord.course.name }</td>
  <td style="text-align: center">${gradeRecord.grade.symbol}</td>
</tr>
</c:forEach>
</table>
</body>
</html>
