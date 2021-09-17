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
			<div class="container mt-4">
				<div class="row gy-4">
					<div class="col-lg-7">
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
					<div class="col-lg-5">
						<div class="card shadow-lg p-4" data-aos="fade-up">
							<form action="processRegister" onsubmit="return checkUserInfo()" method="post" enctype="multipart/form-data">
								<div class="row gy-4 text-start">
									<div>
										<h2>회원가입</h2>
									</div>
									<div class="col-md-12">
										<input type="email" id ="mem_email" class="form-control" name="memEmail" placeholder="이메일" required>
										<div class="mt-2"><span id = "mem_email_note"></span></div>
									</div>
									<div class="col-md-6">
										<input id="mem_pw" name = "memPw" class="form-control" placeholder="비밀번호" type="password" required>
        								<div class="mt-2"><span id ="mem_pw_note"></span></div>
									</div>
									<div class="col-md-6">
										<input id="mem_pwconf" class="form-control" placeholder="비밀번호 확인" type="password" required>
        								<div class="mt-2"><span id="mem_pwconf_note"></span></div>
									</div>
									<div class="col-md-8">
										<input type="tel" id="mem_tel" name="memTel" class="form-control" onkeypress="return isNumber(event)" required style="width : 100%">
     									<div class="mt-2"><span id = "mem_tel_note"></span></div>
     									<input type= "hidden" id = "verified_phonenum" name ="verifiedPhonenum">
									</div>
									<div class="col-md-4">
										<input type="button" class="btn btn-outline-secondary" value="인증번호 보내기" onclick = "process(event)" id = "sendSMSBtn"/>
									</div>
									<div class="col-md-6">
										<input class="form-control" style = "display: none" id = "verifyInput" placeholder = "인증번호" onkeypress="return isVeriNumber(event)">
										<span id = "countdown" style = "display: none"></span>
										<input type = "hidden" id = "verifyAnswer">
									</div>
									<div class="col-md-2">
										<input class="btn btn-outline-secondary" style = "display: none" id = "verifyBtn" type = "button" value = "확인" onclick = "submitCode()">
									</div>									
									
     								<div class="col-md-6">
										<input type="text" class="form-control" id="mem_name" name="memName" placeholder="이름" required>
        								<div class="mt-2"><span id = "mem_name_note"></span></div>
									</div>
									<div class="col-md-6">
										<fieldset class="form-group d-flex form-control justify-content-around">
												<!-- <div class="form-check"> -->
													<label class="form-check-label">
														<input type="radio" class="form-check-input" name="memGender" id="optionsRadios1" value="남자" required checked="checked"> 
														남자
													</label>
													<!-- </div> -->
												<!-- <div class="form-check ms-3"> -->
												<label class="form-check-label">
														<input type="radio" class="form-check-input" name="memGender" id="optionsRadios2" value="여자" required>
														여자
												</label>
												<!-- </div> -->
										</fieldset>
									</div>
										<hr>
									<div>
										<h2>선택입력</h2>
									</div>
									<div class="col-md-12">
  										<div class="form-group">
  											<span>생일</span>
    										<input type="date" class="form-control" id="birth" name="memBirth">
  										</div>									
									</div>
									<div class="col-md-12">
										 <!-- 프로필 -->   
     									<div class="form-group">
     									<span>프로필사진</span>
        								<input id="memprofile" name="memProfileFile" class="form-control" type="file">
    									</div> 
									</div>
									<hr>
									<div class="text-lg-start d-flex justify-content-around">
										<button type="submit" class="btn-get-started">회원가입</button>
										<a href="home"	class="btn-get-started ">
											<span>로그인</span>
										</a>
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
	<%@ include file="includes/script.jsp"%>
