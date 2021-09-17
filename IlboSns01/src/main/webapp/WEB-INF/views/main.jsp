<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="includes/Links.jsp"%>
<style>
.horizontal-scrollable>.row {
	overflow-x: auto;
	white-space: nowrap;
	min-height: 0;
	flex-wrap: nowrap;
}

.horizontal-scrollable>.row>.col-xs-4 {
	display: inline-block;
	float: none;
}

.recommendCard {
	width: 150px;
	height: 200px;
	border: 1px solid rgba(0, 0, 0, 0.2);
	border-radius: 10px;
}
</style>
</head>
<body>
	<%@ include file="includes/HomeHeader.jsp"%>
	<!-- Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle">게시물 만들기</h5>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
				<form action="boardWrite" id="uploadForm" method="post" enctype="multipart/form-data">
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
							<textarea class="emojionearea1" rows="10" cols="43" id="text" style="border: none; margin-top: 10px;" name="boContent"></textarea>
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
	<!-- End Modal -->
	<!-- UPDATE Modal START-->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalCenterTitle">게시물 수정</h5>
					<div class="p-2">
						<input type="button" class="btn btn-outline-primary me-0" value="수정" id="modifyBtn" onclick="modifySubmit.click()">
						<button type="button" class="close btn btn-outline-danger" data-dismiss="modal" aria-label="Close">취소</button>
					</div>
				</div>
				<form action="boardModify" id="modifyForm" method="post">
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
							<textarea class="emojionearea1" rows="10" cols="43" id="Moditext" style="border: none; margin-top: 10px;" name="boContent"></textarea>
						</div>
					</div>
					<input type="hidden" id="modiBoNum" name="boNum">
					<input type="hidden" name="boWriter" value="${sessionScope.loginId }">
					<input type="submit" id="modifySubmit" class="d-none">
				</form>
				<div class="modal-footer">
					<!--  <button type="button" class="btn btn-secondary" data-dismiss="modal"  >Close</button> -->
					<div id="fileList" class="w-100">
						<div class="card my-2">
							<div class="card-header text-end">
								<a onclick="deleteBoard()">삭제 X</a>
							</div>
							<div class="card-body">게시글의 사진</div>
						</div>
					</div>
					<div id="fileInputBox" class="card-body pt-3" style="margin-top: 10px; border: 1px solid rgba(0, 0, 0, 0.2); border-radius: 10px">
						<label for="fileGet"> <img src="${pageContext.request.contextPath }/resources/assets/img/picture.png" width="40px" height="40px" id="upload">
						</label>
						<input id="fileGet" type="file" name="file" class="d-none" onchange="updateAttach(this)">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- UPDATE Modal END-->
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
							<textarea class="emojionearea1" rows="10" cols="43" id="shareText" style="border: none; margin-top: 10px;" name="boContent"></textarea>
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
	<!-- 글 상세보기 모달 시작 -->
	<div class="modal fade" id="boardViewModal" tabindex="-1" role="dialog" aria-labelledby="boardViewModal" aria-hidden="true">
		<div id="modalOverlay" style="display: none">
			<div class="d-flex justify-content-between" style="height: 100%">
				<div class="my-auto px-4" id="goToBefore" style="cursor: pointer; color: rgba(255, 255, 255, 0.7)" onclick="boardViewList.before()">
					<i class="fas fa-chevron-left"></i>
				</div>
				<div class="my-auto px-4" id="goToNext" style="cursor: pointer; color: rgba(255, 255, 255, 0.7)" onclick="boardViewList.next()">
					<i class="fas fa-chevron-right"></i>
				</div>
			</div>
		</div>
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="d-flex flex-row">
					<div class="d-flex flex-column w-100">
						<div class="modal-header">
							<!-- 글쓴이 정보 -->
							<!-- 글쓴이 정보 -->
							<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">X</button>
						</div>
						<div class="modal-body" style="word-break: break-all; max-height: 800px; overflow-y: auto">
							<!-- 글 정보 -->
							<!-- 글 정보 -->
						</div>
					</div>
					<div id="boardViewReplyArea" class="rounded" style="border: 1px solid rgba(0, 0, 0, 0.2); min-width: 411px;">
						<!-- 댓글 정보 -->
						<!-- 댓글 정보 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 글 상세보기 모달 끝 -->
	<!-- 왼쪽 사이드 바 -->
	<div class="row gy-5 justify-content-center" style="margin-top: 102px; min-height: 77vh;">
		<div class="col-lg-3 d-flex justify-content-end">
			<section style="position: fixed" data-aos="fade-right">
				<div class="d-flex flex-column " id="sidebar">
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="changeSection(newsfeed)">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/home-icon.png" class="icon">메인
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="location.href='GroupPage'">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/group-icon.png" class="icon">그룹
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 " onclick="changeSection(recommendMember)">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/glass-icon.png" class="icon">친구추천
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4" onclick="changeSection(rankingBox)">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/fire-icon.png" class="icon">인기글
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/cs-icon.png" class="icon">고객센터
					</button>
				</div>
			</section>
		</div>
		<div class="col-lg-5">
			<!-- ======= Values Section ======= -->
			<section id="newsfeed" class="newsfeed mainSection">
				<div class="container" data-aos="fade-up">
					<!-- Button trigger modal -->
					<!-- <button type="button" id="boardWriteBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">게시글	작성하기</button> -->
					<!---------------------------------------------------------------------------------->
					<h2 class="text-primary text-center">뉴스피드</h2>
					<div class="card" id="boardWriteCard">
						<div class="card-body d-flex justify-content-between">
							<div class="flex-grow-1">
								<button id="boardWriteBtn" class="btn-light btn">${sessionScope.loginName}님 무슨 생각을 하고계신가요?</button>
							</div>
							<div>
								<a href="memberInformation">
									<img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle">
								</a>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div class="d-flex flex-column mt-5" id="contentBox"></div>
							<div class="text-center">
								<div class="spinner-border mx-auto my-5" role="status">
									<span class="sr-only"></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- Start Ranking Section -->
			<section id="rankingBox" class="mainSection d-none">
				<div class="container">
					<h2 class="text-primary text-center">인기글</h2>
					<ul class="nav nav-tabs justify-content-end">
						<li class="nav-item " data-tab-target="#shareRankingArea"><a class="nav-link active" data-bs-toggle="tab" href="#shareRankingArea">공유하기</a></li>
						<li class="nav-item " data-tab-target="#likeRankingArea"><a class="nav-link" data-bs-toggle="tab" href="#likeRankingArea">좋아요</a></li>
						<li class="nav-item " data-tab-target="#replyRankingArea"><a class="nav-link" data-bs-toggle="tab" href="#replyRankingArea">댓글</a></li>
					</ul>
					<div class="tab-content">
						<div id="shareRankingArea" data-tab-content class="active"></div>
						<div id="likeRankingArea" data-tab-content></div>
						<div id="replyRankingArea" data-tab-content></div>
					</div>
				</div>
			</section>
			<!-- End Ranking Section -->
			<!-- End Values Section -->
			<!-- Member Recommendation Section Start -->
			<section id="recommendMember" class="mainSection d-none">
				<div class="container" data-aos="fade-up">
					<h2 class="text-primary text-center">친구 추천</h2>
					<div class="horizontal-scrollable mt-5" id="recomendField"></div>
				</div>
			</section>
			<!-- Member Recommendation Section End -->
		</div>
		<div class="col-lg-4">
			<section id="sideListSection"></section>
		</div>
	</div>
	<%@ include file="includes/Footer.jsp"%>
	<%@ include file="includes/script.jsp"%>
