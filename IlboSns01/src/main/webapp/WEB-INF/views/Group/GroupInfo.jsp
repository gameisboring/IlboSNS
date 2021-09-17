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

header.section-header {
	position: relative;
}

header.section-header img {
	width: 1278px;
	height: 520px;
	border-radius: 5px;
}

header.section-header input{
	display: none;
}

button.btn.btn-outline-primary {
	position: absolute;
	top: 70%;
    left: 95%;
    background-color: aliceblue;
}
button.btn.btn-outline-primary:hover {
	
    color:#000000;
}




	div.one {
       	margin-top:15px;
        width: 100%;
        height: 100px;
        
      
    }
    div.left {
        width: 50%;
        float: left;
        box-sizing: border-box;
        text-align: left;
     
    }
   
    
    
    div.right {
        width: 50%;
        float: right;
        box-sizing: border-box;
        text-align: right;
    }

	div.right button{
	
    margin-top: 15px;
    margin-left: 200px;

	}

	div.main{
		display:flex;
		flex-direction:column;
		
		
	}
	div#contentBox,div#contentBox3{
		 margin-left: 343px;
		 margin-top:120px;
	}
	
	div.tabs1{
		display:flex;
		border:0.5px solid black;
		border-right :none;
		border-left :none;
	}
	div.tabs1 .tabT{
		font-size: 1rem;
		text-align:center;
		line-height: 50px;
		width: 90px;
		height: 50px;
		cursor: pointer;
		background-color: white;
		/* border: 0.5px solid rgb(66,61,61); */
		
		color: black;
		position: relative;
	}
	div.items{
		width: 300px;
		display: none;
		padding: 10px;
		background-color: #fff;
		position: relative;
	}
	.items::before{
		content:"";
		position: absolute;
		top:0;
		left:0;
		width:90px;
		height: 5px;
		background-color: rgb(255,53,53);
	}
	.items:nth-child(2)::before{
		left:90px;
		background-color: rgb(53,100,255);
	}
	.items:nth-child(3)::before{
		left:180px;
		background-color: rgb(53,255,97);
	}
	div.items.active{
		display: inline-block;
	}
	div.card-header{
		background-color: rgb(11 244 255 / 3%);
	}
	
	div.icons i{
    height: 20px;
    width: 30px;
    margin-top: 6px;
	}
	
	div.icons h6{
    margin-left: 30px;
	}
	
	div.row {
	margin-top: 78px;
	
	}
	
	.textRq::before{
		content: "가입 요청중"
	}
	.textGp::before{
		content: "그룹 가입"
	}
	
	div.boards{
	
    width: 800px;
    margin-left: 222px;
	
    margin-bottom: 20px;
	
	}

	
	
	
</style>
</head>