</body>
<script type="text/javascript">
	
		/* #mem_tel에 숫자만 허용하기 위한 함수 */
		function isNumber(evt) {
		    evt = (evt) ? evt : window.event;
		    var charCode = (evt.which) ? evt.which : evt.keyCode;
		    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		        return false;
		    }
		    return true;
		}
		
		
		/* 유효값 boolean 변수 */
		
		var validEmail = false;
		var validPw = false;
		var validPwConf = false;
		var validName = false;
		var validTel = false;
		
		
		
		/* 이메일 형식과 중복체크를 위한 KEYUP */
		
		$("#mem_email").focusout(function() {		
			 $.ajax({
					async: false,
					data: {
						"mem_email" : $("#mem_email").val()
					},
					url: "checkEmail",
					type: "get",
					success: function(result) {
						if(result == "valid"){
							$("#mem_email_note").text("사용 가능한 이메일입니다").css("color", "green");
							validEmail = true;
							
						}else if(result == "hasDuplicate"){
							$("#mem_email_note").text("중복된 이메일입니다").css("color", "red");
							validEmail = false;
						}else if(result == "invalid"){
							$("#mem_email_note").text("사용 불가능한 이메일입니다").css("color", "red");
							validEmail = false;
						}else if(result == "overlimit"){
							$("#mem_email_note").text("글자 수를 초과했습니다").css("color", "red");
							validEmail = false;
						}
					}
					
					
				}) 
				
		
		});
		
		
		
		/* 비밀번호와 비밀번호 확인 KEYUP */
		
		$("#mem_pw").focusout(function() {
			if($("#mem_pw").val().length >= 4 && $("#mem_pw").val().length <= 20){	
				$("#mem_pw_note").text("사용 가능한 비밀번호").css("color", "green");
				$("#conf_div").css("display","");
				$("#mem_pwconf").val("");
				$("#mem_pwconf_note").text("");	
				validPw = true;
			}else{
				$("#mem_pw_note").text("사용할 수 없는 비밀번호").css("color", "red");
				$("#conf_div").css("display","none");
				validPw = false;
			}
			
			
			
		})
	
		$("#mem_pwconf").keyup(function() {
			if($("#mem_pwconf").val() == $("#mem_pw").val()){
				$("#mem_pwconf_note").text("일치하는 비밀번호입니다").css("color", "green");
				validPwConf = true;
			}else{
				$("#mem_pwconf_note").text("일치하지 않는 비밀번호입니다").css("color", "red");
				validPwConf = false;
			}
			
		})
		
		/* 이름을 위한 keyup */
		$("#mem_name").keyup(function() {
			if($("#mem_name").val().length >= 1 && $("#mem_name").val().length <= 10){
				$("#mem_name_note").text("사용가능한 이름입니다").css("color", "green");
				validName = true;
			}else{
				$("#mem_name_note").text("사용할 수 없는 이름입니다(1~10자 이내)").css("color", "red");
				validName = false;
			}
			
			
		})
		
		/* 전화번호 KEYUP이 될때마다 validTel를 false로 바꿈 */
		
		$("#mem_tel").keyup(function() {
			$("#mem_tel_note").html("값이 변경되었습니다<br> 다시 인증해주세요").css("color" , "red");
			validTel = false;
		});
		
		
		/* 모든 값 입력후 유효한 정보인지 확인 하는 함수 */
		function checkUserInfo() {
			
			if(validEmail){
				if(validPw){
					if(validPwConf){
						if(validTel){
							if(validName){
								return true;
							}else{
								$("#mem_name_note").text("사용할 수 없는 이름입니다").css("color", "red");
								$("#mem_name").focus();
							}
						}else{
							$("#mem_tel_note").text("전화번호를 제대로 입력하시오").css("color", "red");
							$("#mem_tel").focus();
						}
					}else{
						$("#mem_pwconf_note").text("비밀번호 확인를 제대로 입력하시오").css("color", "red");
						$("#mem_pwconf").focus();
					}
				}else{
					$("#mem_pw_note").text("비밀번호를 제대로 입력하시오").css("color", "red");
					$("#mem_pw").focus();
				}
				
			}else{
				$("#mem_email_note").text("이메일을 제대로 입력하시오").css("color", "red");
				$("#mem_email").focus();
			}	
			return false;
		}
		
		<!-- intelTelInput 스크립트 -->
		
		function getIp(callback) {
			 fetch('https://ipinfo.io/json?token=54434d39cefbf4', { headers: { 'Accept': 'application/json' }})
			   .then((resp) => resp.json())
			   .catch(() => {
			     return {
			       country: 'us',
			     };
			   })
			   .then((resp) => callback(resp.country));
			}

		
		
	   const phoneInputField = document.querySelector("#mem_tel");
	   const phoneInput = window.intlTelInput(phoneInputField, {
		 initialCountry: "auto",
		 geoIpLookup: getIp,
	     utilsScript:
	       "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
	   });
	   
	   const info = document.querySelector(".alert-info");
		
	   /* 전화번호 입력시 국제표준형식으로 변환한 뒤 sendSMS 호출 */
	   function process(event) {
		    event.preventDefault();

		    const phoneNumber = phoneInput.getNumber();
			
		    
		    if(phoneNumber.length > $("#mem_tel").val().length){
		    	sendSMS(phoneNumber); 
		    	$("#verified_phonenum").val(phoneNumber);
		    }else{
		    	validTel = false;
		    	$("#mem_tel_note").text("형식에 맞지 않는 번호입니다").css("color" , "red");	
		    }
		    
		}
	   /* 해당번호로 인증문자 발송 */
	   function sendSMS(phoneNumber) {
		   
			$.ajax({
				type: "get",
				async: false,
				url: "sendSMS?phoneNumber=" + phoneNumber,
				success: res=>{
					console.log(res);
					clearInterval(intvl);
					$("#sendSMSBtn").val("다시 보내기");				
					$("#verifyAnswer").val(res);					
					timeRemaining = setTime;	
					triesRemaining = setTry;
					intvl = setInterval(updateCountdown, 1000);	
					$("#verifyInput").css("display", "").val("").removeAttr("disabled");
					$("#verifyBtn").css("display", "");
					$("#countdown").text("").css("display", "").css("color", "black");
					$("#mem_tel_note").text("");
					$("#verifyInput").val(res);
				}
				
			})
		   
	}
	   /* 인증번호 입력후 submit시 인증결과 출력 */
	   function submitCode() {	 	  
		if($("#verifyAnswer").val() == $("#verifyInput").val()){			
			$("#mem_tel_note").text("인증이 완료됐습니다").css("color", "green");
			$("#verifyInput").css("display", "none");
			$("#verifyBtn").css("display", "none");
			$("#sendSMSBtn").css("display", "none");
			$("#mem_tel").attr('disabled', 'disabled');
			$("#countdown").css("display", "none");
			clearInterval(intvl);
			validTel = true;
		}else{
			validTel = false;	 
			$("#verifyInput").val("");	
			$("#verifyBtn").attr("disabled", "disabled");
			if(--triesRemaining <= 0){
				$("#mem_tel_note").text("사용할 수 있는 시도수를 초과했습니다 다시보내기를 눌러주세요").css("color" , "red");
				$("#verifyInput").attr("disabled", "disabled");
				$("#countdown").text("");				
				clearInterval(intvl);
			}else{				
				$("#verifyInput").focus();
				$("#mem_tel_note").text("잘못된 인증번호입니다 남은 시도수: " + triesRemaining).css("color" , "red");	
			}
			   	
		}
	}
	   
		let setTime = 85; 			//인증입력 시간제한(초)
		let timeRemaining = 0; 		//현재 남은 인증시간 
		let setTry = 5;				//시도횟수 
		let triesRemaining = 0;		//현재 남은 시도횟수
		let intvl = null;			//setInterval & clearInterval를 설정하기 위한 변수
		
		/* 인증번호 change keyup paste 될떄마다 6글자인지 확인 */
		 $("#verifyInput").on("change keyup paste", function() {
			if($("#verifyInput").val().length == 6){
				$("#verifyBtn").removeAttr("disabled");
			}else{
				$("#verifyBtn").attr("disabled", "disabled");
			}
		}) 
		
		
		
		/* setInterval이 설정되면 1초마다 호출 */
		function updateCountdown() {
			console.log("vi in upcodo: " + $("#verifyInput").val());
			let currentMin = Math.floor(timeRemaining / 60); 
			let currentSec = ('0' + timeRemaining % 60).slice(-2);
			timeRemaining--;
			console.log("interval");
			$("#countdown").text("남은시간 " + currentMin + ":" + currentSec);
			if(timeRemaining < 0){
				console.log("시간경과");
				$("#countdown").text("시간이 경과되었습니다 다시보내기를 눌러주세요").css("color", "red");
				$("#verifyInput").attr("disabled", "disabled");
				$("#verifyBtn").attr("disabled", "disabled");
				clearInterval(intvl);
			}
		}
	   
	  /* 인증번호에 숫자와 6글자 이하만 하도록 하는 함수 */
		function isVeriNumber(evt) {
			evt = (evt) ? evt : window.event;
		    var charCode = (evt.which) ? evt.which : evt.keyCode;
		    
		    if (charCode > 31 && (charCode < 48 || charCode > 57)) {    	
		        return false;
		    }else if($("#verifyInput").val().length >= 6){
		    	return false;
		    }
		    return true;
		}
</script>
</html>