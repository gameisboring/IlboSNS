<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header id="header" class="header fixed-top " style="background-color: rgb(0 103 254 / 27%);box-shadow: 0rem 1rem 3rem rgb(0 103 254 / 15%);">
	<div class="container-fluid d-flex align-items-center justify-content-between">
		<div class="logo d-flex">
			<a href="main"><img src="${pageContext.request.contextPath }/resources/assets/img/logo/ILBO-logo.png" alt=""></a>
			<form action="searchTop" method="get" onsubmit="return aa()" name="form" id="tag" class="d-flex">
				<input type="text" name="q" value="${q}" id="hash" class="form-control"> <input type="submit" id="sm" value="검색" class="btn btn-primary">
			</form>
		</div>
		<c:if test="${sessionScope.loginProfile != null}">
			<nav class="navbar">
				<ul>
					<li>
						<button class="btn btn-secondary mx-2" id="messengerDropDown" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="far fa-comment-alt" style="margin-top: 5px"></i>
						</button>
						<div class="dropdown-menu" aria-labelledby="messengerDropDown" id="messengerDropDownBox">
							<button id="createChatroomBtn" class="btn btn-light" onclick="chatroomModal()" style="height:2.5rem; text-align:center;">채팅방 만들기<i class="fas fa-plus-circle"></i></button>
						</div>
					</li>
					<li>
						<button class="btn btn-secondary mx-2" id="alarmDropDown" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="far fa-bell" style="margin-top: 5px"></i>
						</button>
						<div class="dropdown-menu" aria-labelledby="alarmDropDown" id="alarmDropDownBox">
						</div>
					</li>
					<li class="dropdown"><div><a href="#"><img src="${pageContext.request.contextPath }/resources/assets/img/profile/${sessionScope.loginProfile}" class="rounded-circle">
						</a></div>
					
						<ul>
							<li><a href="memberInformation">내 정보보기</a></li>
							<li><a href="#"> <span>Deep Drop Down</span>
							</a>
							<li><a href="#">Drop Down 2</a></li>
							<li><a href="#">Drop Down 3</a></li>
							<li><a href="logout">로그아웃</a></li>
						</ul></li>
				</ul>
				<i class="bi bi-list mobile-nav-toggle"></i>
			</nav>

		</c:if>
	</div>
</header>
<script>
var loginId = '${sessionScope.loginId}'
var stompClient;
var boardStorage={
		setItem : (key,value)=> {
			sessionStorage.setItem(key, JSON.stringify(value))
			},
		getItem : (key) => {
				return JSON.parse(sessionStorage.getItem(key));
			}
}

window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	connectStomp();
})
	
function aa() {
	var f = document.form
	if (f.q.value.indexOf('#') == 0) {
		console.log(f.q.value);
		console.log("샵")
		$("#tag").attr("action", "hashTagSelect");
		$("#hash").attr("name", "hashTag");
		return true;
	} else {
		return true;
	}
	return false;
}
		
/* 채팅 관련 기능 */

$("#messengerDropDown").click(function() {
	messengerDropDown.classList.add("btn-secondary");
	messengerDropDown.classList.remove("btn-primary");
	
	getChatRoomList();
})
		
		
function getChatRoomList(){
	
	if(document.getElementById("chatroomListArea") != null)
		document.getElementById("chatroomListArea").remove();
	
	let chatroomListArea = document.createElement("div");
	chatroomListArea.setAttribute("id","chatroomListArea");
	chatroomListArea.setAttribute("class","list-group");
	chatroomListArea.setAttribute("data-aos","fade-bottom");
	chatroomListArea.style.maxHeight="calc(65vh)"
	chatroomListArea.style.overflowY="scroll"
	
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
			$("#messengerDropDownBox").append(chatroomListArea);
		}
	})
	
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
	$('#chatroomCreateModal').modal("show"); //모달 열기
}

let behave = {
		whenCHAT : (data)=>{
			if(data.receiver == chattingCard.getAttribute("data-room-id"))
				makeMessageForm(data);
			else {
				messengerDropDown.classList.add("btn-primary");
				messengerDropDown.classList.remove("btn-secondary");
			}
		},
		whenJOIN : (data)=>{
			messengerDropDown.classList.add("btn-primary");
			messengerDropDown.classList.remove("btn-secondary");
		},
		whenONLINE : (data)=>$(".onlineSign"+data).html("온라인").removeClass("offline").addClass("online"),
		whenOFFLINE : (data)=>$(".onlineSign"+data).html("오프라인").removeClass("online").addClass("offline"),
		whenNOTI : (data)=>receiveNotification(data)
};
	


/* 알림 관련 기능 */