</body>
<script>
window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	getFollows();
	getBoard();
	getRanking()
	memberRecommend()
	getFollowers();
	
	if(${param.page != null}){
		changeSection(${param.page});
	}
})

function changeSection(sectionId){
	
	document.querySelectorAll(".mainSection").forEach(section=>section.classList.add("d-none"));
	sectionId.classList.remove("d-none");
	
}

function getBoard(){
	
	$.ajax({
		type:"get",
		url:"getBoard?num=0",
		dataType:"json",
		success:res=>{
			for(let i in res){
				createContentInCard(res[i])
			}
			//해시태그
			var contentLength = document.getElementsByClassName('contentElement').length;
			for (let i = 0; i < contentLength; i++){ 
				var content = document.getElementsByClassName('contentElement')[i].innerHTML;
				
			
				var splitedArray = content.split(' ');
				var linkedContent = '';
				for(var hashTag in splitedArray)
				{
				  hashTag = splitedArray[hashTag];
				   if(hashTag.indexOf('#') == 0)
				   {
					  
				      var word = hashTag.replaceAll("#","%23"); //#은 컨트롤러로 넘길때 나오지않아서 변환 %23 = # 
					   hashTag = '<a href=\'hashTagSelect?hashTag='+word+'\'>'+hashTag+'</a>';
				   }
				   linkedContent += hashTag+' ';
				}
				document.getElementsByClassName('contentElement')[i].innerHTML = linkedContent;  
			}
		}
	})
}

/* 인기글 관련 (시작) */

function getRanking(){
	
	//공유하기 많은 순 불러옴 
	var getShareRankingAjax = $.ajax({type:"get",url:"getShareRanking",dataType:"json",async:false});
	var getLikeRankingAjax = $.ajax({type:"get",url:"getLikeRanking",dataType:"json",async:false});
	var getReplyRankingAjax = $.ajax({type:"get",url:"getReplyRanking",dataType:"json",async:false});
	
	$.when(getShareRankingAjax,getLikeRankingAjax,getReplyRankingAjax).done(function(shareRank,likeRank,replyRank){

		for(var i in shareRank){
			let renderedRanking = renderRanking(shareRank[0][i],i,"share");
			shareRankingArea.appendChild(renderedRanking);
			}

		for(var i in likeRank){
			let renderedRanking = renderRanking(likeRank[0][i],i,"like");
			likeRankingArea.appendChild(renderedRanking);
			}

		for(var i in replyRank){
			let renderedRanking = renderRanking(replyRank[0][i],i,"reply");
			replyRankingArea.appendChild(renderedRanking);
			}

	})
		
}
/* 탭 관련 */
const tabs = document.querySelectorAll('[data-tab-target]')
const tabContents = document.querySelectorAll('[data-tab-content]')

tabs.forEach(tab => {
  tab.addEventListener('click', () => {
    const target = document.querySelector(tab.dataset.tabTarget)
    tabContents.forEach(tabContent => {
      tabContent.classList.remove('active')
    })
    tabs.forEach(tab => {
      tab.classList.remove('active')
    })
    tab.classList.add('active')
    target.classList.add('active')
  })
})

function renderRanking(l,i,type) {
	
	// 인기글 개별로 div 객체 생성
	let rankingCard = document.createElement("div");
	rankingCard.classList.add("card","border-primary","my-3");
	
	// 인기글 카드의 Header div 객체 생성
	let rankingCardHeader = document.createElement("div");
	rankingCardHeader.classList.add("card-header","d-flex","justify-content-between");
	let interaction = document.createElement("span");
	
	let rank = document.createElement("div");
	let rankSpan = document.createElement("span");
	let rankIcon = document.createElement("img");
	
	// numOfInteraction 출력
	if(type=="share"){
		interaction.innerText = "공유 "+l.numOfInteraction+"회";
	}
	else if(type=="like"){
		interaction.innerText = "좋아요 "+l.numOfInteraction+"개";
	}
	else if(type=="reply"){
		interaction.innerText = "댓글 "+l.numOfInteraction+"개";
	}
	
	// 순위 출력	
	rankIcon.setAttribute("src","${pageContext.request.contextPath }/resources/assets/img/logo/"+i+"-icon.png");
	rankIcon.setAttribute("class","rank-icon");
	rankSpan.innerText = (++i)+"등";
	rank.append(rankIcon);
	rank.append(rankSpan);
	
	// Header div에 append
	rankingCardHeader.append(rank);
	rankingCardHeader.append(interaction);
	
	// body에 게시글 content 넣어줌
	let rankingCardBody = document.createElement("div");
	rankingCardBody.classList.add("card-body");
	let rankingContent = document.createElement("h4");
	rankingContent.classList.add("card-title");
	rankingCardBody.innerHTML = renderSharedCard(l);
	
	rankingCardBody.append(rankingContent);
	rankingCard.append(rankingCardHeader);
	rankingCard.append(rankingCardBody);
	
	return rankingCard;
	
}



/* 인기글 관련(끝) */


