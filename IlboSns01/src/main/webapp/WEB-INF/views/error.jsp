<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="includes/Links.jsp"%>

</head>
<body>
	<section id="error">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h1>${errorMsg}</h1>
				<img alt="errorimg"
					src="${pageContext.request.contextPath }/resources/assets/img/paperPlane.png">
			<p>페이지를 찾을 수 없습니다 ㅜㅜ</p>
			<button class="btn btn-primary" onclick="location.href='main'">메인으로</button>
			</div>
		</div>
	</section>
	<!-- End #main -->
	<!-- ======= Footer ======= -->
	<%@ include file="includes/Footer.jsp"%>
	<%@ include file="includes/script.jsp"%>
</body>