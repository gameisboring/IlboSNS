<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="../includes/Links.jsp"%>
   <script type="text/javascript">
 		function checkPw(){
 			console.log("비밀번호 비교");
 			var Id_NewPw = $("#Id_NewPw").val();
 			var Id_NewPwCheck = document.getElementById('Id_NewPwCheck').value;
 			console.log("Id_NewPw = "+ Id_NewPw);
 			console.log("Id_NewPwCheck = "+ Id_NewPwCheck);
 			if(Id_NewPw != Id_NewPwCheck){
 				alert("비밀번호가 일치하지않습니다.");
 				$("#Id_NewPw").val("");
 				$("#Id_NewPwCheck").val("");
 				$("#Id_NewPw").focus();
 				return false;
 			} else {
 				return true;
 			}
 		
 			}
   
   			var pwfalse = '${pwfalse}';
   			if(pwfalse !=''){
	   		alert(pwfalse);
   		}
   
   		</script>
 
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
			<div class="container mt-4" data-aos="fade-up">
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
					<div class="col-lg-4">
						<div class="card shadow-lg p-4">
							<h3 class="text-center font-weight-light my-4">새로운 비밀번호 입력</h3>
							<p class="mx-4 mb-0">새로 변경 할 비밀번호를 입력해주세요</p>
						<div class="card-body">
                        	<form action="MemberNewPw" method="post" onsubmit='return checkPw();'>
                                    <input type="hidden" name="memail" value="${sessionScope.email}">
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="Id_NewPw" type="password"  name="Id_NewPw" />
                                    	<label for="Id_NewPw">새 비밀번호</label>
                                    </div>
									<div class="form-floating mb-3">
                                        <input class="form-control" id="Id_NewPwCheck" type="password" />
                                    	<label for="Id_NewPwCheck">새 비밀번호 확인</label>
                                    </div>
                                            
                                    <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                                
                                	<button class="btn btn-primary">비밀번호 변경</button>
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