<body>
	<%@ include file="../includes/HomeHeader.jsp"%>
	

	
	<div class="row gy-4 d-flex justify-content-center" >
		<div class="col-lg-0 d-flex justify-content-end">
			<%-- <section style="position: fixed" data-aos="fade-right">
				<div class="d-flex flex-column " id="sidebar">
					<button class="btn btn-outline-primary btn-lg mt-4">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/home-icon.png" class="icon">메인
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="location.href='GroupPage'">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/group-icon.png" class="icon">그룹
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/glass-icon.png" class="icon">친구추천
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/fire-icon.png" class="icon">인기글
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/business-icon.png" class="icon">비즈니스
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/cs-icon.png" class="icon">고객센터
					</button>
				</div>
			</section> --%>
		</div>
		<div class="col-lg-12">
			<!-- ======= Values Section ======= -->
			<section id="newsfeed" class="newsfeed" style="padding-top: 0px;">
				<div class="container" data-aos="fade-up">
					<!-- Button trigger modal -->
					<!-- <button type="button" id="boardWriteBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">게시글	작성하기</button> -->
					<!---------------------------------------------------------------------------------->
					<header class="section-header" id="gpInfo">
							
					</header>
					
					<div class="row">
						<div class="col-12">
						  <div class="main">
							
								<div class="tabs1">
									<div class="tabT" data-tab-target="#tab1">
										<p>정보</p>
									</div>
									<div class="tabT" data-tab-target="#tab2">
										<p>토론</p>
									</div>
									<div class="tabT" data-tab-target="#tab3">
										<p>멤버</p>
									</div>
								</div>
						 </div>
							<div class="content">
								<div id="tab1" data-tab-content class="items active">
	
									<div id="contentBox">
									
									</div>
								</div>	
								<!-- tab2 시작 -->
								<div id="tab2" data-tab-content class="items">
									
							 <!-- 멤버판별조건식 안에 공개조건식 -->	
							<c:choose>
							<c:when test="${myGroupMember ne 0}">
								
									<div class="card boards" id="boardWriteCard">
										<div class="card-body d-flex justify-content-between">
											<div class="flex-grow-1">
												<button id="boardWriteBtn" class="btn-light btn">${sessionScope.loginName}님
													내용을 입력하세요..</button>
											</div>
											<a href="memberInformation"> <img
												src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}"
												class="rounded-circle">
											</a>
										</div>
									</div>

									<div id="contentBox2">
										
									</div>
							</c:when>
							<c:otherwise>
								
								 <c:choose>
								 <c:when test="${gpDisclosure eq '비공개'}">

								 	<div class="boards" style="text-align:center;">	
								<img alt="disclosure" style="margin-top:80px;width:300px;" src="${pageContext.request.contextPath}/resources/assets/img/disclosure.svg">
								<h3> 이 그룹은 비공개 그룹입니다.</h3>
								<h5>토론을 보거나 참여하려면 이 그룹에 가입하세요. </h5>
								 	</div>
								 	
								 </c:when>
								 <c:when test="${gpDisclosure eq '공개'}">
								 	
									<div class="card boards" id="boardWriteCard">
										<div class="card-body d-flex justify-content-between">
											<div class="flex-grow-1">
												<button id="boardWriteBtn" class="btn-light btn">${sessionScope.loginName}님
													내용을 입력하세요..</button>
											</div>
											<a href="memberInformation"> <img
												src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}"
												class="rounded-circle">
											</a>
										</div>
									</div>
									<div id="contentBox2">
									</div>
								 </c:when>
								 </c:choose>
							</c:otherwise>
							</c:choose> 
							<!-- 조건식 End -->		
								</div>	
								<!-- tab2 끝 -->
								<!-- tab3 시작 -->
								<div id="tab3" data-tab-content class="items">
									
								<c:choose>
								<c:when test="${myGroupMember ne 0}">
									<div id="contentBox3">
										
									</div>
								</c:when>
								<c:otherwise>
									<c:choose>
								 	<c:when test="${gpDisclosure eq '비공개'}">
											<div class="boards" style="text-align: center;">
												<img alt="disclosure"
													style="margin-top: 80px; width: 300px;"
													src="${pageContext.request.contextPath}/resources/assets/img/disclosure.svg">
												<h3>이 그룹은 비공개 그룹입니다.</h3>
												<h5>이 그룹에 가입한 멤버를 보려면 이 그룹에 가입하세요.</h5>
											</div>
									</c:when>
								 	<c:when test="${gpDisclosure eq '공개'}">
								 			<div id="contentBox3">
											</div>
									</c:when>
									</c:choose>
									
								</c:otherwise>
								</c:choose>
								</div>	
							</div>
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
		
		<div class="col-lg-0">
			
		</div>
	</div>
	

 		

	<!-- Request Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">그룹 가입 요청</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
				
					<div class="modal-body" id="GroupRqMembers">
						
					</div>
					<!-- <div class="modal-footer">
						 <button type="button" class="btn btn-secondary" data-dismiss="modal"  >Close</button>
						<button class="btn btn-primary" id="writeBtn">게시하기</button>
					</div> -->
				
			</div>
		</div>
	</div>
	<!-- Request End Modal -->
	
	<!-- Board Modal -->
	<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">게시물 만들기</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
				<form action="groupBoardWrite" id="uploadForm" method="post" enctype="multipart/form-data">
					<input type="hidden" value="${gpNum}" name="gpNum">
					<div class="modal-body">
						<div class="d-flex justify-content-start">
							<a href="#">
								<span> <img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle" style="width: 50px; height: 50px;"></span>
							</a>
							<div class="px-3">
								<div>${sessionScope.loginName}</div>
								<select name="boVisiblity" class="divFocusBorder-0">
									<option value="전체공개">&#xf57c 전체공개</option>
									<option value="친구만">&#xf500 친구만</option>
									<option value="비공개">&#xf502 비공개</option>
								</select>
							</div>
						</div>
						<div role="textbox">
							<textarea rows="10" cols="43" id="text" style="border: none; margin-top: 10px;" name="boContent"></textarea>
							<output id="list" class="d-flex flex-row"></output>
						</div>
						<input type="hidden" value="${sessionScope.loginId}" name="boWriter">
						<input type="hidden" value="${sessionScope.loginName}" name="boWritersName">
						<div id="variousFunctions" class="card-body pt-3" style="margin-top: 10px;">
							<label for="files"> <img src="${pageContext.request.contextPath }/resources/assets/img/picture.png" width="40px" height="40px" id="upload">
							</label>
							<input type="file" id="files" name="boMutipleFile" style="display: none;" multiple />
						</div>
					</div>
					<div class="modal-footer">
						<!--  <button type="button" class="btn btn-secondary" data-dismiss="modal"  >Close</button> -->
						<button class="btn btn-primary" id="writeBtn">게시하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Board End Modal -->

	<!-- Share Modal -->
	<div class="modal fade" id="shareModalCenter" tabindex="-1" role="dialog" aria-labelledby="shareModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="shareModalCenterTitle">공유하기</h5>
					<button type="button" class="close rounded-circle" data-dismiss="modal" aria-label="Close" style="width: 31px; height: 33px;">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="boardShare" method="post">
					<div class="modal-body">
						<div class="d-flex justify-content-start">
							<a href="#">
								<span> <img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle" style="width: 50px; height: 50px;"></span>
							</a>
							<div class="px-3">
								<div>${sessionScope.loginName}</div>
								<select name="boVisiblity" class="divFocusBorder-0">
									<option value="전체공개">&#xf57c 전체공개</option>
									<option value="친구만">&#xf500 친구만</option>
									<option value="비공개">&#xf502 비공개</option>
								</select>
							</div>
						</div>
						<div role="textbox">
							<textarea rows="10" cols="43" id="shareText" style="border: none; margin-top: 10px;" name="boContent"></textarea>
							<output id="list"></output>
						</div>
						<input type="hidden" value="${sessionScope.loginId}" name="boWriter">
						<input type="hidden" value="${sessionScope.loginName}" name="boWritersName">
						<input type="hidden" id="boFile" name="boFile">
					</div>
					<div class="modal-footer">
						<!--  <button type="button" class="btn btn-secondary" data-dismiss="modal"  >Close</button> -->
						<button class="btn btn-primary" id="shareWriteBtn">공유하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- End of Share Modal -->


	<!-- Delete Modal -->
	<div class="modal fade" id="deleteModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle" >
					그룹 나가기
					</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
					<form method="post" action="deleteGroup">
					<div class="modal-body" id="deleteMember" style="text-align: center;">
						
					</div>
					 <div class="modal-footer">
						<button class="btn btn-primary" id="DeleteBtn">확인</button>
					</div> 
					</form>
			</div>
		</div>
	</div>
	<!-- Delete End Modal -->
	<!-- 탈퇴처리 Modal -->
	<div class="modal fade" id="exileModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle" >
					그룹원 차단
					</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
					<form method="post" action="deleteGroup">
					<div class="modal-body" id="exileMember" style="text-align: center;">
						
					</div>
					 <div class="modal-footer">
						<button class="btn btn-primary" id="exileBtn">확인</button>
					</div> 
					</form>
			</div>
		</div>
	</div>
	<!-- 탈퇴처리 End Modal -->
	<!-- 등급 업 다운  Modal -->
	<div class="modal fade" id="rankModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle" >
					관리자 권한
					</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
					<form method="post" action="updateRank">
					<div class="modal-body" id="rankMember" style="text-align: center;">
						
					</div>
					 <div class="modal-footer">

						<button class="btn btn-primary" id="rankBtn">확인</button>
					</div> 
					</form>
			</div>
		</div>
	</div>
	<!-- 등급 업 다운 End Modal -->







	
	<%@ include file="../includes/Footer.jsp"%>
	<%@ include file="../includes/script.jsp"%>






</body>


<script>

console.log(${gpNum});
var gpNum = '${gpNum}';

