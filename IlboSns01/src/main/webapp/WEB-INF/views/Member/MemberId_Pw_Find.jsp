<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/Links.jsp"%>
</head>
<body>
	<header id="header" class="header fixed-top">
		<div class="container-fluid container-xl d-flex align-items-center justify-content-end">
			<a href="main" class="d-flex align-items-center">
			</a>
			<nav id="navbar" class="navbar">
				<i class="bi bi-list mobile-nav-toggle" style="display : none"></i>
			</nav>
		</div>
	</header>
	<main id="main">
		<section id="hero" class="hero d-flex align-items-center">
			<div class="container mt-4" >
				<div class="row gy-4">
					<div class="col-lg-8">
						<div class="row gy-4">
							<div class="col-lg-12 text-center ">
								<a href="home"> <img
									src="${pageContext.request.contextPath }/resources/assets/img/logo/ILBO-logo.png"></a>
								<header class="section-header">
									<p>ILBO에서 전세계에 있는 친구, 가족, 지인들과 함께 이야기를 나눠보세요.</p>
								</header>
							</div>
						</div>
					</div>
					<div class="col-lg-4" data-aos="fade-up">
						<div class="card shadow-lg p-4">
							<h3 class="text-center font-weight-light my-4">로그인에 문제가 있나요?</h3>
							<p class="mx-4 mb-0">이름과 이메일 주소를 입력하시면<br>비밀번호 설정을 위한 <br>인증번호를 보내드립니다</p>
						<div class="card-body">
							<form action="MemberFind" method="post">

								<div class="form-floating mb-3">
									<input class="form-control" id="find_name" type="text"
										name="findName" /> <label for="find_name">이름</label>
								</div>
								<div class="form-floating mb-3">
									<input class="form-control" id="find_email" type="text"
										name="findEmail" /> <label for="find_email">이메일</label>
								</div>

								<div class="d-flex align-items-center justify-content-between mt-4 mb-0">
									<button class="btn btn-primary" id="findBtn">비밀번호 찾기</button>
								</div>
							</form>
						</div>
						<div class="text-center p-3">
							<div class="small">
								<a href="${pageContext.request.contextPath }/">홈으로</a>
							</div>
							<br>
							<div class="small">
								<a href="${pageContext.request.contextPath }/home">회원가입</a>
							</div>
						</div>
					</div>
				</div>
				</div>

			</div>

		</section>
	</main>
	<main>
		<div class="container">
			<div class="row justify-content-center">
				
			</div>
		</div>
	</main>
	<!-- End #main -->
	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="container">
			<div class="copyright">
				&copy; Copyright <strong><span>ILBO</span></strong>. All Rights
				Reserved
			</div>
			<div class="credits">Designed by ABCD</div>
		</div>
	</footer>
	<!-- End Footer -->
	<%@ include file="../includes/script.jsp"%>
</body>
</html>
