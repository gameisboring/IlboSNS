<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 채팅 시작-->
	<div id="chattingCard" class="card chat-popup d-none">
		<div class="messaging">
			<div class="card-header d-flex flex-row px-0 py-1">
				<div class="dropstart" style="z-index: 5">
					<button class="card-menu-btn btn-outline-secondary btn" style="border: 0px; radius: 50%" id="chatDropDown" data-bs-toggle="dropdown" aria-expanded="false">
						<i class="fas fa-bars"></i>
					</button>
					<div class="dropdown-menu" aria-labelledby="boardDropDown">
						<a class="dropdown-item" onclick="showInviteMenu()">초대하기</a>
						<a class="dropdown-item" onclick="chatroomJoinerList()">채팅방 인원</a>
						<a class="dropdown-item" onclick="outChatroom()">채팅방 나가기</a>
					</div>
				</div>
				<span id="chatroomName" class="pt-1">채팅방 이름</span>
				<div class="ms-auto me-2 pt-1">
					<button class="btn btn-outline-secondary btn-sm border-0" onclick="closeChatroom()">X</button>
				</div>
			</div>
			<div class="inbox_msg">
				<input type="hidden" id="roomSelector" value="">
				<div id="chatBox" class="msg_history"></div>
			</div>
			<div class="type_msg px-2">
				<div class="input_msg_write">
					<span class="d-none" id="sender">${sessionScope.loginId};${sessionScope.loginName}</span>
					<input type="text" id="inputMessage" class="write_msg" placeholder="메세지를 입력하세요" onkeydown="if(event.key === 'Enter') sendChat()" />
					<button class="msg_send_btn my-1" type="button" onclick="sendChat()">
						<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
					</button>
				</div>
			</div>
			<!-- <span class="time_date"> 11:01 AM    |    Today</span> -->
		</div>
	</div>
	<!-- 채팅 끝-->
	<!-- 초대 메뉴 시작-->
	<div id="inviteMenu" class="card inviteList d-none">
		<div class="card-header d-flex flex-row px-0 py-0">
			<input type="text" class="form-control" placeholder="검색" onkeyup="searchListMember(this.value)">
			<button class="btn btn-outline-secondary border-0 btn-sm" onclick="inviteMenu.classList.add('d-none')">X</button>
		</div>
		<div class="d-flex flex-column" id="inviteMemberList">
			<div class="p-2 d-flex flex-row">
				<img src="${pageContext.request.contextPath }/resources/assets/img/profile/default.jpg" width="45px"> <span class="mx-auto pt-2">member이름</span>
				<button class="btn btn-outline-primary">초대</button>
			</div>
		</div>
	</div>
	<!-- 초대 메뉴 끝-->
	<!-- 채팅 방 생성 모달 -->
	<div class="modal fade" id="chatroomCreateModal" tabindex="-1" role="dialog" aria-labelledby="chatroomCreateModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="chatroomCreateModalLabel">채팅방 만들기</h4>
					<button type="button" class="close btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>
				</div>
				<form>
					<div class="modal-body">
						<h4>채팅방 이름</h4>
						<input type="text" id="inputChatroomName" maxlength=10 class="form-control" placeholder="채팅방 이름 입력">
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary" onclick="createChatting()">채팅방 만들기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
	$( '#chattingCard' ).draggable();
	
	function closeChatroom(){
		chattingCard.classList.add('d-none');
		inviteMenu.classList.add('d-none');
		chattingCard.setAttribute("data-room-id", "");
	}
	
	function showInviteMenu(){
		inviteMenu.classList.remove("d-none");
		inviteMenu.style.top = chattingCard.offsetTop + "px";
		inviteMenu.style.left = (chattingCard.offsetLeft-300) + "px";
		
		fetch('getFollowsWithoutJoiner?senderId='+loginId+ '&roomId=' + roomSelector.value)
			.then(res=>res.json())
			.then(data=>{
				renderInviteList(data);
			})
	}
	
	$('.close').click(function() {
		$('#chatroomCreateModal').modal("hide"); // 채팅방생성 모달 닫기
	});
	
	/* 채팅 시작 */

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
			output += '<div class="received_msg" onclick="showDate(this)">'
				output += '<span>'+msg.senderName+'</span>'
				output += '<div class="received_withd_msg">'
					output += '<p>'+msg.body+'</p>'
					output += '<span class="time_date mt-0 d-none">'+msg.time.substring(2,16).replaceAll("-","/")+'</span>'
				output += '</div>'
			output += '</div>'
		output += '</div>'
		return output;
	}

	function renderSendedMsg(msg){
		let output = '';
		output += '<div class="outgoing_msg" onclick="showDate(this)">'
			output += '<div class="sent_msg">'
			output += '<p>'+msg.body+'</p>'
			output += '<span class="time_date mt-0 d-none">'+msg.time.substring(2,16).replaceAll("-","/")+'</span>'
		output += '</div></div>'
		return output;
	}
	
	function showDate(obj){
		let timeSpan = obj.querySelector(".time_date");
		if(timeSpan.classList.contains("d-none"))
			timeSpan.classList.remove("d-none");
		else
			timeSpan.classList.add("d-none");
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

	function inviteChatroom(memId){
		if(roomSelector.value == null)
			return;
		
		let msg = {
				type : "JOIN",
				sender : loginId,
				receiver : memId,
				body : roomSelector.value + ";" + chatroomName.innerText
		};
		
		stompClient.send("/send/join",{},JSON.stringify(msg));
	}

	function renderInviteList(data){
		inviteMemberList.innerHTML = "";
		data.forEach(d=>{
				inviteMemberList.appendChild(renderInviteItem(d))
			})
	}

	function renderInviteItem(data){
		let template = document.createElement("div");
		output = "";
		
		output += '<div class="p-2 d-flex flex-row" data-memName="'+data.memName+'">'
		output += '<img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+data.memProfile+'" width="45px" height="45px">'
		output += '<span class="mx-auto pt-2">'+data.memName+'</span>'
		output += '<button onclick="this.setAttribute(\'disabled\',\'disabled\');inviteChatroom('+data.memId+')" class="btn btn-outline-primary">초대</button>'
		output += '</div>'

		template.innerHTML = output;
		return template.firstChild;
	}

	function chatroomJoinerList(){
		inviteMenu.classList.remove("d-none");
		inviteMenu.style.top = chattingCard.offsetTop + "px";
		inviteMenu.style.left = (chattingCard.offsetLeft-300) + "px";
		
		fetch('chatroomMember/'+roomSelector.value)
			.then(res=>res.json())
			.then(data=>{
				renderChatroomMemberList(data);
			})
	}

	function renderChatroomMemberList(data){
		inviteMemberList.innerHTML = "";
		data.forEach(d=>inviteMemberList.appendChild(renderChatroomMemberItem(d)))
	}

	function renderChatroomMemberItem(data){
		let template = document.createElement("div");
		output = "";
		
		output += '<div class="p-2 d-flex flex-row" data-memName="'+data.memName+'">'
		output += '<img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+data.memProfile+'" width="45px" height="45px">'
		output += '<span class="mx-auto pt-2">'+data.memName+'</span>'
		output += '</div>'

		template.innerHTML = output;
		return template.firstChild;
	}

	function outChatroom(){
		let roomId = roomSelector.value;
		let msg = {
				type : "OUT",
				sender : loginId,
				receiver : roomId
		}
		
		stompClient.send("/send/out", {} , JSON.stringify(msg));
		
		chattingCard.classList.add("d-none");
		roomSelector.value = "";
		chatroomName.innerText = "";
		
		chatroomListArea.querySelector("div[data-roomId = '" + roomId + "']").remove();
	}

	function searchListMember(searchValue){
		let members = inviteMemberList.childNodes
		
		members.forEach(member=>{
			let name = member.getAttribute("data-memname");
			if(!name.includes(searchValue))
				member.classList.add("d-none");
			else
				member.classList.remove("d-none");
		})
	}
	</script>