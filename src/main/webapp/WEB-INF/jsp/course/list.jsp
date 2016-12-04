<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Courses</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>

function editCourse() {
	var courseId = $("input[name='id']").val();
	$.ajax({
		url: "../service/course/" + courseId,
		method: "PUT",
		dataType: "json",
		processData: false,
		contentType: "application/json",
		data: JSON.stringify({
			code: $("input[name='code']").val(),
			name: $("input[name='courseName']").val(),
			units: $("input[name='units']").val(),
			obsolete: $("input[name='obsolete']").prop('checked')
		}),
		statusCode: {
			200: function() {
				console.log('Received 200 status code.');
				var rowToUpdate = $("tr[data-course-id='" + courseId + "']");
				rowToUpdate.find("td[data-field='code']").html($("input[name='code']").val());
				rowToUpdate.find("td[data-field='name']").html($("input[name='courseName']").val());
				rowToUpdate.find("td[data-field='units']").html($("input[name='units']").val());
			}
		}
	});
	
}
$(function() {
	$("#course-form").dialog({
		autoOpen: false,
		close: function(event, ui) {
			$("input[name='id']").val('');
		},
		buttons: {
			"Save": function() {
				if (! $("input[name='id']").val()) console.log('id is empty');
				else editCourse();
				$(this).dialog("close");
			}			
		}
	});
	
	$(".editCourse").click(function() {
		var rowToEdit = $(this).closest("tr")
		var courseId = rowToEdit.attr("data-course-id");
		console.log('Course id: ' + courseId);
		var code = rowToEdit.find("td[data-field='code']").html();
		console.log('Code: ' + code);
		var name = rowToEdit.find("td[data-field='name']").html();
		var units = rowToEdit.find("td[data-field='units']").html();
		var obsolete = false;
		
		$("input[name='code']").val(code);
		$("input[name='courseName']").val(name);
		$("input[name='units']").val(units);
		$("input[name='obsolete']").prop('checked', obsolete);
		$("input[name='id']").val(courseId);
		
		$("#course-form").dialog("open");
	});
});
</script>
</head>
<body>
	<h2>
		<a href="..">OnCourse</a>
	</h2>
	<h3>Courses</h3>
	<p>
		<a href="add">Add Course</a>
	</p>
	<table border="1">
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Units</th>
			<th></th>
		</tr>
		<c:forEach items="${courses}" var="course">
			<tr data-course-id="${course.id }">
				<td data-field="code">${course.code}</td>
				<td data-field="name">${course.name}</td>
				<td data-field="units" style="text-align: center;">${course.units}</td>
				<td><button class="editCourse">Edit</button></td>
			</tr>
		</c:forEach>
	</table>

	<div id="course-form">
		<form>
			<table>
				<tr>
					<th>Code</th>
					<td><input name="code" type="text" /></td>
				</tr>
				<tr>
					<th>Name</th>
					<td><input name="courseName" type="text" /></td>
				</tr>
				<tr>
					<th>Unit</th>
					<td><input name="units" type="text" /></td>
				</tr>
				<tr>
					<th>Obsolete</th>
					<td><input name="obsolete" type="checkbox" /></td>
				</tr>
			</table>
			<input name="id" type="hidden" />
		</form>
	</div>
</body>
</html>