$('.close').click(function() {
	$('#exampleModalCenter').modal("hide"); //모달 닫기 
	$('#deleteModalCenter').modal("hide"); //모달 닫기 
	$('#exileModalCenter').modal("hide"); //모달 닫기 
	$('#rankModalCenter').modal("hide"); //모달 닫기 
});



function openModal(e){
	
	console.log("모달클릭")
	$('#exampleModalCenter').modal("show");
}



window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	 $.ajax({
		type:"get",
		url:"getGroupInfo?gpNum="+gpNum,
		dataType:"json",
		async:false,
		success:res=>{
			
			console.log(res)
			GroupeTopCard(res)
			GroupInfoCard(res)
			
		}
	}) 
	 $.ajax({
		type:"get",
		url:"getGroupMember?gpNum="+gpNum,
		async:false,
		dataType:"json",
		success:gp=>{
			
			
			createGroupMemberCard(gp)
			
		}
	}) 

	$.ajax({
		type:"get",
		url:"getRequestGroupMembers",
		data:{"gpNum":gpNum},
		dataType:"json",
		success:res=>{
				
			for(let i in res){
				rqMembersCard(res[i])
			}
		}
	})


		//그룹 게시글 출력
		$.ajax({
		type:"get",
		url:"getGpBoard?gpNum=${gpNum}",
		dataType:"json",
		success:res=>{
			for(let i in res){
				createContentInCard(res[i])	
				
			}
				
			
			//해시태그
			var contentLength = document.getElementsByClassName('contentElement').length;
			console.log("클래스크기 : "+contentLength);
			for (let i = 0; i < contentLength; i++){ 
				var content = document.getElementsByClassName('contentElement')[i].innerHTML;
				//console.log("이문서의내용 : "+content);
				
				 var splitedArray = content.split(' ');
				//console.log(splitedArray);
				var linkedContent = '';
				for(var hashTag in splitedArray)
				{
				  hashTag = splitedArray[hashTag];
				  //console.log("hashTag = "+hashTag);
				   if(hashTag.indexOf('#') == 0)
				   {
					  
				      var word = hashTag.replaceAll("#","%23"); //#은 컨트롤러로 넘길때 나오지않아서 변환 %23 = # 
					   //console.log("hashTag2 = "+hashTag);
					   hashTag = '<a href=\'hashTagSelect?hashTag='+word+'\'>'+hashTag+'</a>';
				   }
				   linkedContent += hashTag+' ';
				   //console.log("hashTag3 = "+hashTag);
				}
				document.getElementsByClassName('contentElement')[i].innerHTML = linkedContent;  
			}
			
		}
	})
		

	
})

function createContentInCard(dd){

	let renderedCard = renderContentCard(dd);
	let renderedReplyDiv = getReply(dd.boNum);

	renderedCard.appendChild(renderedReplyDiv);
	contentBox2.appendChild(renderedCard);
}




 //데이터d 를 받아와 게시글 카드를 그려줌
function renderContentCard(d){
	
	let contentBoxWidthLength = contentBox2.offsetWidth;
	let cardTemplate = document.createElement("div");
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0 boards" tabindex="-1" onfocus="getNewCard(isLast(this))">'
	output += 	'<div class="card-header d-flex justify-content-between">'
	output += 		'<div class="d-flex">'
	output += 			'<img class="rounded-circle" style="margin-top: 6px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px" onclick="location.href=\'memberInformation?memId='+d.memId+'\'">'
		output += 		'<div class="px-3 pt-1">'
		output += 			'<h6 class="card-title" style="margin-bottom: 1px;">'+d.gpName+'</h6>'
		output += 			'<h5 class="card-title" style="margin-bottom: 3px;">'+d.memName+'</h5>'
		output += 			'<h6 class="card-subtitle text-muted small" style="margin-bottom:1px;">' + pastTime(d.boDate) + '</h6>'
	output +=		'</div></div>'
	output +=		'<button class="card-menu-btn btn-outline-secondary btn" style="margin-top: 6px;" onclick="boardDelete(this,'+d.boNum+','+d.memId+')"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
	output += 	'</div>'
	output += '<div onclick="spreadText(this.firstChild)" is-spread="fold" style="overflow:hidden"><div class="card-body" style="max-height:px">'
																															
	output += '<p class="card-text text contentElement">'+d.boContent+'</p>'
	output += '</div>'
		if(d.boFile != null){
			if(d.boType == "PICTURE"){
				output += '<div class="fileBox" style="overflow:hidden; max-height:px">'
				output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
				output += '</div>'
			} else if(d.boType == "SHARE"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:px">'
				output += shareCard(d.boFile);
				output += '</div>'
			} else if(d.boType == "VIDEO"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:px">'
				output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+d.boFile+'" controls></video>'
				output += '</div>'
			}
		}
		if(d.boType == "MULTI"){
			output += '<div class="fileBox p-2" style="overflow:hidden; max-height:px">'
			output += multiCard(d.boNum);
			output += '</div>'
		}
	output += '</div>'
	output += '<div class="card-footer">'
		output += '<div class="d-flex flex-row mt-1">'
			output += '<div class="p-2 w-33 btn btn-outline-secondary border-0" onclick="checkLike('+${sessionScope.loginId}+' , '+d.boNum+',this)" ><span> '+isLike('${sessionScope.loginId}',d.boNum)+'  </span>좋아요 '+likeCount(d.boNum)+' </div>'
			output += '<div role="button" class="p-2 w-33 btn btn-outline-secondary border-0" data-bs-toggle="collapse" href="#replyArea'+d.boNum+'\" aria-expanded="false" aria-controls="replyArea'+d.boNum+'"><i class="far fa-comment-alt me-1"></i>댓글달기</div>'
			output += '<div onclick = "shareBoard('+ d.boNum +')" class="p-2 w-33 btn btn-outline-secondary border-0"><i class="far fa-share-square me-1"></i>공유하기</div>'
		output += '</div>'
	output += '</div>'

	output += '</div>';

	cardTemplate.innerHTML = output;
	return cardTemplate.firstChild;
	
} 




function rqMembersCard(d){
	let rqMembersCard  = rqMembers(d)
	
	GroupRqMembers.appendChild(rqMembersCard)
}



