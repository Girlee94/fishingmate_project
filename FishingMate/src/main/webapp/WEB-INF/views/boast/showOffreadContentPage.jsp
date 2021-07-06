<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">
	var sessionMemberNo = null;
	var freeboard_no = ${showoffVO.showoffVO.showoff_freeboard_no};
	
	function getSessionMemberNo(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionMemberNo = obj.member_no;
			}
		};
		
		xmlhttp.open("get","../member/getSessionMemberNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		
		
	}
	// 추천
	function recommend(){
		
		if(sessionMemberNo == null){
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				refreshRecommend();
			}
		};
		
		xmlhttp.open("get","../Showoff/recommend.do?freeboard_no=" + freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();				
		
	}
	//추천 확인
	function refreshRecommend(){

		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
					
				var recommendButton = document.getElementById("recommendButton");
				var recommendImage = document.createElement("img");
				recommendButton.innerText="";
				if(obj.myRecommendCount > 0){
					recommendButton.innerText="";
					recommendImage.setAttribute("src","/fishingmate/resources/img/recommend2_mh.png");
					recommendImage.setAttribute("width","30");
				}else{
					recommendButton.innerText="";
					recommendImage.setAttribute("src","/fishingmate/resources/img/recommend_mh.png");
					recommendImage.setAttribute("width","30");
				}
				
				recommendButton.appendChild(recommendImage);
				var recommendCountBox = document.getElementById("recommendCountBox");
				recommendCountBox.innerText = obj.recommendTotalCount;
				
			}
		};
		
		xmlhttp.open("get","../Showoff/getRecommendData.do?freeboard_no=" + freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();			
		
	}
	// 댓글 쓰기
	function writeComment(){
		var commentValue = document.getElementById("commentInput").value;
		if(sessionMemberNo == null){
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}
		if (commentValue=="") {
	        alert("글 내용을 입력해주세요.");
	        return;
	    }
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				refreshComment();
			}
		};
		
		xmlhttp.open("post","../Showoff/writeComment.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("freeboard_no=" + freeboard_no + "&showoff_comment_content=" + commentValue);				
	}
	//댓글 보여주기
	function refreshComment(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    var number = 0;
			    
			    var divBox = document.getElementById("divBox");
			    var divBox2 = document.getElementById("divBox2");
			    
			    const str = '\n';
			    
			    divBox.innerText="";
			    divBox2.innerText="";
			    
			    for(var showoffCommentList of obj){
			    	
			    	var divrowBox = document.createElement("div");
			    	divrowBox.setAttribute("class","row border-bottom border-1");
			    	var divcolBox = document.createElement("div");
				    divcolBox.setAttribute("class","col");
				    
				    var memberimaBox = document.createElement("img");
				    memberimaBox.setAttribute("src","/fishingmate/resources/img/name_mh.png"); 
				    memberimaBox.setAttribute("width","23");
			    	
				    var contentaa = "\u00A0";
			    	
			    	var nickBox = document.createElement("span");
			    	nickBox.setAttribute("style","font-size:1.2em;");
			    	nickBox.innerText =contentaa+""+showoffCommentList.memberVO.member_nick+""+contentaa;
			    	divcolBox.appendChild(memberimaBox);
			    	divcolBox.appendChild(nickBox);
			    				    	

			    	var dateBox = document.createElement("span");
			    	dateBox.setAttribute("style","font-size:0.8em;");
			    	
			    	var d = new Date(showoffCommentList.showoffCommentVO.showoff_comment_writedate);
			    	
			    	dateBox.innerText =contentaa+""+contentaa+"("+d.getFullYear() + "." + (d.getMonth() + 1) + "." + d.getDate()+")"+str;
			    	divcolBox.appendChild(dateBox);
			    	
			    	var content = document.createElement("span");
			    	content.setAttribute("style","font-size:1.2em;");
			    	content.innerText = showoffCommentList.showoffCommentVO.showoff_comment_content+""+str;
			    	divcolBox.appendChild(content);
			    	
			    	divrowBox.appendChild(divcolBox);

			    	var count = 0;
			    	
			    	if(sessionMemberNo == showoffCommentList.memberVO.member_no){
			    		var imagdivrowBox = document.createElement("div");
			    		imagdivrowBox.setAttribute("class","row border-bottom border-1");
				    	var imagdivcolBox = document.createElement("div");
				    	imagdivcolBox.setAttribute("class","col");
			    		
			    		var imagaaaBox = document.createElement("img");
			    		var imagbbbBox = document.createElement("img");
			    		var aaaBox = document.createElement("button");
			    		
			    		var spanBox = document.createElement("span");
			    		spanBox.setAttribute("style","font-size:1.2em;");
			    		spanBox.innerText=contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa
			    		+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa
			    		+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa+""+contentaa
			    		+""+contentaa+""+contentaa;
			    		
			    		imagaaaBox.setAttribute("src","/fishingmate/resources/img/edit_mh.png");
			    		imagaaaBox.setAttribute("width","23");
			    		imagbbbBox.setAttribute("src","/fishingmate/resources/img/delete_mh.png");
			    		imagbbbBox.setAttribute("width","23");
			    		
			    		aaaBox.setAttribute("type","submit");
			    		aaaBox.setAttribute("class","border-0");
			    		aaaBox.setAttribute("style","background : none;");
			    		aaaBox.setAttribute("onclick" , "updateComment("+showoffCommentList.showoffCommentVO.showoff_comment_no+","+ number+")");
			    		var deleteBox = document.createElement("button");
				    	deleteBox.setAttribute("type","submit");
				    	deleteBox.setAttribute("class","border-0");
				    	deleteBox.setAttribute("style","background : none;");
				    	deleteBox.setAttribute("onclick" , "removeComment("+showoffCommentList.showoffCommentVO.showoff_comment_no+")");
				    	
				    	aaaBox.appendChild(spanBox);
				    	aaaBox.appendChild(imagaaaBox);
				    	deleteBox.appendChild(imagbbbBox);
				    	imagdivcolBox.appendChild(aaaBox);
				    	imagdivcolBox.appendChild(deleteBox);
				    	divrowBox.appendChild(imagdivcolBox);
				    	
			    	}
			    	divBox.appendChild(divrowBox);
			    	//divBox.appendChild(imagdivrowBox);
			    	number =  number+1;
			    	
			    }
			    
			}
		};
		
		xmlhttp.open("get","../Showoff/getCommentList.do?freeboard_no=" + freeboard_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();				
	}
	// 댓글 수정 입력 폼
	function updateComment(commentNo, bbb){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var commentListBox = document.getElementById("commentListBox");
				var parentLiBox = commentListBox.children[bbb];
				
				var obj = JSON.parse(xmlhttp.responseText);
				var textBoxtr=document.createElement("tr");
				var td0Box=document.createElement("td");
		    	td0Box.setAttribute("width","8px");
				textBoxtr.appendChild(td0Box);
				var td1Box=document.createElement("td");
		    	td1Box.setAttribute("width","45px");
				textBoxtr.appendChild(td1Box);
			    var textBoxList = document.createElement("td");	
			    textBoxList.setAttribute("align","right");
			    var buttonBoxList = document.createElement("td");	
			    buttonBoxList.setAttribute("align","left");
			    buttonBoxList.setAttribute("class","pb-1");
			   //textBoxList.setAttribute("class","p-0");
			    var textBox = document.createElement("textarea");
			    var button = document.createElement("button");
			    var buttonText = document.createTextNode("작성");
			    textBox.setAttribute("name","post");
			    textBox.setAttribute("rows","2");
			    textBox.setAttribute("cols","20");
			    textBox.innerText = obj.showoffcommentVO.showoff_comment_content;
			    textBox.setAttribute("id","aaaa");
			    button.setAttribute("onclick","updateReComment("+commentNo+")");
			    button.setAttribute("class","btn btn-secondary");
			    button.setAttribute("data-bs-container","body");
			    button.setAttribute("data-bs-toggle","popover");
			    button.setAttribute("data-bs-placement","bottom");
			    button.setAttribute("data-bs-content","Bottom popover");
			    button.appendChild(buttonText);
			    var textBoxtd2=document.createElement("th");
				var textBoxtd3=document.createElement("th");
				var textBoxtd4=document.createElement("th");
			    textBoxList.appendChild(textBox);
			    buttonBoxList.appendChild(button);
			    textBoxtr.appendChild(textBoxList);
			    textBoxtr.appendChild(buttonBoxList);
			    //textBoxtr.appendChild(textBoxth2);
			    parentLiBox.after(textBoxtr);
			}
		};
		xmlhttp.open("get","../Showoff/CommentRecall.do?comment_no="+commentNo, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	// 댓글 수정
		function updateReComment(commentNo){
			var showoff_comment= document.getElementById("aaaa").value;
			if(showoff_comment == ""){
				alert("글 내용을 입력해주세요.");
				return;
			}
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
			
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				    //var obj = JSON.parse(xmlhttp.responseText);
				    refreshComment();
				}
			};
			xmlhttp.open("post","../Showoff/UpdateComment.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("showoff_comment_no=" + commentNo + "&showoff_comment_content=" + showoff_comment);
		}
	// 댓글 지우기
		function removeComment(commentNo){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				refreshComment();
			}
		};
		
		xmlhttp.open("get","../Showoff/deleteComment.do?comment_no=" + commentNo , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();				
		
	}
	function init(){
		getSessionMemberNo();
		refreshComment();
		refreshRecommend();
		
		setInterval(refreshComment,5000);
	}
