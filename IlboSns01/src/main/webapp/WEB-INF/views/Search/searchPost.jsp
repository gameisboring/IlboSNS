<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/Links.jsp"%>
<style type="text/css">
textarea:focus {
    outline: none;
}
select,option{
font-size:13px;

color:gray;
font-family: "Font Awesome 5 Free";

font-weight:700;

}
select{
-webkit-appearance:none;
-moz-appearance:none;
border:none;
border-radius:0;
appearance:none;
background:url(../) no-repeat 80% 50%;
}
#variousFunctions{
	border:0.1px gray solid;
	border-radius:10px 10px 10px 10px;
}

#upload:hover {
background-color: rgb(212, 211, 211);
}

#multiple-container {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
}
.image {
    display: block;
    width: 100%;
}
.image-label {
    position: relative;
    bottom: 22px;
    left: 5px;
    color: white;
    text-shadow: 2px 2px 2px black;
}

</style>
</head>
<body>

	<%@ include file="../includes/HomeHeader.jsp"%>
	
	

		
		
	<div class="row gy-4 d-flex justify-content-center" style="margin-top: 102px">

		<div class="col-lg-3">
			<nav id="sidebar">
				<div class="p-4">
					<ul class="list-unstyled components mb-5">
						<li class="active"><a href="searchTop?q=${q}">
							<span class="fa fa-home mr-3"></span> 모두</a>
						</li>
						<li><a href="searchPeople?q=${q}" >
							<span class="fa fa-user mr-3"></span> 사람</a>
						</li>
				
				<li><a href="searchPosts?q=${q}"><span class="fa fa-sticky-note mr-3"></span>
						게시글</a></li>
				<li><a href="searchPhotos?q=${q}"><span class="fas fa-images mr-3"></span>
						사진</a></li>
				<li><a href="searchGroup?q=${q}"><span class="fas fa-users mr-3"></span>
						그룹</a></li>
				<li><a href="#"><span class="fa fa-paper-plane mr-3"></span>
						Contacts</a></li>
			</ul>
		</div>
	</nav>
		</div>
		
		<div class="col-lg-5">
			<!-- ======= Values Section ======= -->
			<section id="newsfeed" class="newsfeed">

				<div class="container" data-aos="fade-up">
				
			
			
			
			
			
					
				

					<div class="row">
						<div class="col-12">
						<div class="d-flex flex-column mt-5" id="contentPostBox">
								
						</div>
						
						</div>
					</div>
				</div>

			</section>
			<!-- End Values Section -->
		</div>
		<div class="col-lg-4">
		</div>	
	</div>

	<%@ include file="../includes/Footer.jsp"%>
	<%@ include file="../includes/script.jsp"%>
</body>
<script>



	
var q = '${q}';
console.log(q)