function createContentInCard(dd){
	//게시글 박스 안에 게시글을 넣음
	boardStorage.setItem('board'+dd.boNum, dd);
	
	let renderedCard = renderContentCard(dd);
	let renderedReplyDiv = getReply(dd.boNum);
	
	renderedCard.appendChild(renderedReplyDiv);
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

function getNewCard(islast){
	//마지막 게시글이라면 또다른 게시글들을 불러옴
	if(islast){
		$.ajax({
			type:"get",
			url:"getBoard?num=" + contentBox.children.length,
			dataType:"json",
			success:res=>{
				for(let i in res){
					createContentInCard(res[i])
				}
			}
		})
	}
}

/* 
//댓글 인기글 관련
function createReplyRanking(r) {
	let renderedReplyRanking = renderReplyRanking(r);
	
	replyRankingArea.appendChild(renderedReplyRanking);
}

function renderReplyRanking(r) {
	let replyRankingContent = document.createElement("p");
	let output = "";
	output += '<span class = "contentFontSize">' + r.boContent + '</span>'
	output += '<span style = "float: right"> <i  class="far fa-comment-alt me-1"></i>:' + r.numOfInteraction + "</span>"
	output += '<hr>'
	replyRankingContent.innerHTML = output;
	console.log("output: " + output);
	return replyRankingContent;
}

//좋아요 인기글 관련
function createLikeRanking(l) {
	let renderedLikeRanking = renderLikeRanking(l);
	
	likeRankingArea.appendChild(renderedLikeRanking);
}

function renderLikeRanking(l) {
	
	let likeRankingContent = document.createElement("p");
	let output = "";
	output += '<span class = "contentFontSize">' + l.boContent + '</span>' +' <span style = "float: right"> <i  class="fa fa-heart"></i>: ' + l.numOfInteraction + "</span>";
	output += '<hr>';
	likeRankingContent.innerHTML = output;
	return likeRankingContent;
}

//공유하기 인기글 관련
function createShareRanking(s) {
	let renderedShareRanking = renderShareRanking(s);
	
	shareRankingArea.appendChild(renderedShareRanking);
}

function renderShareRanking(s) {
	let shareRankingContent = document.createElement("p");
	let output = "";
	output += '<span class = "contentFontSize">' + s.boContent + '</span>' +' <span style = "float: right"> <i  class="far fa-share-square me-1"></i>: ' + s.numOfInteraction + "</span>";
	output += '<hr>';
	shareRankingContent.innerHTML = output;
	return shareRankingContent;
} */

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

//게시글이 길 경우 접힌부분을 펼침
function spreadText(o){
	console.log(o)
	obj = o.firstChild
	if(o.parentElement.getAttribute("is-spread") == "fold"){
		obj.style.overflow = "visible";
		obj.style.display = "block";
		o.style.maxHeight = "";
		o.parentElement.parentElement.style.maxHeight = "";
		o.parentElement.setAttribute("is-spread","spread");
		
		if(o.parentElement.children[1].classList.contains("fileBox"))
			o.parentElement.children[1].style.maxHeight = "";
	} else {
		obj.style.overflow = "hidden";
		obj.style.display = "-webkit-box";
		o.style.maxHeight = contentBox.offsetWidth/2 + "px";
		o.parentElement.parentElement.style.maxHeight = "40rem";
		o.parentElement.setAttribute("is-spread","fold");
		
		if(o.parentElement.children[1].classList.contains("fileBox"))
			o.parentElement.children[1].style.maxHeight = contentBox.offsetWidth + "px";
	}
}

//데이터d 를 받아와 게시글 카드를 그려줌
function renderContentCard(d){
	
	let contentBoxWidthLength = 555;
	let cardTemplate = document.createElement("div");
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0" id="board'+d.boNum+'" data-id="'+d.boNum+'" data-mem-id="'+d.memId+'" tabindex="-1" onfocus="getNewCard(isLast(this))">'
	output += 	'<div class="card-header d-flex justify-content-between">'
	output += 		'<div class="d-flex">'
	output += 			'<div style="align-self : center;"><img class="rounded-circle profileIcon" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px" style="object-fit : cover; cursor:pointer;" onclick="location.href=\'memberInformation?memId='+d.memId+'\'"></div>'
		output += 		'<div class="px-3 pt-1">'
			if(d.gpName !=null){
				output += 	'<a style="color:#555f86" href="groupInfo?gpNum='+d.boGpNum+'"><h6 class="card-title" style="margin-bottom: 1px;">'+d.gpName+'</h6></a>'
			}
		output += 			'<h5 class="card-title">'+d.memName+'</h5>'
		output += 			'<h6 class="card-subtitle mb-2 text-muted small">' + pastTime(d.boDate) + (d.boModDate == null? "" : "(수정됨)") + " " + visiblityIcon(d.boVisiblity) + '</h6>'
	output +=		'</div></div>'
	output +=		'<div class="dropdown" style="z-index:5;align-self: center;">'
		output +=		'<button class="card-menu-btn btn-outline-secondary btn"  id="boardDropDown'+d.boNum+'" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
		output +=		'<div class="dropdown-menu" aria-labelledby="boardDropDown'+d.boNum+'">'
	if(d.memId == loginId){
					output +='<a class="dropdown-item" onclick="boardModify(board'+d.boNum+')">수정</a>'
					output +='<a class="dropdown-item" onclick="boardDelete(board'+d.boNum+')">삭제</a>'
	}
					output +='<a class="dropdown-item" onclick="boardView(\''+d.boNum+'\')">상세보기</a></div>'
	output +=		'</div>'
	output += 	'</div>'
	output += '<div onclick="spreadText(this.firstChild)" is-spread="fold" style="overflow:hidden"><div class="card-body" data-type="'+d.boType+'" style="max-height:'+(contentBoxWidthLength/3)+'px">'
	output += '<p class="card-text text contentElement">'+(d.boContent == null ? "" : d.boContent)+'</p>'
	output += '</div>'
		if(d.boFile != null){
			if(d.boType == "PICTURE"){
				output += '<div class="fileBox" style="overflow:hidden; max-height:'+contentBoxWidthLength*2/3+'px">'
				output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
				output += '</div>'
			} else if(d.boType == "SHARE"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength*2/3+'px">'
				output += shareCard(d.boFile);
				output += '</div>'
			} else if(d.boType == "VIDEO"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength*2/3+'px">'
				output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+d.boFile+'" controls></video>'
				output += '</div>'
			}		
		}
		if(d.boType == "MULTI"){
			output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength*2/3+'px">'
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


function visiblityIcon(v){
	if(v == "전체공개")
		return '<i class="fas fa-globe-africa"></i>';
	else if(v == "친구만")
		return '<i class="fas fa-user-friends"></i>';
	else
		return '<i class="fas fa-user-lock"></i>';
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
				boardStorage.setItem('board'+r.boNum, r);
				
				if(r.boType == "PICTURE")
					grCard += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+r.boFile+'">'
				else if(r.boType == "VIDEO")
					grCard += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+r.boFile+'" controls></video>'
			})
		}
	})
	
	return grCard;
}

/* 공유된 게시물 카드 */
function shareCard(boNum){
	let shCard = "";
	
	$.ajax({
		type:"get",
		url:"getBoardByBoNum?boNum=" + boNum,
		dataType:"json",
		async : false,
		success: res=>{
			 shCard = renderSharedCard(res)
		}
	})
	
	return shCard;
}

