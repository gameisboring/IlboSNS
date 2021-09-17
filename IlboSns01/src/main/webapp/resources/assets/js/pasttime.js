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