window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	
	
	console.log(typeof q);
	
		
	$.ajax({
		type:"get",
		url:"getSearchBoard?num=0&q="+q,
		dataType:"json",
		success:res=>{
			for(let i in res){
				console.log(res[i]);
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
})






function createContentInCard(dd){
	//게시글 박스 안에 게시글을 넣음
	console.log(contentPostBox);
	let renderedCard = renderContentCard(dd);
	contentPostBox.appendChild(renderedCard);
}



function isLast(obj){
	//마지막 게시글인지 확인
	if(contentPostBox.lastChild === obj)
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
			url:"#?num=" + contentPostBox.children.length,
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
		o.style.maxHeight = contentPostBox.offsetWidth/2 + "px";
		o.parentElement.parentElement.style.maxHeight = "40rem";
		o.parentElement.setAttribute("is-spread","fold");
		
		if(o.parentElement.children[1].classList.contains("fileBox"))
			o.parentElement.children[1].style.maxHeight = contentPostBox.offsetWidth + "px";
	}
}

//데이터d 를 받아와 게시글 카드를 그려줌
function renderContentCard(d){
	let contentBoxWidthLength = contentPostBox.offsetWidth;
	let cardTemplate = document.createElement("div");
	
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0" tabindex="-1" onfocus="getNewCard(isLast(this))" >'
	output += 	'<div class="card-header d-flex justify-content-between">'
	output += 		'<div class="d-flex"><img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px">'
	output += 		'<div class="px-3 pt-1"><h5 class="card-title">'+d.memName+'</h5>'
	output += 			'<h6 class="card-subtitle mb-2 text-muted small">' + pastTime(d.boDate) + '</h6>'
	output +=		'</div></div>'
	output +=		'<button class="card-menu-btn btn-outline-secondary btn"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
	output += 	'</div>'
	output += '<div onclick="spreadText(this.firstChild)" is-spread="fold" style="overflow:hidden"><div class="card-body" style="max-height:'+(contentBoxWidthLength/3)+'px">'
	output += '<p class="card-text text contentElement">'+d.boContent+'</p>'
	output += '</div>'
		if(d.boFile != null){
			if(d.boType == "NORMAL"){
				output += '<div class="fileBox" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
				output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
				output += '</div>'
			} else if(d.boType == "SHARE"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
				output += shareCard(d.boFile);
				output += '</div>'
			} else if(d.boType == "VIDEO"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
				output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/'+d.boFile+'" controls></video>'
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
			output += '<div class="p-2 w-33 btn btn-outline-secondary border-0"><i class="far fa-heart me-1"></i>좋아요</div>'
			output += '<div onclick = "getReply('+d.boNum+',this)" class="p-2 w-33 btn btn-outline-secondary border-0"><i class="far fa-comment-alt me-1"></i>댓글달기</div>'
			output += '<div onclick = "shareBoard('+ d.boNum +')" class="p-2 w-33 btn btn-outline-secondary border-0"><i class="far fa-share-square me-1"></i>공유하기</div>'
		output += '</div>'
	output += '</div>'
	output += '<div class="replyArea"></div>'
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
	console.log("boNum == "+boNum)
	console.log("multi load")
	
	$.ajax({
		type:"get",
		url:"getGroupByBoGroupNum?boGroupNum=" + boNum,
		dataType:"json",
		async : false,
		success: res=>{
			res.forEach(r=>{
				grCard += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+r.boFile+'">'
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
	let contentBoxWidthLength = contentPostBox.offsetWidth;
	
	output = "";
	output += '<div class="card mb-3 divFocusBorder-0" tabindex="-1">'
		output += '<div class="card-header d-flex justify-content-between">'
			output += '<div class="d-flex"><img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px">'
				output += '<div class="px-3 pt-1"><h5 class="card-title">'+d.memName+'</h5>'
					output += '<h6 class="card-subtitle mb-2 text-muted small">' + pastTime(d.boDate) + '</h6>'
				output += '</div></div>'
			output += '<button class="card-menu-btn btn-outline-secondary btn"><i class="fas fa-ellipsis-h" aria-hidden="true"></i></button>'
			output += '</div>'
		output += '<div><div class="card-body ">'
	output += '<p class="card-text">'+d.boContent+'</p>'
	output += '</div>'
		if(d.boFile != null){
			if(d.boType == "NORMAL"){
				output += '<div class="fileBox" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
				output += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+d.boFile+'">'
				output += '</div>'
			} else if(d.boType == "VIDEO"){
				output += '<div class="fileBox p-2" style="overflow:hidden; max-height:'+contentBoxWidthLength+'px">'
				output += '<video style="background-color:black;" width="100%" height="350px" src="${pageContext.request.contextPath }/resources/assets/'+d.boFile+'" controls></video>'
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

function boardDelete(bnum){
		console.log("bnum : "+ bnum);
		location.href="boardDelete?bnum="+bnum
	}
	
	$('.close').click(function() {
		$('#exampleModalCenter').modal("hide"); //모달 닫기 
		$('#shareModalCenter').modal("hide"); //공유 모달 닫기
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
		

		  
function getReply(boardNum,e){
	console.log("getReply : boardNum = "+boardNum+" "+e);
	$(e).parents('div.replyArea').toggle();
	var output = "";
	output += '<div class="replyArea">'
	output += '<p>안녕하세요'+ boardNum +'</p>'
	output += '</div>';
	console.log(output);
	$(e).parents('div.card-footer').after(output);
	
}
</script>
</html>