function renderSharedCard(d){
	let contentBoxWidthLength = contentBox.offsetWidth;
	
	output = "";
	output += '<div class="card mb-3 divFocusBorder-0" tabindex="-1">'
		output += '<div class="card-header d-flex justify-content-between">'
			output += '<div class="d-flex"><img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px">'
				output += '<div class="px-3 pt-1"><h5 class="card-title">'+d.memName+'</h5>'
					output += '<h6 class="card-subtitle mb-2 text-muted small">' + pastTime(d.boDate) + (d.boModDate == null ? "" : "(수정됨)") +" " +visiblityIcon(d.boVisiblity)+'</h6>'
				output += '</div></div>'
			output += '</div>'
		output += '<div><div class="card-body ">'
	output += '<p class="card-text">'+d.boContent+'</p>'
	output += '</div>'
		if(d.boFile != null){
			if(d.boType == "PICTURE"){
				output += '<div class="fileBox">'
				output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
				output += '</div>'
			} else if(d.boType == "VIDEO"){
				output += '<div class="fileBox p-2">'
				output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+d.boFile+'" controls></video>'
				output += '</div>'
			}
		}
		if(d.boType == "MULTI"){
			output += '<div class="fileBox p-2">'
			output += multiCard(d.boNum);
			output += '</div>'
		}
	output += '</div></div>'

	return output;
}

//게시글의 상, 하를 비교하여 화면의 어떤 위치에 있는 게시글을 골라냄
function isElementInViewport(el){
    let rect = el.getBoundingClientRect();
    return rect.bottom > 0.73*window.innerHeight && rect.top < 0.67*window.innerHeight;
}

/* 게시글 작성 (시작)  */

function boardDelete(obj){
		console.log(obj)
		
		let bnum = obj.id.substring(5);
		
		let option = {
			method : "delete",
			headers : {
				contentType : "application/json"
			}
		}

		
		fetch('board/'+bnum, option)
			.then(res=>res.text())
			.then(d=>{
				if(d == "success"){
					let card = obj;
					
					card.innerHTML = "게시글이 삭제되었습니다."
					boardStorage.setItem('board'+bnum, "");
				}
			})
	}
	
	$('.close').click(function() {
		$('#exampleModalCenter').modal("hide"); //모달 닫기 
		$('#shareModalCenter').modal("hide"); //공유 모달 닫기
		$('#chatroomCreateModal').modal("hide"); // 채팅방생성 모달 닫기
	});

	$('#boardWriteBtn').click(function(e) {
		var text = $("#text").val();
		e.preventDefault();
		$('#exampleModalCenter').modal("show"); //모달 열기
		
			if(text == "" || text == null){
				$("#writeBtn").attr('disabled', 'disabled');
		}
		
	});

	$("#text").on("change keyup paste",function() {
		var files = $("#files").val();
		var text = $("#text").val();
		if(text == "" ||text == null){
			$("#writeBtn").attr('disabled', 'disabled');
			$("#text").focus();
		} else {
			$("#writeBtn").removeAttr('disabled');
		}
	
	});
	
	$("#shareText").on("change keyup paste",function() {
		
		var text = $("#shareText").val();
		if(text == "" ||text ==null){
			$("#shareText").focus(); 
			$("#shareWriteBtn").attr('disabled', 'disabled');
			
		} else {
			$("#shareWriteBtn").removeAttr('disabled');
		}
	
	});
		
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
		async:false,
		success : res=>{
			
			let board = boardStorage.getItem('board'+boardNum);
			if(!(board == null)){
				board.reply = res;
				boardStorage.setItem('board'+boardNum, board);
			}
			
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
	// 댓글 계층 표현 (일반 댓글 : 0) (대댓글 : 50)
	if(res.reSeq != 1){
		var marginForLevel = 50;
	}
	// 댓글 표시
	output += "<li class='list-group-item'>"
		output += "<div class='d-flex' style='margin : 0.5rem 0 0.5rem "+marginForLevel+"px'>"
			output += '<div style="width:5rem;" class=""><img class="rounded-circle profileIcon" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'\" onclick="location.href=\'memberInformation?memId='+res.reWriter+'\'"></div>'
			output += '<div class="w-100 d-flex justify-content-between bg-light border-dark rounded p-3">'
				output += '<div class="d-flex flex-column flex-grow-1" onclick="inputReReply(this,\''+res.memName+'\','+res.reBoNum+','+res.reGroup+','+res.reWriter+','+res.reSeq+')">'
					output += '<h6 >'+res.memName+'</h6>'
					output += '<h6 class="text-muted small">' + pastTime(res.reDate) + '</h6>'
				if(res.reTagName!=null){
					output += '<div class="d-flex"><span class="text-primary me-2">'+res.reTagName+'</span><span>'+res.reContent+'</span></div>'
				}else{
					output += '<span>'+res.reContent+'</span>'
				}
				output += '</div>'
				if(res.reWriter==loginId){
				output += '<div>'
					output += '<button class="btn" onclick="replyDelete(this,'+res.reBoNum+','+res.reGroup+','+res.reSeq+')\"><i class="fas fa-times"></i></button>'
				output += '</div>'
				}
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
	output += "</li>";
	
	return output;
}