function rqMembers(d) {
	console.log("요청멤버들")
	console.log(d)
	let cardTemplate = document.createElement("div");
	let output = '';
		output += '<div class="d-flex" style=" margin-bottom: 6px; position: relative;">'
		output += '<img class="rounded-circle" style="width: 50px;height: 50px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'" onclick="location.href=\'memberInformation?memId='+d.gpMemIdRq+'\'>'
		output += '<div style="margin-left: 8px;">'
		output += '<h5 style="margin-bottom: 2px;margin-top: 4px;">'+d.memName+'</h5>'
		output += '<h6>가입 요청</h6>'
		output += '</div>'
		output += '<button class="card-menu-btn btn-outline-secondary btn" onclick="joinGpMem('+d.gpMemIdRq+','+d.gpNumRq+')"  style="position: absolute;left: 73%;">수락</button>'
			output += '<button class="card-menu-btn btn-outline-secondary btn" onclick="cancelRqMem('+d.gpMemIdRq+','+d.gpNumRq+')"  style="position: absolute;left: 86%;">거절</button>'
		output += '</div>'
	
			cardTemplate.innerHTML = output;
	
	return cardTemplate.firstChild;
}







function createGroupMemberCard(m){
	
	console.log("-----------")
	console.log(m)
	console.log("-----------")
	let contentBox3 = document.getElementById('contentBox3');
	
	let output = '';
	output += '<div id="disClosure">'
		output += '<div  class="card mb-3 contentCard divFocusBorder-0"  style="width: 550px;margin: 15px;">'
			output += '<div class="card-header d-flex justify-content-between">'
				output += '<div class="d-flex">'
					output += '<div class="px-3 pt-1">'
					output += '<h5 class="card-title" style="margin-bottom:10px;margin-top:10px;">멤버 · '+m.length+'명</h5>'
				output +=		'</div>'
			output +=      '</div>'
		output += 	'</div>'
		
			output += '<div >'
			output +=		'<div class="card-body" >'	
				output += '<h3>그룹장 및 그룹관리자</h3>'
				
				for(let i = 0; i < m.length ; i++){
					if(m[i].gpManager == "그룹장"){
						output += '<div class="d-flex" style=" margin-bottom: 6px;">'
						output += '<img class="rounded-circle" style="width: 50px;height: 50px;cursor : pointer;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+m[i].memProfile+'"  onclick=\'location.href="memberInformation?memId='+m[i].memId+'"\'>'
						output += '<div style="margin-left: 8px;">'
						output += '<h5 style="margin-bottom: 2px;margin-top: 4px;">'+m[i].memName+'</h5>'
						output += '<h6>'+m[i].gpManager+'</h6>'
						output += '</div>'
							output += '<div class="dropdown" >'
								output += '<button class="card-menu-btn btn-outline-secondary btn" data-bs-toggle="dropdown" aria-expanded="false"  id="GroupDropDown" style="position: absolute;left: 336px;"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
									output += '<div class="dropdown-menu" aria-labelledby="GroupDropDown" >'
									output += ''+gpOption(m[i].gpManager,m[i].memId)+''
									output += '</div>'
										output += '</div>'
						output += '</div>'
					}
					if(m[i].gpManager == "관리자"){
						
					output += '<div class="d-flex" style=" margin-bottom: 6px;">'
					output += '<img class="rounded-circle" style="width: 50px;height: 50px;cursor : pointer;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+m[i].memProfile+'"  onclick="location.href=\'memberInformation?memId='+m[i].memId+'\'">'
					output += '<div style="margin-left: 8px;">'
					output += '<h5 style="margin-bottom: 2px;margin-top: 4px;">'+m[i].memName+'</h5>'
					output += '<h6>'+m[i].gpManager+'</h6>' 
					output += '</div>'
						output += '<div class="dropdown" >'
							output += '<button class="card-menu-btn btn-outline-secondary btn" data-bs-toggle="dropdown" aria-expanded="false"  id="GroupDropDown" style="position: absolute;left: 336px;"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
								output += '<div class="dropdown-menu" aria-labelledby="GroupDropDown" >'
								output += ''+gpOption(m[i].gpManager,m[i].memId)+''
								output += '</div>'
									output += '</div>'
					output += '</div>'
					}
				}
				
			output += '</div>'
				output += '</div>'
				
				output += '<div class="card-footer" style="background-color:rgb(255 255 255);">'
				output += '<div class="mt-1">'
						output += '<h3 style="">그룹 멤버</h3>'
					for(let i=0; i < m.length ; i++){
								
						if(m[i].gpManager != "그룹장" && m[i].gpManager != "관리자"){
							
						output += '<div class="d-flex" style=" margin-bottom: 6px; ">'
						output += '<img class="rounded-circle" style="width: 50px;height: 50px;cursor : pointer;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+m[i].memProfile+'"  onclick="location.href=\'memberInformation?memId='+m[i].memId+'\'">'
						output += '<div style="margin-left: 8px;">'
						output += '<h5 style="margin-bottom: 2px;margin-top: 4px;">'+m[i].memName+'</h5>'
						output += '<h6>'+m[i].gpManager+'</h6>'
							output += '</div>'
								output += '<div class="dropdown" >'
							output += '<button class="card-menu-btn btn-outline-secondary btn" data-bs-toggle="dropdown" aria-expanded="false"  id="GroupDropDown" style="position: absolute;left: 336px;"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
								output += '<div class="dropdown-menu" aria-labelledby="GroupDropDown" >'
								output += ''+gpOption(m[i].gpManager,m[i].memId)+''
								output += '</div>'
									output += '</div>'
									
							output += '</div>'		
						}
					}
				output += '</div>'
				output += '</div>'
				
			 
    output += '</div>'
    output += '</div>'
			contentBox3.innerHTML = output;
	
	
}

