<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="includes/Links.jsp"%>
</head>
<body>
	<header id="header" class="header fixed-top">
		<div
			class="container-fluid d-flex align-items-center justify-content-between">
			<a href="main" class="d-flex align-items-center logo"> <img
				src="${pageContext.request.contextPath }/resources/assets/img/logo/ILBO-logo.png"
				alt="">
			</a>

			<nav id="navbar" class="navbar">
				<ul>
					<li><a class="nav-link scrollto" href="home"><i
							class="fas fa-user"></i></a></li>
					<li><a class="nav-link scrollto" href="home"><i
							class="fas fa-home"></i></a></li>
					<li><a class="nav-link scrollto" href="home"><i
							class="fas fa-bell"></i></a></li>
					<li id="sidebarMenu"><a class="nav-link scrollto"
						href="bookmark"><i class="fas fa-plane"></i></a></li>
				</ul>
			</nav>

			<nav class="navbar">
				<ul>
					<li><a class="nav-link scrollto" href="messanger"><i
							class="far fa-paper-plane"></i></a></li>
					<li><a href="alarm"> <i class="far fa-bell"></i> <span
							class="mobile-nav-toggle-menu">mobile-nav-toggle-menu</span>
					</a></li>
					<li class="dropdown">
						<a href="#">
							<span>
								<img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle">
							</span>
						</a>
						<ul>
							<li><a href="memberInformation">내 정보보기</a></li>
							<li><a href="#"><span>Deep Drop Down</span></a> <!-- <ul>
									<li><a href="#">Deep Drop Down 1</a></li>
									<li><a href="#">Deep Drop Down 2</a></li>
									<li><a href="#">Deep Drop Down 3</a></li>
									<li><a href="#">Deep Drop Down 4</a></li>
									<li><a href="#"><i></i></a></li>
								</ul></li> -->
							<li><a href="#">Drop Down 2</a></li>
							<li><a href="#">Drop Down 3</a></li>
							<li><a href="logout">로그아웃</a></li>
						</ul></li>
				</ul>
				<i class="bi bi-list mobile-nav-toggle"></i>
			</nav>
			<!-- .navbar -->
		</div>
		<div class="wrapper d-flex align-items-stretch">
			<nav id="bookmark">
				<div class="p-4">
					<ul class="list-unstyled components mb-5">
						<li class="active">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle">
							<span>내 정보보기</span></a>
						</li>
						<li>
							<a href="#">
							<i class="fas fa-virus"></i>
							<span>내 정보보기</span></a>
						</li>
						<li><a href="#"><span class="fa fa-briefcase mr-3"></span>
								Works</a></li>
						<li><a href="#"><span class="fa fa-sticky-note mr-3"></span>
								Blog</a></li>
						<li><a href="#"><span class="fa fa-suitcase mr-3"></span>
								Gallery</a></li>
						<li><a href="#"><span class="fa fa-cogs mr-3"></span>
								Services</a></li>
						<li><a href="#"><span class="fa fa-paper-plane mr-3"></span>
								Contacts</a></li>
						<li><div>&copy; Copyright <strong><span>ILBO</span></strong>. All Rights	Reserved. Designed by ABCD</div>
							</li>
					</ul>
				</div>
			</nav>
		</div>
		
	</header>
	<%@ include file="includes/script.jsp"%>
</body>
</html>