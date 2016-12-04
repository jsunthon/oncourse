<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Course signup</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
	$(function() {
		$("#searchTerm").autocomplete({
			source: "service/course/search",
			minLength: 2
		});
		$("#tabs").tabs();
	});
</script>
</head>
<body>
	<h1>Course signup</h1>

	<table>
		<tr>
			<td>Search for a course</td>
			<td><input type="text" id="searchTerm" /></td>
			<td><button id="Add">Add</button></td>
		</tr>
	</table>

	<table>
		<tr>
			<th>Term</th>
			<th>Course</th>
		</tr>
		<c:forEach items="${gradeRecords }" var="gradeRecord">
			<tr>
				<td>${gradeRecord.term.fullName }</td>
				<td>${gradeRecord.course.code }</td>
			</tr>
		</c:forEach>
	</table>

	<div id="tabs">
		<ul>
			<li><a href="#tab0">First Tab</a></li>
			<li><a href="#tab1">Second Tab</a></li>
			<li><a href="#tab2">Third Tab</a></li>
		</ul>
		<div id="tab0">Proin elit arcu, rutrum commodo, vehicula tempus,
			commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet
			mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et
			lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper
			leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci.
			Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam
			molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut
			dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique
			tempus lectus.</div>
		<div id="tab1">Morbi tincidunt, dui sit amet facilisis feugiat,
			odio metus gravida ante, ut pharetra massa metus id nunc. Duis
			scelerisque molestie turpis. Sed fringilla, massa eget luctus
			malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor.
			Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula
			suscipit aliquam. Praesent in eros vestibulum mi adipiscing
			adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean
			vel metus. Ut posuere viverra nulla. Aliquam erat volutpat.
			Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium
			posuere, felis lorem euismod felis, eu ornare leo nisi vel felis.
			Mauris consectetur tortor et purus.</div>
		<div id="tab2">Mauris eleifend est et turpis. Duis id erat.
			Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan,
			mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non
			ante. Class aptent taciti sociosqu ad litora torquent per conubia
			nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel
			enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus
			pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a,
			lacus. Duis cursus. Maecenas ligula eros, blandit nec, pharetra at,
			semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra
			justo vitae neque. Praesent blandit adipiscing velit. Suspendisse
			potenti. Donec mattis, pede vel pharetra blandit, magna ligula
			faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque.
			Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi
			lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean
			vehicula velit eu tellus interdum rutrum. Maecenas commodo.
			Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus
			hendrerit hendrerit.</div>
	</div>
</body>
</html>