<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../includes/Links.jsp"%>
<style type="text/css">






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
							<div class="d-flex flex-column mt-5" id="contentPeopleBox"></div>

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
	


window.addEventListener('load', function () {
	//페이지 로드가 끝나면 첫 게시글을 불러옴
	$.ajax({
		type:"get",
		url:"getSearchMember?q="+q,
		dataType:"json",
		success:res=>{
			for(let i in res){
				createContentInCard(res[i])
			}
		}
	})
})






function createContentInCard(dd){
	//게시글 박스 안에 게시글을 넣음
	let renderedCard = renderContentCard(dd);
	contentPeopleBox.appendChild(renderedCard);
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
function renderContentCard(d){
	let contentBoxWidthLength = contentPeopleBox.offsetWidth;
	let cardTemplate = document.createElement("div");
	
	output = "";
	output += '<div class="card mb-3 contentCard divFocusBorder-0" tabindex="-1" onfocus="getNewCard(isLast(this))" >'
	output += 	'<div class="card-header d-flex justify-content-between" style="padding-top:20px;">'
	output += 		'<div class="d-flex"><img class="rounded-circle" src="${pageContext.request.contextPath }/resources/assets/img/profile/'+d.memProfile+'\" width="48px" height="48px">'
	output += 		'<div class="px-3 pt-1"><h5 class="card-title">'+d.memName+'</h5>' //이름
		if(d.memAddr != null){
	output += 			'<h6 class="card-subtitle mb-2 text-muted small">' + d.memAddr + ' 거주</h6>' //지역
		} if (d.memCompany != null){
	output += 			'<h4 class="card-subtitle mb-2 text-muted small">' + d.memCompany + ' 에서 근무</h4>' //회사
		} if (d.memSchool != null){
	output += 			'<h6 class="card-subtitle mb-2 text-muted small">' + d.memSchool + ' </h6>' //출신학교
		}
	output +=		'</div></div>'
	output +=		'<button class="card-menu-btn btn-outline-secondary btn" onclick="location.href=\'memberInformation?memId='+d.memId+'\'"><i class="fas fa-user-friends" aria-hidden="true"></i></button>'
	output += 	'</div>'
	output += '</div>'
	
	cardTemplate.innerHTML = output;
	return cardTemplate.firstChild;
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



function renderSharedCard(d){
	let contentBoxWidthLength = contentPeopleBox.offsetWidth;
	
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
	output += '<p class="card-text"></p>'
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



//게시글의 상, 하를 비교하여 화면의 어떤 위치에 있는 게시글을 골라냄
function isElementInViewport(el){
    let rect = el.getBoundingClientRect();
    return rect.bottom > 0.73*window.innerHeight && rect.top < 0.67*window.innerHeight;
}





	
	

		

		  

</script>
</html>