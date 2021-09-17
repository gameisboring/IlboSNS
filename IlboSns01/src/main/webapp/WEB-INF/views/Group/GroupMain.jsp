<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/Links.jsp"%>
<style type="text/css">
h6 {
	font-size: 0.80rem;
	color: #555f86;
}

.textRq::before {
	content: "가입 요청중"
}

.textGp::before {
	content: "그룹 가입"
}
</style>
</head>
<body>
	<%@ include file="../includes/HomeHeader.jsp"%>
	<!-- Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">새 그룹 만들기</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
				<form action="groupCreate" method="post">
					<input type="hidden" value="${sessionScope.loginId}" name="gpMember">
					<div class="modal-body">
						<div class="d-flex justify-content-start">
							<a href="#">
								<span> <img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle" style="width: 50px; height: 50px;"></span>
							</a>
							<div class="px-3">
								<div>${sessionScope.loginName}</div>
								<input type="hidden" value="${sessionScope.loginId}" name="gpManager">
								<h6>관리자</h6>
							</div>
						</div>
						<div role="textbox" style="margin-top: 15px;">
							<div class="form-floating mb-3">
								<input class="form-control" id="groupName" type="text" placeholder="그룹 이름" name="gpName" />
								<label for="groupName">그룹 이름</label>
							</div>
							<div class="form-floating mb-3">
								<label for="groupDisclosure" style="font-size: smaller; color: #7777da;">공개 범위 선택</label>
								<select class="form-control" id="groupDisclosure" name="gpDisclosure" style="height: 71px; width: 467px; padding-bottom: 10px; padding-top: 30px;">
									<option style="background-color: rgb(11 244 255 / 3%); font-size:18px">공개</option>
									<option style="background-color: rgb(11 244 255 / 3%); font-size:18px">비공개</option>
								</select>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<!--  <button type="button" class="btn btn-secondary" data-dismiss="modal"  >Close</button> -->
						<button class="btn btn-primary" id="groupBtn">만들기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- End Modal -->
	<div class="row gy-4 justify-content-center" style="margin-top: 102px;min-height: 77vh;">
		<div class="col-lg-3 d-flex justify-content-end">
			<section style="position: fixed" data-aos="fade-right">
				<div class="d-flex flex-column " id="sidebar">
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="location.href='main'">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/home-icon.png" class="icon">메인
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="location.href='GroupPage'">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/group-icon.png" class="icon">그룹
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 " onclick="location.href='main?page=recommendMember'">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/glass-icon.png" class="icon">친구추천
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="location.href='main?page=rankingBox'">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/fire-icon.png" class="icon">인기글
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/cs-icon.png" class="icon">고객센터
					</button>
				</div>
			</section>
		</div>
		<div class="col-lg-9">
			<!-- ======= Values Section ======= -->
			<section id="newsfeed" class="newsfeed">
				<div class="container" data-aos="fade-up">
					<!-- Button trigger modal -->
					<!-- <button type="button" id="boardWriteBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">게시글	작성하기</button> -->
					<!---------------------------------------------------------------------------------->
					<header class="section-header"> </header>
					<div class="card" id="storyCreateCard" style="width: 1153px; background-color: #e1eafd;">
						<div OnClick="location.href ='#'" class="card-body d-flex justify-content-between" id="boardWriteBtn">
							<div>
								<h5 class="card-title">새 그룹 만들기</h5>
								<h6 class="card-subtitle mb-2 text-muted">친구들과 그룹을 만들어보세요</h6>
							</div>
							<div>
								<i class="fas fa-plus-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="d-flex flex-wrap mt-5" id="contentBox"></div>
							<div class="text-center">
								<!-- <div class="spinner-border mx-auto my-5" role="status">
									 <span class="sr-only">Loading...</span> 
								</div> -->
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- End Values Section -->
		</div>
	</div>
	<%@ include file="../includes/Footer.jsp"%>
	<%@ include file="../includes/script.jsp"%>
</body>
<script>
window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	$.ajax({
		type:"get",
		url:"getGroup?num=0",
		dataType:"json",
		success:res=>{
			for(let i in res){
				createContentInCard(res[i])
				
			}
			
		}
	})
	
	
	
	

})


/* function dd(dd){
	
	
	
	
	
} */




function createContentInCard(dd){
	//게시글 박스 안에 게시글을 넣음
	let renderedCard = renderContentCard(dd);
	contentBox.appendChild(renderedCard);

	
}

function isLast(obj){
	//마지막 게시글인지 확인
	if(contentBox.lastChild === obj)
	{
		console.log("getItem")
		return true;
	}
	return false;
}



//페이지 스크롤 이벤트 등록
window.addEventListener('scroll', ()=>inScreen())

//마지막 호출된 시간보다 0.15초가 지나지 않았으면 바로 return
let lastTime = Date.now();
function inScreen(){
	if(lastTime + 150 > Date.now()){
		return;
	}
	
	//화면 안에있는 div중 현재 focus가 되어있지 않은 게시글에 focus를 줌
	let divElements = document.querySelectorAll(".contentCard")
	divElements.forEach(e => {
		if(isElementInViewport(e) && !(document.activeElement === e)){
			console.log("onFocus")
			e.focus();
		}
	})
	//마지막 호출된 시간 등록
	lastTime = Date.now();
}


