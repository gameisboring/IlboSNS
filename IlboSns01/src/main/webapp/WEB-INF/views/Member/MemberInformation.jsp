<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/Links.jsp"%>
</head>
<body>
	<%@ include file="../includes/HomeHeader.jsp"%>
	<main id="main">
		<!-- ======= About Section ======= -->
		<section id="about" class="about">
			<div class="justify-content-between" id="memAboutCard">
				<div class="d-flex flex-row">
					<div class="spinner-border d-none mx-auto" id="IsUnload" role="status">
						<span class="sr-only"></span>
					</div>
					<c:if test="${param.memId==null }">
						<input type="file" name="file" class="d-none" id="fileGet" onchange="updateProfile()">
					</c:if>
					<img class="rounded-circle" onload="finishLoadImg()" onerror="reLoadImg()" id='memProfile' src="" alt="Card image cap" <c:if test="${param.memId==null }">onclick="fileGet.click()"</c:if>>
				</div>
				<div class="d-flex flex-column ms-4">
						<h2 class="text-center" id='memName' style="font-weight: bold">이름</h2>
						<div class="d-flex justify-content-evenly text-center mt-3">
							<div class="d-flex flex-column">
								<h3>게시글</h3>
								<h3 id="boardCount"></h3>
							</div>
							<div class="d-flex flex-column mx-4">
								<h3>팔로우</h3>
								<h3 id="followCount"></h3>
							</div>
							<div class="d-flex flex-column">
								<h3>팔로워</h3>
								<h3 id="followerCount"></h3>
							</div>
						</div>
					</div>
				<div class="" style="width: 7rem">
					<c:if test="${param.memId!=null }">
					<button class="btn btn-outline-primary" id="infoFollowBtn">팔로우</button>
					</c:if>
				</div>
			</div>
		</section>
		<!-- End About Section -->
		<div class="row mx-auto w-50">
			<div class="col-5">
				<div class="card" id="memInfoCard">
					<div class="card-header">
						<h2>내 정보</h2>
					</div>
					<div class="card-body">
						<ul id="memInfomation" class="list-group list-group-flush">
							<li class="list-group-item " id="memAddr">
								<h5 class="card-title">거주지</h5>
								<p class="card-text" style="display: inline-block">거주지를 입력해주세요</p> 
								<c:if test="${param.memId==null }">
								<input type="text" class="form-control" style="display: none">
								<button class="btn btn-outline-primary" style="float: right" onclick="updateForm(this.parentElement)">
									<i class="far fa-edit"></i>
								</button>
								<button class="btn btn-outline-danger" style="float: right; display: none" onclick="cancelListener(this.parentElement)">취소</button>
								<button class="btn btn-outline-primary" style="float: right; display: none" onclick="updateListener(this.parentElement)">수정</button>
								</c:if>
							</li>
							<li class="list-group-item" id="memBirth">
								<h5 class="card-title">생일</h5>
								<p class="card-text" style="display: inline-block">생일을 입력해주세요</p> 
								<c:if test="${param.memId==null }">
								<input type="date" class="form-control" style="display: none">
								<button class="btn btn-outline-primary" style="float: right" onclick="updateForm(this.parentElement)">
									<i class="far fa-edit"></i>
								</button>
								<button class="btn btn-outline-danger" style="float: right; display: none" onclick="cancelListener(this.parentElement)">취소</button>
								<button class="btn btn-outline-primary" style="float: right; display: none" onclick="updateListener(this.parentElement)">수정</button>
								</c:if>
							</li>
							<li class="list-group-item" id="memTel">
								<h5 class="card-title">전회번호</h5>
								<p class="card-text" style="display: inline-block">전화번호를 입력해주세요</p> 
								<c:if test="${param.memId==null }">
								<input type="text" class="form-control" style="display: none">
								<button class="btn btn-outline-primary" style="float: right" onclick="updateForm(this.parentElement)">
									<i class="far fa-edit"></i>
								</button>
								<button class="btn btn-outline-danger" style="float: right; display: none" onclick="cancelListener(this.parentElement)">취소</button>
								<button class="btn btn-outline-primary" style="float: right; display: none" onclick="updateListener(this.parentElement)">수정</button>
								</c:if>
							</li>
							<li class="list-group-item" id="memCompany">
								<h5 class="card-title">회사</h5>
								<p class="card-text" style="display: inline-block">회사를 입력해주세요</p> 
								<c:if test="${param.memId==null }">
								<input type="text" class="form-control" style="display: none">
								<button class="btn btn-outline-primary" style="float: right" onclick="updateForm(this.parentElement)">
									<i class="far fa-edit"></i>
								</button>
								<button class="btn btn-outline-danger" style="float: right; display: none" onclick="cancelListener(this.parentElement)">취소</button>
								<button class="btn btn-outline-primary" style="float: right; display: none" onclick="updateListener(this.parentElement)">수정</button>
								</c:if>
							</li>
							<li class="list-group-item" id="memSchool">
								<h5 class="card-title">출신학교</h5>
								<p class="card-text" style="display: inline-block">학교를 입력해주세요</p> 
								<c:if test="${param.memId==null }">
								<input type="text" class="form-control" style="display: none">
								<button class="btn btn-outline-primary" style="float: right" onclick="updateForm(this.parentElement)">
									<i class="far fa-edit"></i>
								</button>
								<button class="btn btn-outline-danger" style="float: right; display: none" onclick="cancelListener(this.parentElement)">취소</button>
								<button class="btn btn-outline-primary" style="float: right; display: none" onclick="updateListener(this.parentElement)">수정</button>
								</c:if>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-lg-7">
				<!-- ======= Values Section ======= -->
				<section id="newsfeed" class="newsfeed" style="padding: 0px">
					<div class="container" data-aos="fade-up">
						<div class="d-flex flex-column" id="contentBox"></div>
						<div class="text-center">
							<div class="spinner-border mx-auto my-5" role="status">
								<span class="sr-only">Loading...</span>
							</div>
						</div>
					</div>
				</section>
				<!-- End Values Section -->
			</div>
		</div>
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-3"></div>
		</div>
	</main>
	<!-- 필드 추가시 CARD에 list-group-item 오브젝트 복사하여 추가 -->
	<!-- 추가된 필드에 li 태그에 id를 'Dto의 field 이름' 으로 줌 -->
	<!-- script의 Render 함수를 이용하여 받아온 Value대입 -->
	<!-- End #main -->
	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="container">
			<div class="copyright">
				&copy; Copyright <strong><span>ILBO</span></strong>. All Rights Reserved
			</div>
			<div class="credits">Designed by ABCD</div>
		</div>
	</footer>
	<!-- End Footer -->
	<%@ include file="../includes/script.jsp"%>
