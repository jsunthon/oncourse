<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" 
           uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Student Status</title>
</head>
<body>
	<h2>
		<a href="index.html">OnCourse</a>
	</h2>
	<h1>Progress:
		<c:choose>
		<c:when test="${fn:length(offTrackGradeRecords) gt 0}">YOU ARE OFF COURSE!</c:when>
		<c:otherwise>You're on course.</c:otherwise>
		</c:choose>
	</h1>

	<h1>My program</h1>
	<p>${userProgram.name }</p>

	<hr />

	<h3>Courses off track (${fn:length(offTrackGradeRecords)})</h3>
	<i>Note: These are courses that either:<br/>
	1) Count towards the program but you are receiving a failing grade.<br/>
	2) Doesn't count towards the program at all.
	</i>
	<c:forEach items="${offTrackGradeRecords }" var="offTrackGradeRecord">
		<p>Term: ${offTrackGradeRecord.term.fullName }
		<p>Course Name: ${offTrackGradeRecord.course.name }</p>
		<p>Grade: ${offTrackGradeRecord.grade.symbol }</p>
		<p>Units ${offTrackGradeRecord.course.units }</p>
		----------------------------------------------------------
	</c:forEach>
	
	<hr />
	
	<c:forEach items="${userProgram.blocks }" var="block">
		<h3>${block.name}</h3>
		<c:forEach items="${block.courses }" var="course">
			<p>${course.name}-${course.units }</p>
		</c:forEach>
		<hr />
	</c:forEach>
</body>
</html>