$("#alarmDropDown").click(function() {
		alarmDropDown.classList.add("btn-secondary");
		alarmDropDown.classList.remove("btn-primary");
		
		getNotiList();
	})

function getNotiList(){
	if(document.getElementById("notiArea") != null)
		document.getElementById("notiArea").remove();
	
	let notiArea = document.createElement("div");
	notiArea.setAttribute("id","notiArea");
	
	let renderedNotiList = document.createElement("div");
	renderedNotiList.setAttribute("data-aos","fade-bottom");
	renderedNotiList.classList.add("list-group");
	renderedNotiList.style.maxHeight = "calc(65vh)";
	renderedNotiList.style.overflowY = "auto";
	
	fetch("http://192.168.0.56:22123/user/noti/"+loginId)
		.then(res=>res.json())
		.then(data=>{
			data.forEach(d=>renderedNotiList.prepend(renderNotiList(d)));
			notiArea.append(renderedNotiList);
			$("#alarmDropDownBox").append(notiArea);
		})
}

function renderNotiList(d){
	let notiElement = document.createElement("button");
	notiElement.classList.add("list-group-item","list-group-item-action","flex-column","align-items-start", "notification-item");

	let notiHead = document.createElement("div");
	notiHead.classList.add("d-flex","w-100","justify-content-between");
	notiHead.innerHTML += "<span class='mb-1 pe-3'>"+noticeHeadByType(d)+"</span>";
	notiHead.innerHTML += "<small class='pt-2' style='width:30%; font-size:0.9rem'>"+pastTime(d.time)+"</small>";

	notiElement.append(notiHead);
	/* data.type에 따라 다르게 */
	let notiBody = document.createElement("span");
	notiBody.classList.add("mb-1", "text-secondary");
	notiBody.innerHTML = noticeBodyByType(d);
	
	notiElement.append(notiBody);
	if(d.body != null)
		notiElement.setAttribute("onclick", "notiClick."+d.type+"("+d.body.split(';')[0]+")");

	return notiElement;
}

function noticeHeadByType(data){
	if(data.type == "REPLY") //클릭시 게시글로 이동
		return "<a class='text-primary memberName'>" + data.senderName + "</a> 님이 회원님의 게시글에 댓글을 달았습니다.";
	if(data.type == "FOLLOW")	//밑에 맞팔 버튼 만들기
		return "<a class='text-primary memberName'>" + data.senderName + "</a> 님이 회원님을 팔로우 했습니다.";
	if(data.type == "CALL")	//클릭시 언급한 댓글로 이동
		return "<a class='text-primary memberName'>" + data.senderName + "</a> 님이 댓글에 회원님을 언급했습니다.";
	if(data.type == "LIKE")
		return "<a class='text-primary memberName'>" + data.senderName + "</a> 님이 회원님의 게시글을 좋아합니다."
	if(data.type == "REQUEST")
		return "<a class='text-primary memberName'>" + data.senderName + "</a> 님의 그룹 가입 요청입니다."
	if(data.type == "APPLY")
		return "그룹 가입 요청이 승인되었습니다."
}

let notiClick={
		LIKE : body=>boardView(body),
		FOLLOW : body =>{},
		CALL : body=>boardView(body),
		REPLY : body=>boardView(body),
		REQUEST : body=> {location.href="groupInfo?gpNum="+body},
		APPLY : body=> {location.href="groupInfo?gpNum="+body}
}

function noticeBodyByType(data){
	if(data.type == "REPLY"){ //클릭시 게시글로 이동
		return data.body.split(';')[1];
	}
	if(data.type == "FOLLOW"){	//밑에 맞팔 버튼 만들기
		return "<button class='btn btn-primary w-100 text-center' data-member-id="+data.sender+" onclick='insertFollow(this)' style='height:2.5rem;'>팔로우 하기</button>";
	}
	if(data.type == "CALL"){	//클릭시 언급한 댓글로 이동
		return data.body.split(';')[1];
	}
	return "";
}

function sendNotification(type, receiver, body){
	let msg = {
			type : type.toUpperCase(),
			sender : loginId,
			senderName : '${sessionScope.loginName}',
			receiver : receiver,
			body : body
	};
	
	console.log(msg)
	
	stompClient.send("/send/noti",{},JSON.stringify(msg));
}

function receiveNotification(data){
	let notificationElement = document.getElementById("notiArea");
	
	if(notificationElement != null)
		notificationElement.querySelector(".list-group").prepend(renderNotiList(data));

	alarmDropDown.classList.remove("btn-secondary");
	alarmDropDown.classList.add("btn-primary");
}
</script>
<%@ include file="ChatModal.jsp"%>