</body>
<script>
	window.addEventListener('load', function () {
		
	getmemInfomation()
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	let id;
	
	if(${param.memId!=null})
		id = '${param.memId}';
	else
		id = loginId;
	
	$.ajax({
		type:"get",
		url:"getBoardById?num=0&id="+id,
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
				console.log("이문서의내용 : "+content);
				
			
				 var splitedArray = content.split(' ');
				console.log(splitedArray);
				var linkedContent = '';
				for(var hashTag in splitedArray)
				{
				  hashTag = splitedArray[hashTag];
				  console.log("hashTag = "+hashTag);
				   if(hashTag.indexOf('#') == 0)
				   {
					  
				      var word = hashTag.replaceAll("#","%23"); //#은 컨트롤러로 넘길때 나오지않아서 변환 %23 = # 
					   console.log("hashTag2 = "+hashTag);
					   hashTag = '<a href=\'hashTagSelect?hashTag='+word+'\'>'+hashTag+'</a>';
				   }
				   linkedContent += hashTag+' ';
				   console.log("hashTag3 = "+hashTag);
				}
				document.getElementsByClassName('contentElement')[i].innerHTML = linkedContent;  
			}
		}
	})
	getCount();
	})
	
	/* $("#memInfoCard").mouseenter(function(){
		$("#memInfoUpdateBtn").addClass("d-block")
		$("#memInfoUpdateBtn").removeClass("d-none")
	})
	$("#memInfoCard").mouseleave(function(){
		$("#memInfoUpdateBtn").addClass("d-none")
		$("#memInfoUpdateBtn").removeClass("d-block")
	}) */
	
	function updateForm(e){
		let child = e.children;	
		
 		console.log(child)
		
		child[1].style.display = "none";
		child[2].style.display = "inline-block";
		child[3].style.display = "none";
		child[4].style.display = "block";
		child[5].style.display = "block";
	}
	
	async function updateListener(e){
		let child = e.children;
		
		console.log(child)
		console.log(child[2].value)
		
		
		await updateElement(e.id, child[2].value);
		child[1].style.display = "inline-block";
		child[2].style.display = "none";
		child[3].style.display = "block";
		child[4].style.display = "none";
		child[5].style.display = "none";
	}
	
	function cancelListener(e){
		let child = e.children;
		
		child[1].style.display = "inline-block";
		child[2].style.display = "none";
		child[3].style.display = "block";
		child[4].style.display = "none";
		child[5].style.display = "none";
	}
	
	function updateElement(fieldId, value){
		let id = ${sessionScope.loginId}
		$.ajax({type:"post",
				url:"updateMember",
				data:{memId:id,
						[fieldId] : value},
				success:res=>getmemInfomation()
				})
	}
	
	function setmemInfomation(){
		let memid = inputId.value;
		console.log(memid)
		
		$.ajax({type:"post",
				url:"login",
				data:{"memId":memid},
				success:res=>getmemInfomation()})
	}
	