// 댓글 작성 함수
function replyWrite(obj){
	
	let inputArea = $(obj).prev().children();
	console.log(inputArea);
	let reContent = $(inputArea[0]).val();
	let reWriter = $(inputArea[1]).val();
	let reBoNum = $(inputArea[2]).val();
	let reGroup = $(inputArea[3]).val();
	let reTagId = $(inputArea[4]).val();
	let reSeq = $(inputArea[5]).val();
	
	$.ajax({
		type : "post",
		url : "replyWrite",
		data : {"reContent" : reContent, "reWriter" : reWriter, "reBoNum" : reBoNum, "reGroup" : reGroup, "reTagId" : reTagId, "reSeq" : reSeq},
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
	
	if(reTagId == null||'${sessionScope.loginId}' == reTagId){
		let memId = contentBox.querySelector("div[data-id='"+reBoNum+"']").getAttribute("data-mem-id");
		if(memId != '${sessionScope.loginId}')
			sendNotification("REPLY",memId,reBoNum+";"+reContent);
	}
	else if('${sessionScope.loginId}' != reTagId)
		sendNotification("CALL",reTagId,reBoNum+";"+reContent);
}

function inputReReply(obj,memName,reBoNum,reGroup,reWriter,reSeq){
	
	console.log("inputReReply | obj");
	console.log(obj);
	console.log("inputReReply | res");
	console.log(reWriter);
	
	if($(obj).parents('li').next().hasClass('rereply')){
		closeReplyInput(obj);
	}else{
	
	var output = "";
	
	output += "<li class='list-group-item rereply'>";
			output += "<div class='d-flex reply-input'>"
				output += '<img class="rounded-circle" src="${pageContext.request.contextPath}/resources/assets/img/profile/${sessionScope.loginProfile}">'
				output += "<div class='inputArea'>"
					output += '<input type="text" class="form-control" name="reContent" placeholder="@'+memName+'">'
					output += '<input type="hidden" name="reWriter" value="${sessionScope.loginId}">'
					output += '<input type="hidden" name="reBoNum" value="'+ reBoNum +'">';
					if(reGroup != null && reWriter){
						output += '<input type="hidden" name="reGroup" value="'+ reGroup +'">';
						output += '<input type="hidden" name="reTagId" value="'+ reWriter +'">';
						output += '<input type="hidden" name="reSeq" value="'+ reSeq +'">';
					}
				output += "</div>"
					output += "<button class='btn btn-sm btn-primary' onclick='replyWrite(this)'>"
						output += "등록"
					output += "</button>"
			output += "</div>"
	output += "</li>";
		
	$(obj).parents('li').after(output);
	}
}

function closeReplyInput(obj){
	console.log($(obj).parents('li').next());
	$(obj).parents('li').next().remove();
}

function replyDelete(obj,reBoNum,reGroup,reSeq){
	
	var replyDeleteAjax = $.ajax({url:"replyDelete",data:{"boNum":reBoNum,"reGroup":reGroup,"reSeq":reSeq},dataType:"text"});
	$.when(replyDeleteAjax).done(function(res){
		if(res=="success"){
			console.log('댓글이 삭제되었습니다');
		}else if(res="fail"){
			console.log('댓글 삭제 tlf패');
		}
		console.log(res);
		
		let oldUl = $(obj).parents("ul");						//예전 ul태그
		let replyArea = oldUl.parent();							//게시물 카드
		console.log(replyArea);
		
		var newUl = document.createElement("ul");				//새로운 ul태그
		newUl = getReplyAjax(reBoNum,newUl); 					//댓글 새로 받아오기
		
		$(oldUl).remove();
		$(replyArea).append(newUl);
	});
}

/* 헤더 버튼 관련 */



/* 팔로우 목록 관련 */

$("#followListBtn").click(function() {
	console.log("팔로우리스트 클릭");
	$("#sideListSection").empty();
	
	/* getFollows(getFollowers); */
	getFollowers(getFollows());
	/* getFollowers(); */
})

$(document).ready(function(){
	$(".emojionearea1").emojioneArea();
})
 
function getFollows(){
	
	//팔로우 목록 받아오기
	var getFollowsAjax = $.ajax({url:"getFollows", data:{"memId" : loginId }, dataType:"json"});
	//팔로우 하는 유저 온오프라인 정보 받아오기
	var onlineCheckAjax = $.ajax({url:"http://192.168.0.56:22123/user/follow/"+loginId, dataType:"json"});
	
	//res : 팔로우 목록 // res2 : 팔로우 하는 유저 온오프라인 정보
	$.when(getFollowsAjax, onlineCheckAjax).done(function(res, res2){
		
		let followArea = document.createElement("div");
			followArea.setAttribute("id","followArea");
			followArea.setAttribute("data-aos","fade-right");
			followArea.setAttribute("class","accordion");
			

			followArea.innerHTML = "<h2 class='text-primary'>팔로우 목록</h2>";

		if(res[0].length > 3){
			
			for(var i=0;i<3;i++){
				let renderedFollowList = renderFollowList(res[0][i],res2[0][i],"follow");
				followArea.appendChild(renderedFollowList);
			}
			
			addReadMoreBtn(followArea);
			
		}else{

			for(var i in res[0]){
				let renderedFollowList = renderFollowList(res[0][i],res2[0][i],"follow");
				followArea.appendChild(renderedFollowList);
			}
		}
		$("#sideListSection").append(followArea);
	});
}

function getFollowers(callback){
	
	//팔로워 목록 받아오기
	var getFollowersAjax = $.ajax({url:"getFollowers", data:{"memId" : loginId }, dataType:"json"});
	//팔로워 온오프라인 정보 받아오기
	var onlineCheckAjax = $.ajax({url:"http://192.168.0.56:22123/user/follower/"+loginId, dataType:"json"});
	
	$.when(getFollowersAjax, onlineCheckAjax).done(function(res, res2){
		
		let followerArea = document.createElement("div");
			followerArea.setAttribute("id","followerArea");
			followerArea.setAttribute("data-aos","fade-left");
			followerArea.setAttribute("class","accordion mt-3");

			followerArea.innerHTML = "<h2 class='text-primary'>팔로워 목록</h2>";

		if(res[0].length > 3){
			
			for(var i=0;i<3;i++){
				let renderedFollowerList = renderFollowList(res[0][i],res2[0][i],"follower");
				followerArea.appendChild(renderedFollowerList);
			}
			
			addReadMoreBtn(followerArea);
			
		}else{

			for(var i in res[0]){
				let renderedFollowerList = renderFollowList(res[0][i],res2[0][i],"follower");
				followerArea.appendChild(renderedFollowerList);
			}
		}
		$("#sideListSection").append(followerArea);
	});
}	

function addReadMoreBtn(followArea){
	let output = "";
	let accordionItem = document.createElement("div");
	accordionItem.setAttribute("class","accordion-item");
	
	output += '<h2 class="accordion-header">'
	output += '<button class="accordion-btn" type="button" aria-expanded="false" onclick="location.href=\'followList\'"> 더 보기 </h2>';
	
	accordionItem.innerHTML = output;
	followArea.appendChild(accordionItem);
	
}

function renderFollowList(f,onOffCheck,type){
	
	let accordionItem = document.createElement("div");
	accordionItem.setAttribute("class","accordion-item");
	let output = "";
	
			output += '<button class="accordion-btn collapsed d-flex justify-content-between" type="button" data-bs-toggle="collapse" '
			
			if(type=="follow"){output += 'data-bs-target="#collapse1' + f.flwReceiver}
			else if(type=="follower"){output += 'data-bs-target="#collapse2' + f.flwFollower}
			
			output += '" aria-expanded="false" aria-controls="collapseOne">'
				output += '<div>'
					output += '<img class="rounded-circle" src="${pageContext.request.contextPath}/resources/assets/img/profile/'+f.memProfile+'\"><span>'+f.memName+'</span>'
				output += '</div>'
					if(onOffCheck != undefined){
						if(onOffCheck.userStatus == "online"){
							output += '<span class="online onlineSign'+onOffCheck.userId+'">온라인</span>'
						}else if (onOffCheck.userStatus == "offline"){
							output += '<span class="offline onlineSign'+onOffCheck.userId+'">오프라인</span>'
						}
					}
				output += '</button>'
		
		output += '<div id='
		
			if(type=="follow"){output+= '"collapse1' + f.flwReceiver + '" class="accordion-collapse collapse" data-bs-parent="#followArea" style="">'}
			else if(type=="follower"){output+= '"collapse2' + f.flwFollower + '" class="accordion-collapse collapse" data-bs-parent="#followerArea" style="">'}
				
			output += '<div class="accordion-body">'
			<!-- 의미없는 내용 -->
			output += '<button class="btn btn-primary" onclick="location.href=\'memberInformation?memId='+onOffCheck.userId+'\'">프로필 보기</button>'
			output += '</div>'
		output += '</div>'
	
	accordionItem.innerHTML = output;
	
	return accordionItem;
}

 /* 채팅 관련 기능 */

/*
function getChatRoomList(){
	
	let chatroomListArea = document.createElement("div");
	chatroomListArea.setAttribute("id","chatroomListArea");
	chatroomListArea.setAttribute("class","list-group");
	chatroomListArea.setAttribute("data-aos","fade-left");
	chatroomListArea.style.maxHeight="calc(65vh)"
	chatroomListArea.style.overflowY="scroll"
	
	chatroomListArea.innerHTML = "<p>채팅방 목록</p>";
	
	$.ajax({
		type : "get",
		data : {"loginId" : loginId},
		url : "http://192.168.0.56:22123/chat/"+loginId,
		dataType : "json",
		success : res=>{
			console.log(res);
			
			for(var i in res){
				let renderedChatroomList = renderChatroomList(res[i]);
				chatroomListArea.appendChild(renderedChatroomList);
			}
			$("#sideListSection").append(chatroomListArea);
		}
	})
	
	var output = '<button id="createChatroomBtn" class="btn btn-light" onclick="chatroomModal()">새로운 채팅방 만들기<i class="fas fa-plus-circle"></i></button>';
	$("#sideListSection").html(output);
}

function renderChatroomList(list){
	let accordionItem = document.createElement("div");
	accordionItem.setAttribute("class","accordion-item");
	accordionItem.setAttribute("data-roomId",list.roomId);
	let output = "";
		output += '<button type="button" class="list-group-item list-group-item-action" onclick="openChatting(\''+list.roomId+'\', \''+list.roomName+'\')">';
	    if(list.roomName==undefined){
	    	output += "채팅방 이름을 찾을 수 없습니다."
	    }else{
	    	output += list.roomName
	    }
	    output += "<span style='color:rgba(0,0,0,0.4); font-weight:bolder'> " + list.roomPeople + "</span> <br>"
	    
	    if(list.roomLastChat != null){
	    	output += "<small style='color:rgba(0,0,0,0.6)'>마지막 채팅 : " + pastTime(list.roomLastChat) + "</small>";
	    }
		
	    output += '</button>'
	
	accordionItem.innerHTML = output;
	
	return accordionItem;
}

function chatroomModal(){
	console.log("createChatroomBtn click");
	$('#chatroomCreateModal').modal("show"); //모달 열기
}


function appendCreateChatroomBtn(chatroomListArea){
	
}
 */
/* 좋아요 관련 기능  */

function checkLike(memId,boNum,obj){
	  
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
			  
			  if(!obj.querySelector("i").classList.contains("fa")){
				 	let memberId = contentBox.querySelector("div[data-id='"+boNum+"']").getAttribute("data-mem-id");
				 	if(memberId != loginId)
				 		sendNotification("LIKE",memberId,boNum);
				 }
			 
		  },
		  error : function(){
			  alert("실패");
		  }
		  
	  });

	  $(obj).find('i').toggleClass("fa");
	  $(obj).find('i').toggleClass("far");
}

