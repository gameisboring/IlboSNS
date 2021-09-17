<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="includes/Links.jsp"%>
</head>
<body>
	<header>
		<div>
			<nav id="navbar" class="navbar">
				<i class="bi bi-list mobile-nav-toggle" style="display: none"></i>
			</nav>
		</div>
	</header>
	<main id="main">
		<section id="hero" class="hero d-flex align-items-center">
			<div class="container mt-4">
				<div class="row gy-4">
					<div class="col-lg-8" data-aos="fade">
						<div class="row gy-4">
							<div class="col-lg-12 text-center ">
								<img src="${pageContext.request.contextPath }/resources/assets/img/logo/ILBO-logo.png">
								<header class="section-header">
									<p>ILBO에서 전세계에 있는 친구, 가족, 지인들과 함께 이야기를 나눠보세요.</p>
								</header>
							</div>
						</div>
					</div>
					<div class="col-lg-4" data-aos="slide-up">
						<div class="card shadow-lg p-4">
							<form action="login" method="post">
								<div class="row gy-4 text-center my-4">
									<h2>로그인</h2>
									<c:if test="${result != null}">
										<span style="color:${resultColor}">${result }</span>
									</c:if>
									<div class="col-md-12">
										<input type="email" class="form-control" name="memEmail" placeholder="이메일을 입력하세요" required>
									</div>
									<div class="col-md-12">
										<input type="password" class="form-control" name="memPw" placeholder="비밀번호를 입력하세요" required>
									</div>
									<div>
										<div class="text-lg-start d-flex justify-content-around">
											<input type="submit" value="로그인" class="btn-get-started">
										</div>
										<div class="text-lg-start d-flex justify-content-center mt-4">
											<a href="MemberId_Pw_Find">
												<span>계정을 잊어버리셨나요?</span>
											</a>
										</div>
									</div>
									<hr>
									<div>
										<div class="text-lg-start d-flex justify-content-around">
											<a href="register" class="btn-get-started scrollto d-inline-flex align-items-center justify-content-center align-self-center">
												<span>회원가입</span>
											</a>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->
	<!-- ======= Footer ======= -->
	<%@ include file="includes/Footer.jsp"%>
	<%@ include file="includes/script.jsp"%>
</body>
</html>