//데이터d 를 받아와 게시글 카드를 그려줌
function renderContentCard(d){
	
	console.log("------")
	console.log(d.gpNum)
	
	let contentBoxWidthLength = contentBox.offsetWidth;
	let cardTemplate = document.createElement("div");
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0" tabindex="-1" onfocus="getNewCard(isLast(this))" style="width: 550px;margin: 15px;">'
		output += '<div class="fileBox" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
		output += '<a href="groupInfo?gpNum='+d.gpNum+'"><img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/groupfile/'+d.gpImg+'" style="height: 365px;border-radius:5px"></a>'
		output += '</div>'
	output += '<div onclick="" is-spread="fold" style="overflow:hidden"><div class="card-body" style="max-height:'+(contentBoxWidthLength/3)+'px">'		
	output += '<a href="groupInfo?gpNum='+d.gpNum+'" style="overflow: visible;display: inline-block;"><span class="card-text text">'+d.gpName+'</span></a>'
	output += '<span class="card-text text">'+'멤버 '+d.gpMemberCount+'명</span>'
	output += '</div>'
	output += '</div>'
	output += '<div class="card-footer">'
		output += '<div class="d-flex flex-row mt-1">'
		 /* 	if(d.gpMemberRq =="요청"){
		output += '<a href="" class="p-2 w-100 btn btn-outline-secondary border-0">요청중</a>'
			}  */
		if(${sessionScope.loginId} == d.gpMember){
			output += '<a href="groupInfo?gpNum='+d.gpNum+'"  class="p-2 w-100 btn btn-outline-secondary border-0">그룹 관리</a>'
		} else {
			output += '<a href="groupInfo?gpNum='+d.gpNum+'"  class="p-2 w-100 btn btn-outline-secondary border-0">그룹 가입</a>'
		}
		
		output += '</div>'
	output += '</div>'

	output += '</div>';

	cardTemplate.innerHTML = output;
	return cardTemplate.firstChild;

	
	
}







//게시글의 상, 하를 비교하여 화면의 어떤 위치에 있는 게시글을 골라냄
function isElementInViewport(el){
    let rect = el.getBoundingClientRect();
    return rect.bottom > 0.73*window.innerHeight && rect.top < 0.67*window.innerHeight;
}


	
	$('.close').click(function() {
		$('#exampleModalCenter').modal("hide"); //모달 닫기 
		$('#shareModalCenter').modal("hide"); //공유 모달 닫기
	});

	$('#boardWriteBtn').click(function(e) {
		var text = $("#groupName").val();
		e.preventDefault();
		$('#exampleModalCenter').modal("show"); //모달 열기
		
			if(text == "" || text == null){
				$("#groupBtn").attr('disabled', 'disabled');
		}
		
	});

	$("#groupName").on("change keyup paste",function() {
		
		
		var text = $("#groupName").val();
		if(text == "" ||text ==null){
			console.log("비활성화");
			$("#groupBtn").attr('disabled', 'disabled');
			$("#groupName").focus(); 
			
		} else {
			$("#groupBtn").removeAttr('disabled');
		}
	
	});
	
	
		
	


/* 헤더 버튼 관련 */
$("#messengerBtn").mouseenter(function() {
	console.log("메신저 마우스 엔터");
	$("#messengerBtn").click(function() {
		console.log("메신저 클릭");
		sideListSection.empty();
		
	})
})
$("#messengerBtn").mouseleave(function() {
	console.log("메신저 마우스 리브");
	
})

$("#alarmBtn").click(function() {
	console.log("알림 클릭");
})

$("#followListBtn").click(function() {
	console.log("팔로우리스트 클릭");
})

$(document).ready(function(){
	
})

/* //그룹 가입 클릭시 값이없으면 인서트 있으면 딜리트 기능하는 함수
function groupRequest(memId,gpNum,e){
	console.log("eee : "+e)
	console.log(memId,gpNum);
	
	$.ajax({
		type:"get",
		url:"getGroupRequest",
		data:{
			"memId":memId,
			"gpNum":gpNum
			},
		dataType:"text",
		
		success:res=>{
			console.log(res);
			if(res == ""){
				console.log("요청취소")
			

			} else {
				console.log("요청")
				
			}
			
		} ,error : function(){
			  alert("실패");
		  }
	});
	 
	 $(e).find('span').toggleClass("textRq");
	 $(e).find('span').toggleClass("textGp");
	
}


//그룹 리스트 출력할때 값이있으면 요청중 표시 없으면 그룹 가입 표시
function Rq(memId,gpNum){
	
	let output = '';
	$.ajax({
		type:"get",
		url:"selGroupRequest",
		data:{
			"memId":memId,
			"gpNum":gpNum
			},
			async:false,
		dataType:"text",
		success:res=>{
			console.log(res);
			if(res == ""){
				output = '<span class="textGp"></span>';
			} else {
				output = '<span class="textRq"></span>';
			}
			
		} ,error : function(){
			  alert("실패");
		  }
	});
	console.log(output);
	
	return output;
}
 */


</script>
</html>