<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Object Detection</title>
</head>
<body>
	<h1>Object Detection Result</h1>
	<form action="/upload" method="post" enctype="multipart/form-data">
		<label for="file">Upload an image:</label> <input type="file"
			name="file" id="file" required>
		<button type="submit">Upload</button>
	</form>
	<c:if test="${not empty resultImage}">
		<h2>Original Image</h2>
		<img src="${originalImage}" alt="Original Image"
			style="max-width: 500px;">
		<h2>Detected Objects</h2>
		<img src="${resultImage}" alt="Detected Image"
			style="max-width: 500px;">
		<h3>Detected Object Details</h3>
		<ul>
			<c:forEach var="detection" items="${detections}">
				<li>Object: ${detection['name']} <br> Confidence:
					${detection['confidence']}% <br> Location:
					[${detection['x_min']}, ${detection['y_min']}],
					[${detection['x_max']}, ${detection['y_max']}]
				</li>
			</c:forEach>
		</ul>
	</c:if>
</body>
</html>