function getmemInfomation(){
		
		if(${param.memId==null}){
			$.ajax({ type : "get",
				 	url : "myinfo",
				 	dataType:"json",
				 	success:d=>render(d) })
				 	
		document.querySelectorAll(".list-group-item").forEach(e=>cancelListener(e));
		}
		else
			$.ajax({ type : "get",
			 	url : "memInfo?memId=${param.memId}",
			 	dataType:"json",
			 	success:d=>{
			 		render(d);
			 		fetch('isFollow?sendId='+loginId+'&receiveId=${param.memId}')
			 			.then(res=>res.text())
			 			.then(bool=>{
			 				infoFollowBtn.setAttribute("data-member-id","${param.memId}");
			 				
			 				if(bool == "true"){
			 					infoFollowBtn.innerText="팔로잉";
			 					infoFollowBtn.classList.add("btn-outline-primary");
			 					infoFollowBtn.classList.remove("btn-primary");
			 					infoFollowBtn.setAttribute("onclick","deleteFollow(this)");
			 				}else {
			 					infoFollowBtn.innerText="팔로우";
			 					infoFollowBtn.classList.remove("btn-outline-primary");
			 					infoFollowBtn.classList.add("btn-primary");
			 					infoFollowBtn.setAttribute("onclick","insertFollow(this)");
			 				}
			 			})
			 	}
			 	})
		
	}
	
	function render(data){
		
		if(data.memName != null)
			memName.innerText = data.memName;
		
		if(data.memAddr != null)
			memAddr.children[1].innerText = data.memAddr;
		
		if(data.memBirth != null)
			memBirth.children[1].innerText = data.memBirth.split(" ")[0];
		
		if(data.memTel != null)
			memTel.children[1].innerText = data.memTel;
		
		if(data.memCompany != null)
			memCompany.children[1].innerText = data.memCompany;
		
		if(data.memSchool != null)
			memSchool.children[1].innerText = data.memSchool;
		
		if(data.memProfile != null)
			memProfile.setAttribute("src","${pageContext.request.contextPath }/resources/assets/img/profile/" + data.memProfile);
	}
	
	function updateProfile(){
		console.log(fileGet.value)
		console.log($('#fileGet')[0])
		console.log($('#fileGet')[0].files[0])
		
		let formData = new FormData();
		formData.append('file', $('#fileGet')[0].files[0]);
		
		let data = {"memFile":formData}
		
		console.log(data);
		
		$.ajax({
			 type: "post",
		     enctype: 'multipart/form-data',
		     url: "updateProfile",
		     data: formData,
		     processData: false,
		     contentType: false,
		     success:res=>getmemInfomation()
		})
	}
	
	function reLoadImg(){
		memProfile.classList.add("d-none")
		IsUnload.classList.remove("d-none")
		setTimeout(()=>{
			let src = memProfile.getAttribute("src");
			memProfile.setAttribute("src",src);}
		, 1500)
		
	}
	
	function finishLoadImg(){
		memProfile.classList.remove("d-none")
		IsUnload.classList.add("d-none")
	}
	
	function createContentInCard(dd){
		//게시글 박스 안에 게시글을 넣음
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
				url:"getBoardById?num=" + contentBox.children.length,
				dataType:"json",
				success:res=>{
					for(let i in res){
						createContentInCard(res[i])
					}
				}
			})
		}
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
		
		let contentBoxWidthLength = contentBox.offsetWidth;
		let cardTemplate = document.createElement("div");
		output = "";
		output += '<div class="card mb-3 contentCard divFocusBorder-0" id="board'+d.boNum+'" data-id="'+d.boNum+'" tabindex="-1" onfocus="getNewCard(isLast(this))">'
		output += 	'<div class="card-header d-flex justify-content-between">'
		output += 		'<div class="d-flex">'
		output += 			'<img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px" style="object-fit: cover">'
			output += 		'<div class="px-3 pt-1">'
			output += 			'<h5 class="card-title">'+d.memName+'</h5>'
			output += 			'<h6 class="card-subtitle mb-2 text-muted small">' + pastTime(d.boDate) + '</h6>'
		output +=		'</div></div>'
		output +=		'<div class="dropdown" style="z-index:5">'
			output +=		'<button class="card-menu-btn btn-outline-secondary btn"  id="boardDropDown'+d.boNum+'" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
			output +=		'<div class="dropdown-menu" aria-labelledby="boardDropDown'+d.boNum+'">'
		if(d.memId == loginId){
						output +='<a class="dropdown-item" href="#">수정</a>'
						output +='<a class="dropdown-item" onclick="boardDelete(board'+d.boNum+')">삭제</a>'
		}
						output +='<a class="dropdown-item" onclick="boardView(board'+d.boNum+')">상세보기</a></div>'
		output +=		'</div>'
		output += 	'</div>'
		output += '<div onclick="spreadText(this.firstChild)" is-spread="fold" style="overflow:hidden"><div class="card-body" data-type="'+d.boType+'" style="max-height:'+(contentBoxWidthLength/3)+'px">'
		output += '<p class="card-text text contentElement">'+(d.boContent == null ? "" : d.boContent)+'</p>'
		output += '</div>'
			if(d.boFile != null){
				if(d.boType == "PICTURE"){
					output += '<div class="fileBox" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
					output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
					output += '</div>'
				} else if(d.boType == "SHARE"){
					output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
					output += shareCard(d.boFile);
					output += '</div>'
				} else if(d.boType == "VIDEO"){
					output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
					output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+d.boFile+'" controls></video>'
					output += '</div>'
				}		
			}
			if(d.boType == "MULTI"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
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
				output += '<div class="d-flex"><img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px" style="object-fit: cover">'
					output += '<div class="px-3 pt-1"><h5 class="card-title">'+d.memName+'</h5>'
						output += '<h6 class="card-subtitle mb-2 text-muted small">' + pastTime(d.boDate) + '</h6>'
					output += '</div></div>'
				output += '<button class="card-menu-btn btn-outline-secondary btn"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
				output += '</div>'
			output += '<div><div class="card-body ">'
		output += '<p class="card-text">'+d.boContent+'</p>'
		output += '</div>'
			if(d.boFile != null){
				if(d.boType == "PICTURE"){
					output += '<div class="fileBox" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
					output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
					output += '</div>'
				} else if(d.boType == "VIDEO"){
					output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
					output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/video/'+d.boFile+'" controls></video>'
					output += '</div>'
				}
			}
			if(d.boType == "MULTI"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
				output += multiCard(d.boNum);
				output += '</div>'
			}
		output += '</div></div>'

		return output;
	}

	function pastTime(date){
		if(date == null)
			return "삭제된 게시글입니다."
		
		let now = (new Date()).getTime();
		let bTime = (new Date(date)).getTime();
		
		let diff = Math.ceil((now - bTime)/1000)
		
		let Time = date.substring(5,16)
		if(diff < 60){
			Time = "방금전"
		} else if(diff < 60*60){
			Time = Math.floor(diff/(60)) + "분 전"
		} else if(diff < 60*60*24){
			Time = Math.floor(diff/(60*60)) + "시간 전"
		} else if(diff < 60*60*24*7){
			Time = Math.floor(diff/(60*60*24)) + "일 전"
		} else if(diff < 60*60*24*7*4){
			Time = Math.floor(diff/(60*60*24*7)) + "주 전"
		} else if(diff < 60*60*24*30*6){
			Time = Math.floor(diff/(60*60*24*30)) + "달 전"
		}
		
		return Time;
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
			console.log("files = "+files)
			var text = $("#text").val();
			if(text == "" ||text ==null){
				console.log("비활성화");
				$("#writeBtn").attr('disabled', 'disabled');
				$("#text").focus(); 
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

					function getReplyByData(data){
						
						// 댓글 관련 오브젝트를 담는 div 객체 생성
						var replyArea = document.createElement("div");
						
						// 댓글div에 속성 부여
						replyArea.classList.add("collapse");
						replyArea.classList.add("replyArea");
						replyArea.setAttribute("data-bs-toggle","collapse");
						replyArea.setAttribute("id","replyArea"+data.boNum);
						
						// 댓글이 표시될 ul 객체 생성 
						let newUl = document.createElement("ul");
						
						// ul객체에 댓글입력칸(inputArea) 우선 저장 
						newUl.innerHTML = inputReply(data.boNum);
						
						// ul객체에 접었다폈다 위한 클래스 설정
						newUl.setAttribute('class','list-group');
						newUl.setAttribute('class','list-group-flush');

						let dataReply = data.reply;
						// 조회된 댓글 목록 순서대로 ul객체에 순차저장
						$.each(dataReply, function(i){
							newUl = replyRender(dataReply[i],newUl);
						});
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
							marginForLevel += 50;
						}
						console.log("replyRender | res");
						console.log(res);
						// 댓글 표시
						output += "<li class='list-group-item'>"
							output += "<div class='d-flex' style='margin : 0.5rem 0 0.5rem "+marginForLevel+"px'>"
								output += '<img class="rounded-circle mx-3" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+res.memProfile+'\">'
								output += '<div class="w-100 d-flex flex-column">'
									output += '<div class="card bg-light" onclick="inputReReply(this,\''+res.memName+'\','+res.reBoNum+','+res.reGroup+','+res.reWriter+','+res.reSeq+')">'
										output += '<h6 >'+res.memName+'</h6>'
										output += '<h6 class="text-muted small">' + pastTime(res.reDate) + '</h6>'
										if(res.reTagName!=null){
											output += '<div class="d-flex"><span class="text-primary me-2">'+res.reTagName+'</span><span>'+res.reContent+'</span></div>'
										}else{
											output += '<span>'+res.reContent+'</span>'
										}
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
	
	/* 팔로우 관련 기능 */
	function getCount(){
		if(${param.memId!=null})
			id = '${param.memId}';
		else
			id = loginId;
		
		//게시글 수 받아오기
		var getBoardCountAjax = $.ajax({url:"getBoardCount",data:{"memId" : id},dataType:"json"});
		//팔로우 목록 받아오기
		var getFollowsAjax = $.ajax({url:"getFollows", data:{"memId" : id }, dataType:"json"});
		//팔로워 목록 받아오기
		var getFollowersAjax = $.ajax({url:"getFollowers", data:{"memId" : id }, dataType:"json"});
		
		$.when(getBoardCountAjax,getFollowsAjax,getFollowersAjax).done(function(boardCount,followList,followerList){
			var followCount = followList[0].length;
			var followerCount = followerList[0].length;
			
			$("#boardCount").html(boardCount[0]+" 개");
			$("#followCount").html(followCount+" 명");
			$("#followerCount").html(followerCount+" 명");
		})
		
	}
	
	/* 좋아요 관련 기능  */

	function checkLike(memId,boNum,obj){
		  console.log("요청");
		  console.log("memId : " + memId + "  "+ "boNum : " + boNum);
		  
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
		console.log("하트변환 요청!");
		console.log(memId +"   "+ boNum);
		
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
		error : function(){
			
		}
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