function gpOption(K,memId) {
	
	
	
	let output = '';
	if(memId == ${sessionScope.loginId}){
		output += '<a class="dropdown-item" onclick="deleteModal('+memId+')">그룹 나가기</a>'
		
	}
	$.ajax({
			type:"post",
			url:"registeredMember",
			data:{"memId":${sessionScope.loginId} ,"gpNum":gpNum},
			dataType:"text",
			async:false,
			success:function(res){
				console.log("리턴값")
				console.log(res)
				if(res == "member"){
					document.getElementById('boardWriteCard').style.display = "none";
					document.getElementById("RqButton").style.display = "none"; 
					document.getElementById("imgUploadBtn").style.display = "none";
					if(K == "그룹장"){
						output += '<a class="dropdown-item" >그룹 장</a>'
					} else if(K == "관리자"){
						output += '<a class="dropdown-item" >그룹 관리자</a>'
					} else if(K == "그룹 멤버"){
						output += '<a class="dropdown-item" >그룹 멤버</a>'
					}
					
					
				} else if (res == "manager"){
					document.getElementById("imgUploadBtn").style.display = "none";
					document.getElementById("RqButton").style.display = "none";
					
					if(K == "그룹장"){
						output += '<a class="dropdown-item" >그룹 장</a>'
					} else if(K == "관리자"){
						output += '<a class="dropdown-item" >그룹 관리자</a>'
					} else if(K == "그룹 멤버"){
						output += '<a class="dropdown-item" onclick="exileModal('+memId+')">그룹에서 내보내기</a>'
					}
					
				} else if (res == "king"){	
					
					if(K == "그룹장"){
						console.log("그룹장")
					} else if(K == "관리자"){
						output += '<a class="dropdown-item" onclick="rankModal('+memId+')">그룹 멤버로 내리기</a>'
						output += '<a class="dropdown-item" onclick="exileModal('+memId+')">그룹에서 내보내기</a>'
					} else if(K == "그룹 멤버"){
						output += '<a class="dropdown-item" onclick="rankModal('+memId+')">관리자 권한 부여</a>'
						output += '<a class="dropdown-item" onclick="exileModal('+memId+')">그룹에서 내보내기</a>'

					}

				} else {
					document.getElementById("imgUploadBtn").style.display = "none";
					document.getElementById("boardWriteCard").style.display = "none";
					if(K == "그룹장"){
						output += '<a class="dropdown-item" >그룹 장</a>'
					} else if(K == "관리자"){
						output += '<a class="dropdown-item" >그룹 관리자</a>'
					} else if(K == "그룹 멤버"){
						output += '<a class="dropdown-item" >그룹 멤버</a>'
					}
				}
			}
		})

	console.log(output)
	
	
	return output;
	
}


function deleteModal(memId) {
	console.log("딜리트")
	
	let output = '';
	 //딜리트 모달 열기
	$.ajax({
		type:"get",
		url:"delSelMember",
		data:{"memId":memId ,"gpNum":gpNum},
		dataType:"json",
		async:false,
		success:function(res){
			if(res.gpManager == "그룹장"){
				output += '<img class="rounded-circle" style="width: 50px;height: 50px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'">'
				output += '<h3>'+res.memName+'</h3>'
				output += ' 회원님은 이 그룹의 '+res.gpManager+' 입니다. 그룹을 삭제 하시겠습니까?'
				output += '<input type="hidden" name="memId" value="'+memId+'">'
				output += '<input type="hidden" name="gpNum" value="'+gpNum+'">'
				output += '<input type="hidden" name="gpManager" value="'+res.gpManager+'">'
				$('#deleteMember').html(output);
			} else {
				output += '<img class="rounded-circle" style="width: 50px;height: 50px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'">'
				output += '<h3>'+res.memName+'</h3>'
				output += ' 회원님은 이 그룹의 '+res.gpManager+' 입니다. 그룹을 탈퇴 하시겠습니까?'
				output += '<input type="hidden" name="memId" value="'+memId+'">'
				output += '<input type="hidden" name="gpNum" value="'+gpNum+'">'
				output += '<input type="hidden" name="gpManager" value="'+res.gpManager+'">'
				$('#deleteMember').html(output);
			}
		
				
			
		}
	})		
	$('#deleteModalCenter').modal("show");
	
}


function exileModal(memId){
	let output = '';
	$.ajax({
		type:"get",
		url:"gpSelMember",
		data:{"memId":memId ,"gpNum":gpNum},
		dataType:"json",
		async:false,
		success:function(res){
			output += '<img class="rounded-circle" style="width: 50px;height: 50px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'">'
			output += '<h3>'+res.memName+'</h3>'
			output += '정말로 '+res.memName+' 회원님을 내보내시겠습니까?'
			output += '<input type="hidden" name="memId" value="'+memId+'">'
			output += '<input type="hidden" name="gpNum" value="'+gpNum+'">'
			output += '<input type="hidden" name="gpManager" value="'+res.gpManager+'">'
			$('#exileMember').html(output);
		}
	
	})
	$('#exileModalCenter').modal("show");
}

function rankModal(memId){
	let output = '';
	$.ajax({
		type:"get",
		url:"gpSelMember",
		data:{"memId":memId ,"gpNum":gpNum},
		dataType:"json",
		async:false,
		success:function(res){
			if(res.gpManager == "관리자"){
				output += '<img class="rounded-circle" style="width: 50px;height: 50px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'">'
				output += '<h3>'+res.memName+'</h3>'
				output += ''+res.memName+' 회원의 관리자 권한을 박탈합니다. 회원 관리의 권한을 잃게 됩니다 박탈 하시겠습니까?'
				output += '<input type="hidden" name="memId" value="'+memId+'">'
				output += '<input type="hidden" name="gpNum" value="'+gpNum+'">'
				output += '<input type="hidden" name="gpManager" value="'+res.gpManager+'">'
				$('#rankMember').html(output);
				
			} else if(res.gpManager =="그룹 멤버"){
				
				output += '<img class="rounded-circle" style="width: 50px;height: 50px;" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'">'
				output += '<h3>'+res.memName+'</h3>'
				output += ''+res.memName+' 회원에게 관리자 권한을 부여합니다. 회원 관리의 권한을 갖게 됩니다 부여 하시겠습니까?'
				output += '<input type="hidden" name="memId" value="'+memId+'">'
				output += '<input type="hidden" name="gpNum" value="'+gpNum+'">'
				output += '<input type="hidden" name="gpManager" value="'+res.gpManager+'">'
				$('#rankMember').html(output);
			}
		}
	
	})
	$('#rankModalCenter').modal("show");
}