function isLike(memId,boNum){
	
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
		   
	   }
	});
	
	return output;
}

function likeCount(boNum){

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


/* 채팅 시작 */
/* 
function createChatting(){
	var chatroomName = inputChatroomName.value;
	
	if(chatroomName==undefined){
		chatroomName = "${sessionScope.loginName}님의 채팅방";
	}
	
	fetch('http://192.168.0.56:22123/chat/'+chatroomName + "/" + '${sessionScope.loginId}', 
				{ 	method : "post", 
					headers : { ContentType : "application/json charset=utf-8" }
				}
	)
	.then(res => res.text())			
	.then(d =>{ 
		console.log("채팅방이 생성되었습니다. 채팅방 아이디 : " + d + " | 채팅방 이름 : " + chatroomName);
		});
}

function openChatting(roomNum, roomName){
	chattingCard.classList.remove("d-none");
	roomSelector.value = roomNum;
	chatroomName.innerText = roomName;
	
	/* 채팅방의 채팅 내용을 불러옴 */
	/*
	fetch('http://192.168.0.56:22123/chat/'+roomNum + "/" + '${sessionScope.loginId}', 
			{ 	method : "get", 
				headers : { ContentType : "application/json; charset=utf-8" }
			}
	)
	.then(res => res.json())
	.then(d =>{ 
		chattingCard.setAttribute("data-room-id", roomNum);
		renderChatForm(d)
		});
	
}

function renderChatForm(data){
	chatBox.innerHTML = "";
	
	console.log(data);
	
	for(let i in data){
		makeMessageForm(data[i])
	}
	
}

function makeMessageForm(msg){
	if(msg.sender == loginId){
		chatBox.innerHTML += renderSendedMsg(msg)
	} else {
		chatBox.innerHTML += renderReceivedMsg(msg)
	}
	
	chatBox.scrollTop = chatBox.scrollHeight;
}

function renderReceivedMsg(msg){
	let output = '';
	output += '<div class="incoming_msg">'
		output += '<div class="incoming_msg_img"> <img id="mem'+msg.sender+'" src="" alt=""> </div>'
		output += '<div class="received_msg">'
			output += '<span>'+msg.senderName+'</span>'
			output += '<div class="received_withd_msg">'
				output += '<p>'+msg.body+'</p>'
			output += '</div>'
		output += '</div>'
	output += '</div>'
	return output;
}

function renderSendedMsg(msg){
	let output = '';
	output += '<div class="outgoing_msg">'
		output += '<div class="sent_msg">'
		output += '<p>'+msg.body+'</p>'
	output += '</div></div>'
	return output;
}

function sendChat(){
	if(document.getElementById('roomSelector').value == 0)
		return;

	let senderIdName = document.getElementById('sender').innerText;
	let sendMsg = document.getElementById('inputMessage').value;
	let receiver = document.getElementById('roomSelector').value;

	if(sendMsg == ""){
		return;
	}

	let msg = { "type" : "CHAT",
				"sender" : senderIdName.split(";")[0],
				"senderName" : senderIdName.split(";")[1],
				"receiver" : receiver,
				"body" : sendMsg }
	
	console.log(msg)
	
	stompClient.send('/send/chat',{},JSON.stringify(msg));
	document.getElementById('inputMessage').value = "";
}


let behave = {
		whenCHAT : (data)=>{
			if(sideListSection.querySelector("#chatroomListArea") == null){
				messengerBtn.classList.add("btn-primary");
				messengerBtn.classList.remove("btn-secondary");
			}
			if(data.receiver == chattingCard.getAttribute("data-room-id"))
				makeMessageForm(data)
			},
		whenJOIN : (data)=>{
			if(sideListSection.querySelector("#chatroomListArea") == null){
				messengerBtn.classList.add("btn-primary");
				messengerBtn.classList.remove("btn-secondary");
			} else {
				getChatRoomList();
			}
		},
		whenONLINE : (data)=>$(".onlineSign"+data).html("온라인").removeClass("offline").addClass("online"),
		whenOFFLINE : (data)=>$(".onlineSign"+data).html("오프라인").removeClass("online").addClass("offline"),
		whenNOTI : (data)=>receiveNotification(data)
};
 */
//글 상세보기
function getBoardData(boNum){
	fetch('getBoardByBoNum?boNum='+boNum)
		.then(res=>res.json())
		.then(data=>{
			console.log(data);
			boardStorage.setItem('board'+data.boNum, data);
		})
}

async function boardView(boNum){
	let board = boardStorage.getItem('board'+boNum);
	if(board == null){
		await getBoardData(boNum);
		board = boardStorage.getItem('board'+boNum);
	}
	
	//프로필 부분 초기화
	if(boardViewModal.querySelector(".modal-header .d-flex") != null)
		boardViewModal.querySelector(".modal-header .d-flex").remove();
	//본문 부분 초기화
	if(boardViewModal.querySelector(".modal-body .card-body") != null)
		boardViewModal.querySelector(".modal-body .card-body").remove();
	//좋아요 부분 초기화
	if(boardViewModal.querySelector("#boardViewReplyArea .card-footer") != null)
		boardViewModal.querySelector("#boardViewReplyArea .card-footer").remove();
	//댓글 부분 초기화
	if(boardViewModal.querySelector("#boardViewReplyArea .replyArea") != null)
		boardViewModal.querySelector("#boardViewReplyArea .replyArea").remove();
	//첨부 부분 초기화
	if(boardViewModal.querySelector(".fileBox") != null)
		boardViewModal.querySelector(".fileBox").remove();
	
	let obj = renderContentCard(board);
	let renderedReplyDiv = getReply(board.boNum);
	obj.appendChild(renderedReplyDiv);
		
	//프로필 부분을 가져옴
	let profile = obj.querySelector(".card-header .d-flex").cloneNode(true);
	boardViewModal.querySelector(".modal-header").prepend(profile);
	
	//본문 부분을 가져옴
	let content = obj.querySelector(".card-body").cloneNode(true);
	content.style.maxHeight = "";
	let dataType = content.getAttribute("data-type"); // 글의 타입을 가져옴
	boardViewModal.querySelector(".modal-body").append(content);

	//좋아요 버튼
	let likeShareBtn = obj.querySelector(".card-footer").cloneNode(true);
	likeShareBtn.childNodes[0].children[0].classList.add("w-100");
	likeShareBtn.childNodes[0].children[2].classList.add("d-none");
	likeShareBtn.querySelector("div[data-bs-toggle]").classList.add("d-none");
	boardViewModal.querySelector("#boardViewReplyArea").append(likeShareBtn);
	
	
	
	//댓글 부분을 가져옴
	let reply = obj.querySelector(".replyArea").cloneNode(true);
	reply.classList.remove("collapse");
	boardViewModal.querySelector("#boardViewReplyArea").append(reply);
	
	if(obj.querySelector(".fileBox") != null){
		//첨부 부분을 가져옴
		let fBox = obj.querySelector(".fileBox").cloneNode(true); 
		fBox.style.overflow = "";
		fBox.style.maxHeight = "";
		boardViewModal.querySelector(".modal-body").append(fBox);
		
		console.log(fBox)
		modalOverlay.style.display = "block";
		
	}
	
	if(boardViewList.length == 0) //게시글 리스트를 생성
		boardViewList.init(boNum,dataType);
	
	$('#boardViewModal').modal("show");
}

$(".close").click(()=>{
	$('#boardViewModal').modal("hide"); // 글 상세보기 모달 닫기
	boardViewList.remove();
})

//게시글 리스트를 관리할 객체
let boardViewList = {
		data : new Array(),
		length : 0,
		now : 0,
		get : ()=>{
			return boardViewList.data[boardViewList.now]
			},
		next : ()=>{
			if(boardViewList.isEnd())
				return;
			boardViewList.now++;
			boardView(boardViewList.get());
			},
		before : ()=>{
			if(boardViewList.isStart())
				return;
			boardViewList.now--;
			boardView(boardViewList.get());
			},
		add : (num)=>{
			boardViewList.data.push(num); 
			boardViewList.length++;
			},
		init : (num, dataType)=>{
			boardViewList.data = new Array(); 
			boardViewList.length = 0; 
			boardViewList.now = 0;
			boardViewList.data.push(num);
			if(dataType == "MULTI")
				listInit(num);
			},
		isStart : ()=>{
			return boardViewList.now == 0;
			},
		isEnd : ()=>{
			return boardViewList.now == boardViewList.length
			},
		remove : ()=>boardViewList.init(null,"EMPTY")
}

function listInit(boNum){
	
	for(let i = 0 ; i < sessionStorage.length ; ++i){
		let board = boardStorage.getItem(sessionStorage.key(i));
		if(board.boGroupNum == boNum){
			console.log(board.boNum)
				boardViewList.add(board.boNum);
		}
	}
}

function boardModify(boardObj){
	let brd = boardStorage.getItem(boardObj.id);
	/* initialize */
	updateModal.querySelector(".divFocusBorder-0").value = "전체공개";
	updateModal.querySelector("textarea").innerHTML = "";
	updateModal.querySelector("#fileList").innerHTML = "";
	fileGet.setAttribute('data-bd-id', "");
	fileInputBox.style.display = "block";
	modiBoNum.value = "";
	
	
	/* data setting */
	updateModal.querySelector(".divFocusBorder-0").value = brd.boVisiblity;
	updateModal.querySelector(".emojionearea-editor").innerHTML = brd.boContent.replaceAll('<br>', '\r\n');
	if(brd.boType != "NORMAL" && brd.boType != "SHARE")
		updateFileLoad(brd);
	if(brd.boType == "SHARE")
		fileInputBox.style.display = "none";
	fileGet.setAttribute('data-bd-id', boardObj.id.substring(5));
	modiBoNum.value = fileGet.getAttribute('data-bd-id');
	
	/* server standby */
	fetch('modifyStandby/'+loginId)
		.then(res => res.text())
		.then(result => {
			if(result == "success"){
				/* Modal Show */
				$('#updateModal').modal("show");
			}	
		})
	
	
	
}

$(".close").click(()=>{
	$('#updateModal').modal("hide"); // 글 상세보기 모달 닫기
})
$("#updateModal").on('hidden.bs.modal', ()=>fetch("modifyCancel/"+loginId))//모달이 닫힐시 수정 취소

function updateFileLoad(brd){
	
	if(brd.boType == "MULTI"){
		for(let i = 0 ; i < sessionStorage.length ; ++i){
			let board = boardStorage.getItem(sessionStorage.key(i));
			if(board.boGroupNum == brd.boNum){
				fileList.appendChild(renderModifyFileCard(boardStorage.getItem('board'+board.boNum)));
			}
		}
	} else {
		fileList.appendChild(renderModifyFileCard(brd));
	}
}

function renderModifyFileCard(brd){
	let cardTemplate = document.createElement("div");
	let output = "";
	
	console.log(brd);
	
	output +=	'<div id="modiFile'+brd.boNum+'" class="card my-2">'
	output +=		'<div class="card-header text-end">'
	output +=			'<a style="cursor:pointer" onclick="modifyDeleteFile(\''+brd.boNum+'\')">삭제 X</a>'
	output +=		'</div>'
	
	output += '<div class="card-body">'
	output +=  		'<div class="spinner-border d-none mx-auto" role="status">'
	output +=				'<span class="sr-only">Loading...</span>'
	output +=		'</div>'
	if(brd.boType == "PICTURE")
		output +=	'<img class="card-img-bottom" onload="finishLoadImg(this)" onerror="reLoadImg(this)" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+brd.boFile+'">'
	if(brd.boType == "VIDEO")
		output +=	'<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+brd.boFile+'" controls></video>'
		
	output +=	'</div></div>'
	
	cardTemplate.innerHTML = output;
	return cardTemplate.firstChild;
}

function reLoadImg(obj){
	obj.classList.add("d-none")
	
	let unloadSpinner = obj.parentElement.querySelector(".spinner-border");
	unloadSpinner.classList.remove("d-none")
	
	setTimeout(()=>{
		let src = obj.getAttribute("src");
		obj.setAttribute("src",src);}
	, 1500)
	
}

function finishLoadImg(obj){
	obj.classList.remove("d-none")
	
	let unloadSpinner = obj.parentElement.querySelector(".spinner-border");
	unloadSpinner.classList.add("d-none")
}

function modifyDeleteFile(boNum){
	let option = {
		method : "delete",
		headers : {
			contentType : "application/json"
		}
	}
	
	fetch('boardModify/'+boNum, option)
		.then(res=>res.text())
		.then(d=>{
			if(d == "success"){
				document.getElementById('modiFile'+boNum).remove();
			}
	})
}

//첨부파일 추가
function updateAttach(obj){
	let formData = new FormData();
	let fileField = fileInputBox.querySelector('input[type="file"]');
	let boardId = obj.getAttribute("data-bd-id");
	
	formData.append("boGroupNum", boardId);
	formData.append("boVisiblity", "전체공개");
	formData.append("boWriter", loginId);
	formData.append("boWritersName", "${sessionScope.loginName}");
	formData.append("boFileData", fileField.files[0]);

	fetch('uploadAttachFile', {
	  			method: 'post',
	  			body: formData
				}
			)
			.then(res => res.json())
			.then(data =>{ 
				updateFileLoad(data);
				})
}

/* 친구 추천 부분 시작 */

function memberRecommend(){
	fetch('memberRecommend')
		.then(res=>res.json())
		.then(data=>{
			console.log(data);

			if(data.relationFollow != null){
				if(data.relationFollow.length > 0){
					let followHeader = document.createElement("div");
					followHeader.classList.add("row", "my-1");
					followHeader.innerText="팔로우 한 사람";
					recomendField.append(followHeader);

					let followBody = document.createElement("div");
					followBody.classList.add("row");

					data.relationFollow.forEach(d=>followBody.append(renderRecommendCard(d)));
					recomendField.append(followBody);
				}
			}

			if(data.relationSchool != null){
				if(data.relationSchool.length > 0){
					let followHeader = document.createElement("div");
					followHeader.classList.add("row", "my-1");
					followHeader.innerText="같은 학교 출신";
					recomendField.append(followHeader);

					let followBody = document.createElement("div");
					followBody.classList.add("row");

					data.relationSchool.forEach(d=>followBody.append(renderRecommendCard(d)));
					recomendField.append(followBody);
				}
			}

			if(data.relationCompany != null){
				if(data.relationCompany.length > 0){
					let followHeader = document.createElement("div");
					followHeader.classList.add("row", "my-1");
					followHeader.innerText="같은 직장";
					recomendField.append(followHeader);

					let followBody = document.createElement("div");
					followBody.classList.add("row");

					data.relationCompany.forEach(d=>followBody.append(renderRecommendCard(d)));
					recomendField.append(followBody);
				}
			}

			if(data.relationAddr != null){
				if(data.relationAddr.length > 0){
					let followHeader = document.createElement("div");
					followHeader.classList.add("row", "my-1");
					followHeader.innerText="거주지가 같은 사람";
					recomendField.append(followHeader);

					let followBody = document.createElement("div");
					followBody.classList.add("row");

					data.relationAddr.forEach(d=>followBody.append(renderRecommendCard(d)));
					recomendField.append(followBody);
				}
			}
			
			if(recomendField.innerHTML == ""){
				recomendField.innerHTML ='<h2>추천할 사용자가 없습니다</h2>'
			}
		})

}

function renderRecommendCard(d){
	console.log(d)
	let template = document.createElement("div");
	let output = "";
	output += '<div class="col-4 recommendCard text-center p-3 me-3">'
	output += '<div class="mx-auto"><img width="100px" height="100px" src="/controller/resources/assets/img/profile/'+d.memProfile+'" class="rounded-circle"></div>'
	output += '<div>'+d.memName+'</div>'
	output += '<div><button class="btn btn-primary" data-member-id='+d.memId+' onclick="insertFollow(this)">팔로우</button></div>'
	output += '</div>'
	template.innerHTML = output;
	return template.firstChild;
}
/* 친구 추천 부분 끝 */

function insertFollow(obj){
	let id = obj.getAttribute("data-member-id");
	fetch("follow?sendId=" + loginId + "&receiveId=" + id, {method : "post"})
}

function deleteFollow(obj){
	let id = obj.getAttribute("data-member-id");
	fetch("unfollow?sendId=" + loginId + "&receiveId=" + id, {method : "delete"})
}

</script>
</html>