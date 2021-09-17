<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="includes/Links.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="includes/HomeHeader.jsp"%>
	<div class="row gy-4 d-flex justify-content-center" style="margin-top: 102px">
		<div class="col-lg-3">
			<nav id="sidebar">
				<div class="p-4">
					<ul class="list-unstyled components mb-5">
						<li class="active"><a href="searchTop?q=${q}">
								<span class="fa fa-home mr-3"></span> 모두
							</a></li>
						<li><a href="searchPeople?q=${q}">
								<span class="fa fa-user mr-3"></span> 사람
							</a></li>
						<li><a href="searchPosts?q=${q}">
								<span class="fa fa-sticky-note mr-3"></span> 게시글
							</a></li>
						<li><a href="#">
								<span class="fa fa-suitcase mr-3"></span> Blog
							</a></li>
						<li><a href="#">
								<span class="fa fa-cogs mr-3"></span> Services
							</a></li>
						<li><a href="#">
								<span class="fa fa-paper-plane mr-3"></span> Contacts
							</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<div class="col-lg-9">
			<!-- ======= Values Section ======= -->
			<section id="newsfeed" class="newsfeed">
				<div class="container" data-aos="fade-up">
					<div class="row">
						<c:forEach items="${memberList}" var="memList">
							<div class="col-6">
								<div class="card mt-3">
									<div class="card-header">
										<h2>${memList.memName}</h2>
									</div>
									<div class="d-flex p-3">
										<img src="${pageContext.request.contextPath }/resources/assets/img/profile/${memList.memProfile}" height="150px" width="150px" style="border-radius: 50%; object-fit: cover;">
										<div class="d-flex flex-column ms-3">
											<c:choose>
												<c:when test="${memList.memCompany != null}">
													<h4>${memList.memCompany}</h4>
												</c:when>
												<c:otherwise>
													<h4 class="">직장없음</h4>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${memList.memSchool != null}">
													<h4>${memList.memSchool}</h4>
												</c:when>
												<c:otherwise>
													<h4 class="">학교정보 없음</h4>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
			<!-- End Values Section -->
		</div>
	</div>
	<%@ include file="includes/Footer.jsp"%>
	<%@ include file="includes/script.jsp"%>
</body>
</html>