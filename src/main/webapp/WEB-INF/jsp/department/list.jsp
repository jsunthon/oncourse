<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnCourse - Departments</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	function addDepartment() {
		var departmentName = $("#departmentName").val();
		$.ajax({
			url : '../service/department/' + departmentName,
			method : "POST",
			data : JSON.stringify({
				name : departmentName
			}),
			success : function(data) {
				var $newRow = $("<tr data-department-id='" + data.id + "'><td>" + data.name + "</td>" +
				"<td style='text-align: center'>" + data.programs.length + "</td>" +
				"<td><a href='javascript:void(0)' class='deleteDepartment'>Delete</a></td>" +
				"</tr>");
				$("#departments").append($newRow);
				
				$newRow.find(".deleteDepartment").click(deleteDepartment);
			}
		});
	}
	
	function deleteDepartment() {
		var departmentId = $(this).closest("tr").attr("data-department-id");
		console.log('Department id: ' + departmentId);
		$.ajax({
			url: '../service/department/' + departmentId,
			method: "DELETE",
			context: $(this),
			success: function() {
				console.log('Delete department successful.');
				$(this).closest("tr").remove();
			}
		});
	}

	$(function() {
		$("#addDepartmentDialog").dialog({
			autoOpen : false,
			buttons : {
				"Save" : function() {
					console.log('Save called.');
					addDepartment();
					$(this).dialog("close");
				}
			}
		});

		$("#addDepartment").click(function() {
			$("#addDepartmentForm")[0].reset();
			$("#addDepartmentDialog").dialog("open");
		});
		
		$(".deleteDepartment").click(deleteDepartment);
	})
</script>
</head>
<body>
	<h2>
		<a href="..">OnCourse</a>
	</h2>
	<h3>Departments</h3>
	<button id="addDepartment">Add Department</button>
	<div id="addDepartmentDialog">
		<form id="addDepartmentForm">
			<label for="departmentName">Department Name</label>
			<input id="departmentName" type="text" />
		</form>
	</div>
	<table id="departments" border="1">
		<tr>
			<th>Name</th>
			<th>Programs</th>
			<th>Operations</th>
		</tr>
		<c:forEach items="${departments}" var="department">
			<tr data-department-id="${department.id }">
				<td>${department.name}</td>
				<td style="text-align: center">${fn:length(department.programs)}</td>
				<td><a href="javascript:void(0)" class="deleteDepartment">Delete</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
