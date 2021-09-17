<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/Links.jsp"%>
<style type="text/css">



#postDiv{
background-color: rgb(255, 255, 255);margin-top: 0px;padding-top: 40px;padding-left: 20px;padding-right: 20px;padding-bottom: 30px;
border:1px solid rgba(0,0,0,.125);

}
#postDiv a{

   
    margin-left: 294.25;
    margin-top: 20px;
    margin-left: 294.25;
    margin-left: 294.25;
    margin-left: 300px;



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
	
	

		
		
	<div class="row gy-4 d-flex justify-content-center" style="margin-top: 102px;" >

		<div class="col-lg-12">
			<div style="border-bottom:1px solid rgba(0,0,0,.125);margin-bottom: 0px;padding-bottom: 80px;">
			<h2 style="margin-top: 80px;margin-left: 500px;">${q}</h2>
			</div>
		</div>
		
		<div class="col-lg-7" >
			<!-- ======= Values Section ======= -->
			<section id="newsfeed" class="newsfeed">

				<div class="container" data-aos="fade-up">
	


					<div class="row">
						<div class="col-12">
							
							
							<div class="d-flex flex-column mt-5" id="contentPostBox"></div>

						</div>
					</div>
				</div>

			</section>
			<!-- End Values Section -->
		</div>
		<div class="col-lg-0">
		</div>	
	</div>

	<%@ include file="../includes/Footer.jsp"%>
	<%@ include file="../includes/script.jsp"%>
</body>
<script>
		


//넘어온값 인코딩처리해서 아이잭스로 보내기 
var q = '${q}';  
console.log("q == "+q)
  if(q.indexOf('#')==0){
	var q = encodeURIComponent( q );
	console.log("q == "+q)
} 
 


window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	
	
	$.ajax({
		type:"get",
		url:"getSearchHashTag?num=0&q="+q,
		dataType:"json",
		success:res=>{
			if(res==""){
				
				
			}
			

			for(let i in res){
				
				createBoardContentInCard(res[i])
			}
			
			//해시태그 링크걸어주기


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







function createBoardContentInCard(dd){
	
	let renderedCard = renderBoardContentCard(dd);
	contentPostBox.appendChild(renderedCard);
	console.log(renderedCard)
}



function isLast(obj){
	//마지막 게시글인지 확인
	if(contentPeopleBox.lastChild === obj)
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
		o.style.maxHeight = contentPeopleBox.offsetWidth/2 + "px";
		o.parentElement.parentElement.style.maxHeight = "40rem";
		o.parentElement.setAttribute("is-spread","fold");
		
		if(o.parentElement.children[1].classList.contains("fileBox"))
			o.parentElement.children[1].style.maxHeight = contentPeopleBox.offsetWidth + "px";
	}
}

//데이터d 를 받아와 게시글 카드를 그려줌



function renderBoardContentCard(d){
	
	let contentBoxWidthLength = contentPostBox.offsetWidth;
	let cardTemplate = document.createElement("div");
	
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0" tabindex="-1"  >'
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
				grCard += '<img class="card-img-bottom" src="${pageContext.request.contextPath }/resources/assets/img/boardFile/'+r.boFile+'">'
			})
		}
	})
	
	return grCard;
}







//게시글의 상, 하를 비교하여 화면의 어떤 위치에 있는 게시글을 골라냄
function isElementInViewport(el){
    let rect = el.getBoundingClientRect();
    return rect.bottom > 0.73*window.innerHeight && rect.top < 0.67*window.innerHeight;
}






		

		  

</script>
</html>