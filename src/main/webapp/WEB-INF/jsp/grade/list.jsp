<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Grades</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
$(function() {
	$(".deleteBtn").click(function() {
		console.log("Grade record id: " + gradeRecordId);
		$.ajax({
			url: "../service/grade/" + gradeRecordId,
			method: "DELETE",
			context: $(this),
			success: function() {
				$(this).closest("tr").remove();
			}
		});
	});
});
</script>
</head>
<body>
	<h2>
		<a href="..">OnCourse</a>
	</h2>
	<h3>${user.name}'sGrades</h3>
	<form action="add" method="post">
		<p>
			<select name="season">
				<option value="F">Fall</option>
				<option value="W">Winter</option>
				<option value="S">Spring</option>
				<option value="X">Summer</option>
			</select> <select name="year">
				<c:forEach items="${years}" var="year">
					<option>${year}</option>
				</c:forEach>
			</select> <select name="courseId">
				<c:forEach items="${courses}" var="course">
					<option value="${course.id}">${course.code}</option>
				</c:forEach>
			</select> <select name="gradeId">
				<c:forEach items="${grades}" var="grade">
					<option value="${grade.id}">${grade.symbol}</option>
				</c:forEach>
			</select> <input type="submit" name="add" value="Add" />
		</p>
	</form>

	<table border="1">
		<tr>
			<th>Term</th>
			<th>Course</th>
			<th>Grade</th>
			<th></th>
		</tr>
		<c:forEach items="${gradeRecords}" var="gradeRecord">
			<tr data-gr-id="${gradeRecord.id }">
				<td>${gradeRecord.term.fullName}</td>
				<td>${gradeRecord.course.code}</td>
				<td style="text-align: center">${gradeRecord.grade.symbol}</td>
				<td><button class="deleteBtn">Delete</button></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