</script>
	<style type="text/css">
	a { text-decoration:none 
	} 
	#box1{
	margin-left: 1px;
 	}
 	#divBox1{
  	}
 	#divBox2{
 	}
	</style>
</head>
<body onload="init()">

<!-- 본문 시작  -->
<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="row container-fluid">
		<div class="col border-end border-1">
			<div class="row">
				<div class="col">
				<!-- 사이드 시작 -->
					<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
				<!-- 사이드 끝 -->
				</div>
			</div>
		</div>
		<div class="col-10">
			<div class="row">
				<div class="col-1">
				</div>
				<div class="col-7 mb-3 border-bottom border-3">
				<h3>자랑 게시판</h3>
				</div>
				<div class="col-4 mb-3 border-bottom border-3">
				</div>
			</div>
			<form action="${pageContext.request.contextPath }/boast/deleteContentProcess.do" method="post" enctype="multipart/form-data">
			<div class="row">
				<div class="col-1">
				</div>
				<div class="col-6 mb-3 border-bottom border-1">
				<h3>${showoffVO.showoffVO.showoff_freeboard_title }</h3>
				</div>
				<div class="col-5 mb-3 border-bottom border-1">
					<div class="row">
						<div class="col-8">
							<img src="/fishingmate/resources/img/name_mh.png" width=20, height=20>&nbsp;<small>${showoffVO.memberVO.member_nick }</small>
							<img src="/fishingmate/resources/img/eye_mh.png" width=20, height=20>&nbsp;<small>${showoffVO.showoffVO.showoff_freeboard_readcount }</small>
							<img src="/fishingmate/resources/img/heart_mh.png" width=20, height=20>&nbsp;<small id="recommendCountBox"></small>
							<img src="/fishingmate/resources/img/calendar_mh2.png" width=20, height=20>&nbsp;<small><fmt:formatDate value="${showoffVO.showoffVO.showoff_freeboard_writedate }" pattern="MM.dd"/></small>
						</div>
						<div class="col"></div>
					</div>
				</div>
				<div class="col">
				</div>
			</div>
			<div class="row">
				<div class="col-1">
				</div>
				<div class="col-6">
				<c:forEach items="${showoffVO.showoffImageVOList }" var="ShowOffImageVO">
				<img src="/upload_files/${ShowOffImageVO.image_location }" class="img-thumbnail" alt="..." width="400">
				</c:forEach>
				</div>
				<div class="col-5">
				어종 <span style="color:#E0E0E0">/</span> 물고기 길이  &nbsp;&nbsp;&nbsp; <strong>${showoffVO.fishname}  <span style="color:#E0E0E0">/</span> ${showoffVO.showoffVO.showoff_freeboard_fishlength} cm</strong>
					<div id="box1" class="row border-top border-1">
					${showoffVO.showoffVO.showoff_freeboard_content }
					</div>
				</div>
			</div>
			<div class="row mb-2">
				<div class="col-7">
					<input type="hidden" value="${showoffVO.showoffVO.showoff_freeboard_no }" name="showoff_freeboard_no">
					<input type="hidden" value="${showoffVO.showoffVO.member_no }" name="member_no">
					<input type="hidden" value="${showoffVO.showoffVO.fish_no }" name="fish_no">
					<input type="hidden" value="${showoffVO.showoffVO.showoff_freeboard_fishlength}" name="showoff_freeboard_fishlength">
				</div>
				<div class="col-4">
				<c:if test="${sessionUser != null && sessionUser.member_no == showoffVO.showoffVO.member_no }">
				<button type="button" class="border-0" style="background : none;" onclick="location.href ='${pageContext.request.contextPath }/boast/updateContentPage.do?freeboard_no=${showoffVO.showoffVO.showoff_freeboard_no}';">
				<img src="/fishingmate/resources/img/edit_mh.png" width="30">
				</button>
				</c:if>
				<c:if test="${sessionUser != null && sessionUser.member_no == showoffVO.showoffVO.member_no }">
				<button type="submit" class="border-0" style="background : none;"><img src="/fishingmate/resources/img/delete_mh.png" width="30"></button>
				</c:if>
				<button id="recommendButton" class="border-0" type="button" onclick="recommend()" style="background : none;"></button>
				<button type="button" class="border-0" style="background : none;" onclick="location.href ='${pageContext.request.contextPath }/main/boast.do';" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-content="Bottom popover">
				<img src="/fishingmate/resources/img/list_mh.png" width="30">
					</button>
				</div>
				<div class="col">
				</div>
			</div>
			</form>
			<form action="${pageContext.request.contextPath }/boast/writeComment.do" method="post">
			<div class="row">
				<div class="col-1">
					<input type="hidden" name="showoff_freeboard_no" value="${showoffVO.showoffVO.showoff_freeboard_no }">
					<input type="hidden" name="member_no" value="${sessionUser.member_no}">
				</div>
				<div class="col-6 mt-2">
					<textarea id="commentInput" name="showoff_comment_content" class="form-control" rows="3"></textarea>
				</div>
				<div class="col-2 mt-4">
					<c:if test="${sessionUser != null}">
					<button type="submit" onclick="writeComment()" class="border-0" style="background : none;">
					<img src="/fishingmate/resources/img/chat_mh.png" width="50" height="50"></button>
					</c:if>
				</div>
				<div class="col">
				</div>
			</div>
			</form>
			<div class="row mt-2 mb-2">
				<div class="col-1">
				</div>
				<div class="col">
					<div class="row">
						<div class="col-7 border-top border-3" id="divBox">
						</div>
						<div class="col-2" id="divBox2">
						</div>
						<div class="col">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>