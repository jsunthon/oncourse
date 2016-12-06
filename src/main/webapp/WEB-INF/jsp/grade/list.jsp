<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Grades</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#addGrade").click(addGrade);

		$("#searchCourse").autocomplete({
			source : '../service/course/search',
			minLength : 1,
			select : function(event, ui) {
				$("#searchCourseId").val(ui.item.id);
			}
		});
	});
	function addGrade() {
		console.log('Add grade called.');

		var season = $("select[name='season']").val();
		var year = $("select[name='year']").val();
		var courseId = $("#searchCourseId").val();
		var gradeId = $("select[name='gradeId']").val();
		$.ajax({
			url : "../service/grade",
			method : "POST",
			dataType : "json",
			processData : false,
			contentType : "application/json",
			data : JSON.stringify({
				season : season,
				year : year,
				courseId : courseId,
				gradeId : gradeId
			}),
			success : function(gradeRecord) {
/* 				console.log(JSON.stringify(gradeRecord)); */
				var $newRow = $("<tr>" + "<td>" + gradeRecord.term.fullName
						+ "</td>" + "<td>" + gradeRecord.course.code + "</td>"
						+ "<td style='text-align: center'>"
						+ gradeRecord.grade.symbol + "</td></tr>");
				$("#grades").append($newRow);
			}
		});
	}
</script>
</head>
<body>
	<h2>
		<a href="..">OnCourse</a>
	</h2>
	<h3>${user.name}'sGrades</h3>
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
		</select> Course Search <input id="searchCourse" type="text" /> <input
			id="searchCourseId" type="hidden" /> <select name="gradeId">
			<c:forEach items="${grades}" var="grade">
				<option value="${grade.id}">${grade.symbol}</option>
			</c:forEach>
		</select>
		<button id="addGrade">Add</button>
	</p>

	<table id="grades" border="1">
		<tr>
			<th>Term</th>
			<th>Course</th>
			<th>Grade</th>
		</tr>
		<c:forEach items="${gradeRecords}" var="gradeRecord">
			<tr>
				<td>${gradeRecord.term.fullName}</td>
				<td>${gradeRecord.course.code}</td>
				<td style="text-align: center">${gradeRecord.grade.symbol}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
