/**
 * 
 */

 
function connectStomp() {
	const socket = new SockJS("http://192.168.0.56:22123/stompComnnect");
	const stomp = Stomp.over(socket);

	stomp.connect({}, (frame) => {
		console.log('connected: ' + frame);

		/* 
		접속 알람을 send 
		follow한 사용자 에게 메세지를 보내며 접속알람을 받으면 online표시 
		*/
		
		stomp.send("/send/online/"+loginId, {} , {});

		stomp.subscribe('/topic/chat/' + loginId, (res) => {
			//receive 'CHAT' type data by res

			/* Message Data 
			type      :  ' JOIN, CHAT, REPLY, LIKE, FRIEND ',
			sender   :  ' senderId ' ,
			senderName : 'senderName',
			receiver  :  ' receiverId, chatRoomId ' ,
			body     :  ' content, boardId '
			time      :  '알림, 채팅 발생시간'
		*/
			console.log("get 'CHAT' Message!!");
			let response = JSON.parse(res.body);
			console.log(response);

			behave.whenCHAT(response);
		})
		
		stomp.subscribe('/topic/noti/' + loginId, (res) => {
			//receive 'NOTI' type data by res

			/* Message Data 
			type      :  ' JOIN, CHAT, REPLY, LIKE, FRIEND ',
			sender   :  ' senderId ' ,
			senderName : 'senderName',
			receiver  :  ' receiverId, chatRoomId ' ,
			body     :  ' content, boardId '
			time      :  '알림, 채팅 발생시간'
		*/
			let response = JSON.parse(res.body);
			console.log(response);

			behave.whenNOTI(response);
		})

		stomp.subscribe('/topic/join/' + loginId, (res) => {
			//receive 'CHAT' type data by res

			/* Message Data 
			type      :  ' JOIN, CHAT, REPLY, LIKE, FRIEND ',
			sender   :  ' senderId ' ,
			senderName : 'senderName',
			receiver  :  ' receiverId, chatRoomId ' ,
			body     :  ' content, boardId '
			time      :  '알림, 채팅 발생시간'
		*/
			console.log("get 'JOIN' Message!!");
			let response = JSON.parse(res.body);
			console.log(response);

			behave.whenJOIN(response);
		})
		
		stomp.subscribe('/topic/online/' + loginId, (res) => {
			//receive 'CHAT' type data by res

			/* Message Data 
			type      :  ' JOIN, CHAT, REPLY, LIKE, FRIEND ',
			sender   :  ' senderId ' ,
			senderName : 'senderName',
			receiver  :  ' receiverId, chatRoomId ' ,
			body     :  ' content, boardId '
			time      :  '알림, 채팅 발생시간'
		*/
			console.log("get 'ONLINE' Message!!");
			let response = JSON.parse(res.body);
			console.log(response);

			behave.whenONLINE(response);
		})
		
		stomp.subscribe('/topic/offline/' + loginId, (res) => {
			//receive 'CHAT' type data by res

			/* Message Data 
			type      :  ' JOIN, CHAT, REPLY, LIKE, FRIEND ',
			sender   :  ' senderId ' ,
			senderName : 'senderName',
			receiver  :  ' receiverId, chatRoomId ' ,
			body     :  ' content, boardId '
			time      :  '알림, 채팅 발생시간'
		*/
			console.log("get 'OFFLINE' Message!!");
			let response = JSON.parse(res.body);
			console.log(response);

			behave.whenOFFLINE(response);
		})

	})

	socket.onclose = ()=>{
		console.log('Connection closed');
		stompClient.disconnect();
		setTimeout(function () { 
			socket = connectStomp();
		 }, 1500);
	}

	stompClient = stomp;
	
	window.addEventListener('beforeunload', function() {
        stomp.send("/send/offline/"+loginId,{},{});
      });
}