function GroupeTopCard(gp) {
	
	console.log(${sessionScope.loginId});
	console.log("그룹관리목록")
	console.log(gp)
	let gpInfo = document.getElementById('gpInfo');
	
	let output = "";
	output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/groupfile/'+gp.gpImg+'" >'
	output += '<button id="imgUploadBtn" class="btn btn-outline-primary" type="button" onclick="infile.click()">수정</button>'
	output += '<input type="file" id="infile" onchange="updateGpImg()">'
	output += '<input type="hidden" value="${gpNum}" id="groupNum">'
	output += '<div class="one">'
	output += '<div class="left"><h1><strong id="gpName">'+gp.gpName+'</strong></h1>'
	if(gp.gpDisclosure == "공개"){
		output += '<i class="fas fa-globe"></i>'
	} else if (gp.gpDisclosure == "비공개"){
		output += '<i class="fas fa-user-lock"></i>'
	}
	output += '<span style="margin-left:5px;">'+gp.gpDisclosure+' 그룹 · 멤버 '+gp.gpMemberCount+'명</span>'
	output += '</div>'
	output += '<div class="right">'
	if(gp.gpMember == ${sessionScope.loginId}){
		output += '<button class="btn btn-primary"  onclick="openModal(this)">멤버 관리</button>'
	} else {	
		output += '<button class="btn btn-primary" id="RqButton" onclick="groupRequest('+${sessionScope.loginId}+' , '+gp.gpNum+',this)">'+Rq(${sessionScope.loginId},gp.gpNum)+'</button>'
		
	}
	output += '</div>'
	output += '</div>'
	
	gpInfo.innerHTML = output;



}





function GroupInfoCard(d){
	
	//let cardTemplate = document.createElement("div");
	let contentBox = document.getElementById('contentBox');
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0"  style="width: 550px;margin: 15px;">'
		output += 	'<div class="card-header d-flex justify-content-between">'
			output += 		'<div class="d-flex">'
				output += 		'<div class="px-3 pt-1">'
				output += 			'<h5 class="card-title" style="margin-bottom:10px;margin-top:10px;">그룹 정보</h5>'
			output +=		'</div>'
			output +=      '</div>'
			output += 	'</div>'
			output += '<div ><div class="card-body" >'	
			if(d.gpDisclosure == "공개"){
			output += '<div class="icons" style="display:flex">'
			output += '<i class="fas fa-globe fa-lg"></i>'
			output += '<h5 class="card-text">'+d.gpDisclosure+' 그룹</h5>'
			output += '</div>'
			output += '<h6 class="card-text" style=" margin-left: 30px;">누구나 그룹 멤버와 게시물을 볼 수 있습니다</h6>'
			output += '<div class="icons" style="display:flex">'
			output += '<i class="fas fa-eye fa-lg"></i>'	
			output += '<h5 class="card-text">검색 가능</h5>'
				output += '</div>'
			output += '<h6 class="card-text" style=" margin-left: 30px;">누구나 이 그룹을 찾을 수 있습니다.</h6>'
				
			} else if(d.gpDisclosure == "비공개"){
			output += '<div class="icons" style="display:flex">'
			output += '<i class="fas fa-user-lock fa-lg"></i>'
			output += '<h5 class="card-text">'+d.gpDisclosure+' 그룹</h5>'
			output += '</div>'
			output += '<h6 class="card-text" style=" margin-left: 30px;">멤버만 그룹 멤버와 게시물을 볼 수 있습니다.</h6>'	
				output += '<div class="icons" style="display:flex">'
					output += '<i class="fas fa-eye fa-lg"></i>'
			output += '<h5 class="card-text">검색 불가능</h5>'
				output += '</div>'
			output += '<h6 class="card-text" style=" margin-left: 30px;">이 그룹을 검색할 수 없습니다.</h6>'
			}
			output += '<div class="icons" style="display:flex">'
				output += '<i class="fas fa-clock fa-lg"></i>'
			output += '<h5 class="card-text text">내역</h5>'
				output += '</div>'
			output += '<h6 class="card-text text" style=" margin-left: 30px;">'+d.gpDate+'에 그룹이 만들어졌습니다</h6>'
			output += '</div>'
			output += '</div>'
			
    output += '</div>';

    
	//cardTemplate.innerHTML = output;
	//return cardTemplate.firstChild;
    contentBox.innerHTML = output;
}



	$('.close').click(function() {
		$('#exampleModalCenter2').modal("hide"); //모달 닫기 
		$('#shareModalCenter').modal("hide"); //공유 모달 닫기
	});
	
	$('#boardWriteBtn').click(function(e) {
		var text = $("#text").val();
		e.preventDefault();
		$('#exampleModalCenter2').modal("show"); //모달 열기
		
			if(text == "" || text == null){
				$("#writeBtn").attr('disabled', 'disabled');
		}
		
	});



	$("#text").on("change keyup paste",function() {
		var text = $("#text").val();
		if(text == "" ||text ==null){
			console.log("비활성화");
			$("#writeBtn").attr('disabled', 'disabled');
			$("#writeBtn").focus(); 
			
		} else {
			$("#writeBtn").removeAttr('disabled');
		}
	
	});
	
$("#shareText").on("change keyup paste",function() {
		
		var text = $("#shareText").val();
		if(text == "" ||text ==null){
			console.log("비활성화");
			$("#shareText").focus(); 
			$("#shareWriteBtn").attr('disabled', 'disabled');
			
		} else {
			$("#shareWriteBtn").removeAttr('disabled');
		}
	
	});
	
	
function getReply(boardNum){
	
	// 댓글 관련 오브젝트를 담는 div 객체 생성
	var replyArea = document.createElement("div");
	
	// 댓글div에 속성 부여
	replyArea.classList.add("collapse");
	replyArea.classList.add("replyArea");
	replyArea.setAttribute("data-bs-toggle","collapse");
	replyArea.setAttribute("id","replyArea"+boardNum);
	
	// 댓글이 표시될 ul 객체 생성 
	var newUl = document.createElement("ul");
	
	newUl = getReplyAjax(boardNum,newUl);
	
	// 댓글div객체에 ul객체 넣어줌
	replyArea.appendChild(newUl);
	
	return replyArea;
} 

function getReplyAjax(boardNum,newUl){
	// 게시글 번호로 댓글 목록 조회
	$.ajax({
		type : "post",
		url : "getReply",
		data : { "boardNum" : boardNum },
		dataType : "json",
		success : res=>{
			
			// ul객체에 댓글입력칸(inputArea) 우선 저장 
			newUl.innerHTML = inputReply(boardNum);
			
			// ul객체에 접었다폈다 위한 클래스 설정
			newUl.setAttribute('class','list-group');
			newUl.setAttribute('class','list-group-flush');

			// if : 조회된 댓글목록 없음
			if(res==""){
				console.log("입력된 댓글 없음!@");
				
			// if : 조회된 댓글 목록 있음
			}else{
				// 조회된 댓글 목록 순서대로 ul객체에 순차저장
				$.each(res, function(i){
					newUl = replyRender(res[i],newUl);
				});
			}
		}
	})
	return newUl;
}

