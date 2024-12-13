<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>YOLOv5 Image Detection</title>
</head>
<body>
    <h1>YOLOv5 이미지 탐지</h1>
    <form action="uploadImage" method="post" enctype="multipart/form-data">
        <label for="image">이미지 업로드:</label>
        <input type="file" name="image" id="image" accept="image/*" required>
        <button type="submit">분석</button>
    </form>

    <c:if test="${not empty prediction}">
        <h2>결과:</h2>
        <img src="${prediction.image}" alt="탐지 결과">
        <pre>${prediction.data}</pre>
    </c:if>
</body>
</html>
