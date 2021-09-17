<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../includes/Links.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../includes/HomeHeader.jsp"%>
	<div class="row gy-4 justify-content-center" style="margin-top: 102px; max-height : 9vh;">
		<div class="col-lg-2 d-flex justify-content-end">
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
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/business-icon.png" class="icon">비즈니스
					</button>
					<button class="btn btn-outline-primary btn-lg mt-4 ">
						<img src="${pageContext.request.contextPath }/resources/assets/img/logo/cs-icon.png" class="icon">고객센터
					</button>
				</div>
			</section>
		</div>
		<div class="col-lg-5"  >
			<!-- ======= Values Section ======= -->
			<section class="newsfeed" id="followListSection" >
				<div class="container" data-aos="fade-down" style="overflow-y: auto">
				</div>
			</section>
			<!-- End Values Section -->
		</div>
		<div class="col-lg-5"  >
			<section  class="newsfeed" id="followerListSection">
				<div class="container" data-aos="fade-down" style="overflow-y: auto">
				</div>
			</section>
		</div>
	</div>
	<%@ include file="../includes/Footer.jsp"%>
	<%@ include file="../includes/script.jsp"%>
</body>
<script>
	$(document).ready(function(){
		getFollowers();
		getFollows();
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

			for(var i in res[0]){
				let renderedFollowList = renderFollowList(res[0][i],res2[0][i],"follow");
				followArea.appendChild(renderedFollowList);
			}
		$("#followListSection").children().first().append(followArea);
	});
}

function getFollowers(){
	
	//팔로워 목록 받아오기
	var getFollowersAjax = $.ajax({url:"getFollowers", data:{"memId" : loginId }, dataType:"json"});
	//팔로워 온오프라인 정보 받아오기
	var onlineCheckAjax = $.ajax({url:"http://192.168.0.56:22123/user/follower/"+loginId, dataType:"json"});
	
	$.when(getFollowersAjax, onlineCheckAjax).done(function(res, res2){
		
		let followerArea = document.createElement("div");
			followerArea.setAttribute("id","followerArea");
			followerArea.setAttribute("data-aos","fade-left");
			followerArea.setAttribute("class","accordion");
			followerArea.setAttribute("overflow-y","auto");
			followerArea.innerHTML = "<h2 class='text-primary'>팔로워 목록</h2>";

			for(var i in res[0]){
				let renderedFollowerList = renderFollowList(res[0][i],res2[0][i],"follower");
				followerArea.appendChild(renderedFollowerList);
			}
		$("#followerListSection").children().first().append(followerArea);
	});
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
</script>
</html>