function replyRender(res,newUl){
	
	// HTML코드 저장을 위한 변수
	var output = "";
	
	// level(댓글 계층)에 따른 margin 값 저장
	var marginForLevel = 0;
	
	// 댓글 계층 표현 (일반 댓글 : 0) (대댓글 : 50) (대대댓글 : 100) ...
	if(res.reLevel != 0){
		for(var i=0;i<res.reLevel;i++){
			marginForLevel += 50;
		}
	}
	
	// 댓글 표시
	output += "<li class='list-group-item'>"
		output += "<div class='d-flex' style='margin : 0.5rem 0 0.5rem "+marginForLevel+"px'>"
			output += '<img class="rounded-circle mx-3" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'\">'
			output += '<div class="w-100 d-flex flex-column">'
				output += '<div class="card bg-light" onclick="inputReReply(this,'+res.reBoNum+','+res.reGroup+','+res.reLevel+','+res.reSeq+')">'
					output += '<h6 >'+res.memName+'</h6>'
					output += '<h6 class="text-muted small">' + pastTime(res.reDate) + '</h6>'
					output += '<p>'+res.reContent+'</p>'
				output += '</div>'
			output += '</div>'
		output += "</div>"
	output += "</li>";
	
	// 생성된 HTML 코드 DOM 객체에 순차저장
	newUl.innerHTML += output;
	
	// DOM 객체 리턴
	return newUl;
}

function inputReply(boardNum){
	
	var output = "";
	
	output += "<li class='list-group-item'>";
	/* 	output += "<form action='replyWrite' method='post'>" */
			output += "<div class='d-flex reply-input'>"
				output += '<img class="rounded-circle" src="${pageContext.request.contextPath}/resources/assets/img/profile/${sessionScope.loginProfile}">'
				output += "<div class='inputArea'>"
					output += '<input type="text" class="form-control" name="reContent" placeholder="댓글을 입력하세요.." required>'
					output += '<input type="hidden" name="reWriter" value="${sessionScope.loginId}">'
					output += '<input type="hidden" name="reBoNum" value="'+ boardNum +'">';
				output += "</div>"
				output += "<button class='btn btn-sm btn-primary' onclick='replyWrite(this)'>"
					output += "등록"
				output += "</button>"
			output += "</div>"
	/* 	output += "</form>" */
	output += "</li>";
	
	return output;
}

function replyWrite(obj){
	
	let inputArea = $(obj).prev().children();
	console.log(inputArea);
	let reContent = $(inputArea[0]).val();
	let reWriter = $(inputArea[1]).val();
	let reBoNum = $(inputArea[2]).val();
	let reGroup = $(inputArea[3]).val();
	let reLevel = $(inputArea[4]).val();
	let reSeq = $(inputArea[5]).val();
	
	$.ajax({
		type : "post",
		url : "replyWrite",
		data : {"reContent" : reContent, "reWriter" : reWriter, "reBoNum" : reBoNum, "reGroup" : reGroup, "reLevel" : reLevel, "reSeq" : reSeq},
		dataType : "text",
		success : res=>{
			
			console.log("insert 성공 : "+res);
			
			let oldUl = $(obj).parents("ul");						//예전 ul태그
			let replyArea = oldUl.parent();							//게시물 카드
			console.log(replyArea);
			
			var newUl = document.createElement("ul");				//새로운 ul태그
			newUl = getReplyAjax(reBoNum,newUl); 					//댓글 새로 받아오기
			
			$(oldUl).remove();
			$(replyArea).append(newUl);		
		}
	}) 
}

function inputReReply(obj,boardNum,reGroup,reLevel,reSeq){
	
	if($(obj).parents('li').next().hasClass('rereply')){
		closeReplyInput(obj);
	}else{
	
	var output = "";
	
	/* output += "<div class='card border-primary mt-3'>"; */
	output += "<li class='list-group-item rereply'>";
	/* 	output += "<form action='replyWrite' method='post'>" */
			output += "<div class='d-flex reply-input'>"
				output += '<img class="rounded-circle" src="${pageContext.request.contextPath}/resources/assets/img/profile/${sessionScope.loginProfile}">'
				output += "<div class='inputArea'>"
					output += '<input type="text" class="form-control" name="reContent" placeholder="댓글을 입력하세요..">'
					output += '<input type="hidden" name="reWriter" value="${sessionScope.loginId}">'
					output += '<input type="hidden" name="reBoNum" value="'+ boardNum +'">';
					if(reGroup != null && reLevel != null){
						output += '<input type="hidden" name="reGroup" value="'+ reGroup +'">';
						output += '<input type="hidden" name="reLevel" value="'+ reLevel +'">';
						output += '<input type="hidden" name="reSeq" value="'+ reSeq +'">';
					}
				output += "</div>"
					output += "<button class='btn btn-sm btn-primary' onclick='replyWrite(this)'>"
						output += "등록"
					output += "</button>"
			output += "</div>"
	/* 	output += "</form>" */
	output += "</li>";
		
	$(obj).parents('li').after(output);
	}
}

function closeReplyInput(obj){
	console.log($(obj).parents('li').next());
	$(obj).parents('li').next().remove();
}	
	


/* 헤더 버튼 관련 */
$("#messengerBtn").mouseenter(function() {
	console.log("메신저 마우스 엔터");
	$("#messengerBtn").click(function() {
		console.log("메신저 클릭");
		/* sideListSection.empty(); */
		
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

function updateGpImg(){
	console.log("업데이트 그룹 이미지");
	
			
	console.log($('input[type=file]')[0].files[0])
	
	console.log("인파일")
	console.log($('#infile')[0].files[0])
	var formData = new FormData();
	formData.append('file', $('#infile')[0].files[0]);
	formData.append('gpnum',$("#groupNum").val());
	
	$.ajax({
		type: "post",
		enctype: "multipart/form-data",
		url: "updateGpImg",
		data: formData,
		async:false,
		processData: false,
		contentType: false,
		success:res=>{
			console.log(res);
			let output= '';
			output +='<div class="spinner-border mx-auto my-5" role="status">'
			output +=	'<span class="sr-only">Loading...</span>'
			output += '</div>'
			$("#gpInfo").html(output);
			setTimeout(function(){ location.reload(); }, 5000);
			 
			
		}
		
	});

}


/* 목록 (tab) */
const tabs1 = document.querySelectorAll("[data-tab-target]")
const tabcon = document.querySelectorAll("[data-tab-content]")
tabs1.forEach((tab)=>{
	tab.addEventListener("click",()=>{
		const target = document.querySelector(tab.dataset.tabTarget);
		tabcon.forEach((tabc_all) => {
			tabc_all.classList.remove("active")
		})
		target.classList.add("active")
	})
})

	
	
//그룹 가입 클릭시 값이없으면 인서트 있으면 딜리트 기능하는 함수
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
				sendNotification("REQUEST",gpNum,gpNum);
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



 	function joinGpMem(memId,gpNum) {
		$.ajax({
			type:"post",
			url:"joinGpMem",
			data:{"memId":memId ,"gpNum":gpNum},
			dataType:"text",
			success:function(res){
				if(res =="OK"){
					location.reload();
					sendNotification("APPLY",memId,gpNum);
				}
			}
		})
	}
	function cancelRqMem(memId,gpNum){
		console.log("거절")
			$.ajax({
			type:"post",
			url:"cancelRqMem",
			data:{"memId":memId ,"gpNum":gpNum},
			dataType:"text",
			success:function(res){
				if(res =="OK"){
					
					location.reload();
				
				}
			}
		})
	}	 
	
	
	
	
	/* 좋아요 관련 기능  */
	  function checkLike(memId,boNum,obj){
		  console.log("요청");
		  console.log("memId : " + memId + "  "+ "boNum : " + boNum);
		  console.log(obj)
		  $.ajax({
			  type : "get",
			  url : "boardLike",
			  data : {
				  "memId" : memId,
				  "boNum" : boNum
			  },
			  datatype : "json",
			  async : false,
			  success : function(result){
				  $("#likeCount").text(result);
			  },
			  error : function(){
				  alert("실패");
			  }
		  });
		 $(obj).find('i').toggleClass("fa");
		 $(obj).find('i').toggleClass("far");
	}

	function isLike(memId,boNum){
		//console.log("하트변환 요청!");
		//console.log(memId +"   "+ boNum);
		let output = "";

		$.ajax({
			type : "get",
			url : "isLike",
			data : {
				"memId" : memId,
				"boNum" : boNum
			},
			dataType : "text",
			async:false,
		   success : function(result){
			  
			   if(result == ''){
				   output = '<i class="far fa-heart"></i>';
			   }else{
				   output = '<i class="fa fa-heart"></i>'; 
			   }
		   },
		});
		return output;
	}

	function likeCount(boNum){
		console.log("갯수 확인");

		let output = "";
		$.ajax({
			 type : "get",
			  url : "likeCount",
			  data : {
				  "boNum" : boNum
			  },
			  async : false,
			  success : function(result){
				  if(result == 0){
					  output= '';
				  } else{
				 output = result;
				  }
			  },
			  error : function(){
				  alert("실패");
			  }
		});
		return output;
	}


	//파일 이미지 출력
	function handleFileSelect(evt) {
		var files = evt.target.files;

		document.getElementById('list').innerHTML = ""
		
		// 파일리스트 반복 이미지파일 축소후 렌더링
		for (var i = 0, f; f = files[i]; i++) {
			
			console.log(f.type)

		// 오직 이미지 파일만 처리
		if (!f.type.match('image.*')&&!f.type.match('video.*')) {
			continue;
		   } 

		var reader = new FileReader();

		// 파일정보 캡쳐를 위해 닫기
		reader.onload = (function(theFile) {
		return function(e) {
			          // 썸네일 렌더링
			          console.log(e);
			          
			          var span = document.createElement('div');
			          span.classList.add("d-inline-block")
			          if(theFile.type.match('image.*'))
			          	span.innerHTML = 
			          	[
			            	'<img style="height: 75px; border: 1px solid #000; margin: 5px" src="', 
			            	e.target.result,
			            	'" title="', escape(theFile.name), 
			            	'"/>'
			          	].join('');
			          else if(theFile.type.match('video.*'))
			        	span.innerHTML = 
					    [
					         '<video style="height: 75px; border: 1px solid #000; margin: 5px" src="', 
					         e.target.result,
					         '" title="', escape(theFile.name), 
					         '"/>'
					    ].join('');
			          
			          document.getElementById('list').insertBefore(span, null);
			        };
			      })(f);

			      // 이미지파일을 데이터 URL 로 읽기
			      reader.readAsDataURL(f);
			    }
			  }

			  document.getElementById('files').addEventListener('change', handleFileSelect, false);
	
			  
			  
			  
			  /* 사진 여러개 */
			  function multiCard(boNum){
			  	let grCard = "";
			  	
			  	console.log("multi load")
			  	
			  	$.ajax({
			  		type:"get",
			  		url:"getGroupByBoGroupNum?boGroupNum=" + boNum,
			  		dataType:"json",
			  		async : false,
			  		success: res=>{
			  			res.forEach(r=>{
			  				if(r.boType == "PICTURE")
			  					grCard += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+r.boFile+'">'
			  				else if(r.boType == "VIDEO")
			  					grCard += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+r.boFile+'" controls></video>'
			  			})
			  		}
			  	})
			  	
			  	return grCard;
			  }
	
	
			  /* 공유 모달 열기 */
			  function shareBoard(boNum) {
			  	
			  	$.ajax({
			  		type: "get",
			  		url: "checkShareDuplicate?boNum=" + boNum + "&loginId=" + ${sessionScope.loginId},
			  		async : false,
			  		success: res=>{
			  			if(res == "valid"){
			  				$("#shareModalCenter").modal("show");
			  				var text = $("#shareText").val();
			  				if(text == "" || text == null){
			  					$("#shareWriteBtn").attr('disabled', 'disabled');
			  				}
			  				$("#boFile").val(boNum);
			  			}else if(res == "invalid"){
			  				alert("이미 공유한 게시물입니다");
			  			}
			  		}
			  	})
			  }	
	
	
	
	
</script>
</html>