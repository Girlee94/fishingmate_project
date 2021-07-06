<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/header.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
	<script type="text/javascript">
	var sessionMemberNo= null;
	var info_freeboard_no =${infofreeboardVO.infoFreeboardVO.info_freeboard_no};
	
	function getSessionMemberNo(){
		
		var xmlhttp =new XMLHttpRequest();
		 
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionMemberNo = obj.member_no;
			}
		};
		xmlhttp.open("get","${pageContext.request.contextPath}/member/getSessionMemberNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	function infoWriteComment(){
		if(sessionMemberNo == null){
			alert("로그인을 하셔야 생각을 적을수 있습니다");
		return;
		
	}
	var info_comment_content = document.getElementById("info_comment_content").value;	
	
	
	var xmlhttp = new XMLHttpRequest();
	
	xmlhttp.onreadystatechange =function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			
			refreshInfoCommentData();
		}
		
	};
	xmlhttp.open("post","${pageContext.request.contextPath}/infofreeboard/infoWriteComment.do", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("info_freeboard_no=" +info_freeboard_no + "&info_comment_content=" +info_comment_content);
	
	}
	
	//정보게시판 댓글 불러오기
	
	function refreshInfoCommentData(){
		
		var info_comment_count = document.getElementById("info_comment_count");
		var info_comment_content = document.getElementById("info_comment_content");
		
		if(sessionMemberNo != null){
			info_comment_content.value="";
		}
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				var obj =JSON.parse(xmlhttp.responseText);
				
				info_comment_count.innerText ="댓글("+obj.commentCount+")";
				var info_comment_list = document.getElementById("info_comment_list");
				info_comment_list.innerText ="";
				
				var info_comment_list_first =document.getElementById("comment_list_first");
				var info_commentLi = info_comment_list_first.cloneNode(true);
				info_commentLi.removeAttribute("class");
				info_commentLi.setAttribute("class","list-group-item");
				info_comment_list.appendChild(info_commentLi);
				
			for(var commentList of obj.infoCommentList){
				
				var info_commentLi = document.createElement("li");
				info_commentLi.setAttribute("class","list-group-item");
				
				
				var commentRowBox = document.createElement("div");
				commentRowBox.setAttribute("class", "row mt-2 mb-2");
				
				//댓글 작성자 부분
				var commentMemberColBox=document.createElement("div");
				var commentMemberSpanBox = document.createElement("span");
				var commentDateSmallBox = document.createElement("small");
				commentMemberColBox.setAttribute("class","col-2 pe-2 border-end border-1");
				commentMemberSpanBox.innerText = commentList.memberVO.member_nick+"\n";
								 
				commentMemberSpanBox.appendChild(commentDateSmallBox);
				commentMemberColBox.appendChild(commentMemberSpanBox);
				commentRowBox.appendChild(commentMemberColBox);
				
				//정보 게시판 댓글 내용 부분
				var commentContentColBox = document.createElement("div");
				var commentContentSpanBox = document.createElement("span");
				commentContentColBox.setAttribute("class","col pe-2 border-end border-1");
				commentContentSpanBox.innerText = commentList.infoFreeboardCommentVO.info_comment_content;
				commentContentColBox.appendChild(commentContentSpanBox);
				commentRowBox.appendChild(commentContentColBox);
				
			     
				//댓글 날짜 부분
				var commentDateColBox = document.createElement("div");
				var commentDateSpanBox = document.createElement("span");
				commentDateColBox.setAttribute("class", "col-2 pe-2 border-end border-1");
				
				var commentWriteDate = new Date(commentList.infoFreeboardCommentVO.info_comment_writedate);
				commentDateSpanBox.innerText =
						commentWriteDate.getFullYear() + "." + 
						(commentWriteDate.getMonth()+1 > 9 ? commentWriteDate.getMonth()+1 : "0" + (commentWriteDate.getMonth()+1)) + "." + 
						(commentWriteDate.getDate() > 9 ? commentWriteDate.getDate() : "0" + (commentWriteDate.getDate()));
				commentDateColBox.appendChild(commentDateSpanBox);		
				commentRowBox.appendChild(commentDateColBox);
				
				
				//댓글 삭제 버튼만들기 이건 왜 
				var commentDeleteColBox=document.createElement("div");
				commentDeleteColBox.setAttribute("class","col-1 text-center position-relative");
				if(sessionMemberNo == commentList.infoFreeboardCommentVO.member_no){
					//댓글 삭제 버튼 만들기
					var commentDeleteButton = document.createElement("button");
					commentDeleteButton.setAttribute("class", "btn btn-outline-danger btn-sm position-absolute start-50 top-50 translate-middle");
					commentDeleteButton.setAttribute("onclick", "infoDeleteComment(" + commentList.infoFreeboardCommentVO.info_comment_no+")");
					commentDeleteButton.innerText="Delete";
					commentDeleteColBox.appendChild(commentDeleteButton);
					}
				commentRowBox.appendChild(commentDeleteColBox);
				
				info_commentLi.appendChild(commentRowBox);
				info_comment_list.appendChild(info_commentLi);
				
				//업데이트
			 	var commentUpdateColBox = document.createElement("div");
				commentUpdateColBox.setAttribute("class","col-1 text-center position-relative");
				if(sessionMemberNo == commentList.infoFreeboardCommentVO.member_no){
					var commentUpdateButton = document.createElement("button");
					commentUpdateButton.setAttribute("class","btn btn-outline-primary btn-sm position-absolute start-50 top-50 translate-middle");
					commentUpdateButton.setAttribute("onclick", "infoUpdateComment(" + commentList.infoFreeboardCommentVO.info_comment_no + ", this)");
					commentUpdateButton.innerText = "update";
					commentUpdateColBox.appendChild(commentUpdateButton);
					
					
				}
			commentRowBox.appendChild(commentUpdateColBox); 
			
			}
			}
		};
		xmlhttp.open("get","${pageContext.request.contextPath}/infofreeboard/getInfoCommentData.do?info_freeboard_no="+info_freeboard_no,true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
		
	}

	//정보게시판 댓글 삭제
	function infoDeleteComment(info_comment_no){
		//AJAX 호출란
		var xmlhttp = new XMLHttpRequest();
		
		//처리 로직
		
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj =JSON.parse(xmlhttp.responseText);
				
				refreshInfoCommentData();
				
			}	
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/infofreeboard/infoDeleteComment.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("info_comment_no="+info_comment_no);
	}
	
	
	function infoUpdateCommentProcess(info_comment_no){
		var info_comment_updateContent=document.getElementById("info_comment_updateContent").value;
		
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange= function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				refreshInfoCommentData();
			}
		};
		xmlhttp.open("post","${pageContext.request.contextPath}/infofreeboard/infoUpdateCommentProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("info_comment_no=" + info_comment_no + "&info_comment_content=" + info_comment_updateContent);
		
	}
	
	//댓글 수정 입력란 불러오기
	function infoUpdateComment(info_comment_no, commentRowBox) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		var parentLiBox = commentRowBox.parentElement.parentElement.parentElement;
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var comment_list_update_frm = document.getElementById("comment_list_update_frm");
				var commet_update_box = comment_list_update_frm.cloneNode(true);
				
				commet_update_box.removeAttribute("class");
				commet_update_box.setAttribute("class", "list-group-item");
				commet_update_box.firstElementChild.children[1].children[0].innerText = obj.infoFreeboardCommentVO.info_comment_content;
				commet_update_box.firstElementChild.children[2].children[0].setAttribute("onclick", "infoUpdateCommentProcess(" + obj.infoFreeboardCommentVO.info_comment_no + ")");
				parentLiBox.after(commet_update_box);
				
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/infofreeboard/getInfoOneCommentData.do?info_comment_no=" + info_comment_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//추천  형준이 버전
	function doRecommend(){
		
		if(sessionMemberNo == null){
			
			alert("로그인을 하셔야 추천이 가능합니다.");
			return;
		}
		
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			
				refreshRecommendData();
				
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/infofreeboard/doRecommend.do?info_freeboard_no="+info_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//추천 다시 보여주는 파트
	function refreshRecommendData(){
		
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			var obj = JSON.parse(xmlhttp.responseText);
			
			var recommend_button = document.getElementById("recommend_button");
			if(obj.checkdoRecommend > 0){
				recommend_button.removeAttribute("class");
				recommend_button.setAttribute("class", "bi bi-heart-fill");
				recommend_button.setAttribute("style", "font-size: 30px; color: red;");
			}else{
				recommend_button.removeAttribute("class");
				recommend_button.setAttribute("class", "bi bi-heart");
				recommend_button.setAttribute("style", "font-size: 30px; font-weight:bold;");
			}
			
			var recommendCountBox = document.getElementById("recommendCountBox");
			recommendCountBox.innerText=obj.recommendCount;
			
		}
		};
		xmlhttp.open("get","${pageContext.request.contextPath}/infofreeboard/getRecommendData.do?info_freeboard_no="+info_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	
	
	function init(){
		getSessionMemberNo();
		refreshInfoCommentData();
		refreshRecommendData();
	}
	
	
	</script>

</head>
<body onload="init()">
    <div style="width: 1200px; margin: 0 auto; ">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="container-fluid my-5">
		<div class="row">
			<div class="col border-end border-1">
				<!-- 사이드 시작 -->
					<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
				<!-- 사이드 끝 -->
			</div>
			<div class="col-10">
			    <div class="row my-4">
						<div class="col-1"></div>
						<div class="col-7 border-bottom border-2">
							<p class="h2 pb-2 ps-2 mt-2">${infofreeboardVO.infoFreeboardVO.info_freeboard_title}</p>
						</div>
						<div class="col border-bottom border-2 position-relative">
							<span class="position-absolute top-50 end-0 translate-middle-y">
							<small>
								<i class="bi bi-person-fill"></i>&nbsp;<b>${infofreeboardVO.memberVO.member_nick} &nbsp;&nbsp;
								<i class="bi bi-eye-fill"></i>&nbsp;${infofreeboardVO.infoFreeboardVO.info_freeboard_readcount }&nbsp;&nbsp;
								<i class="bi bi-heart-fill"></i>&nbsp;<span id="recommendCountBox"></span>&nbsp;&nbsp;
								<i class="bi bi-calendar-check"></i>&nbsp;<fmt:formatDate value="${infofreeboardVO.infoFreeboardVO.info_freeboard_writedate }" pattern="yyyy.MM.dd" />
							</small>
							</span>
						</div>
			    </div>
				<div class="row">
				   <div class="col-1"></div>
				   <div class="col p-3 border border-1 me-1 text-center">
				       <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
								<div class="carousel-indicators">
									<c:forEach items="${infofreeboardVO.infofreeboardImageVOList }"
										var="infofreeboardImageVO" varStatus="status">
										<button type="button"
											data-bs-target="#carouselExampleIndicators"
											data-bs-slide-to="${status.index }" class="active"
											aria-current="true" aria-label="Slide 1"></button>
									</c:forEach>
								</div>
								<div class="carousel-inner">
									<c:forEach items="${infofreeboardVO.infofreeboardImageVOList }"
										var="infofreeboardImageVO" varStatus="status">
										<c:choose>
											<c:when test="${status.index == 0 }">
												<div class="carousel-item active">
													<img id="info_read_thumnail"
														src="/upload_files/${infofreeboardImageVO.image_location }"
														class="d-block w-100" width="800" height="450">
												</div>
											</c:when>
											<c:otherwise>
												<div class="carousel-item">
													<img id="info_read_thumnail"
														src="/upload_files/${infofreeboardImageVO.image_location }"
														class="d-block w-100" width="800" height="450">
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
								<button class="carousel-control-prev" type="button"
									data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Previous</span>
								</button>
								<button class="carousel-control-next" type="button"
									data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Next</span>
								</button>
							</div>
				  
								
					</div>			
				</div>
				<div class="row mt-3">
				   <div class="col-1"></div>
				   <!-- 내용 -->  
				   <div class="col border border-1 p-3" style="height: 200px;">			    
						${infofreeboardVO.infoFreeboardVO.info_freeboard_content }
				   </div>
				</div>
				<div class="row mt-3">
				   <div class="col-1"></div>
				   <div class="col border-bottom border-1 text-end p-0">
				    <!-- 추천수 -->  
					<span id="recommend_button" onclick="doRecommend()"></span>
					&nbsp;<span id="recommendCountBox"></span>
					</div>
				</div>   
				<div class="row mt-4"> 
				   <div class="col-1"></div>
				   <div class="col-1 align-self-center"><span id="info_comment_count"></span></div>
				   <div class="col text-end">
				       <c:if test="${sessionUser != null && sessionUser.member_no == infofreeboardVO.memberVO.member_no }">
							<a href="${pageContext.request.contextPath }/infofreeboard/updateinfoContent.do?info_freeboard_no=${infofreeboardVO.infoFreeboardVO.info_freeboard_no}"><i style="font-size: 25px; color: blue;" class="bi bi-pencil-square"></i></a>&nbsp;&nbsp;<!-- 수정 -->
						    <a href="${pageContext.request.contextPath }/infofreeboard/deleteinfoContentProcess.do?info_freeboard_no=${infofreeboardVO.infoFreeboardVO.info_freeboard_no}"><i style="font-size: 25px; color: darkred;"class="bi bi-trash"></i></a>&nbsp;<!-- 삭제 -->
							
					    </c:if>
				   </div>
				</div>								
               <div id="comment_box" class="row mt-2 pb-2 "> 
				   <div class="col-1"></div>
			       <div class="col px-0 d-grid border-bottom border-1 pb-2">					  
			         <textarea id="info_comment_content" class="form-control" name="info_comment_content" placeholder="댓글을 입력하세요"></textarea>
			       </div> 
			       <div class="col-1 text-end p-2 border-bottom border-1">
				      <button type="button" class="btn btn-primary" style="width: 80px; height: 50px;" onclick="infoWriteComment()"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
								 <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
						 	 </svg>&nbsp;댓글
					  </button>
			       </div>   		 		    
			   </div> 
			   <div class="row">
		           <div class="col-1"></div>
				   <div class="col border-bottom border-1 p-0">
						<ul id="info_comment_list" class="list-group list-group-flush"></ul>
						<li id="comment_list_first" class="list-group-item visually-hidden">
							<div class="row mt-1 mb-1">   
								<div class="col-2 pe-2 border-end border-1">
									<span class="fw-bold">작성자</span>  
								</div>
								<div class="col pe-2 border-end border-1">
									<span class="fw-bold">내용</span>
								</div>
								<div class="col-2 pe-2 border-end border-1">
									<span class="fw-bold">작성날짜</span>
								</div>
								<div class="col-1 text-center">
								</div>
								<div class="col-1 text-center">
								</div>
							</div>
						</li>
		
						<li id="comment_list_update_frm" class="list-group-item visually-hidden">
							<div class="row mt-2 mb-2">
								<div class="col-2 pe-2 border-end border-1"></div>
								<div class="col pe-2 border-end border-1">
									<textarea id="info_comment_updateContent" name="info_comment_content" class="form-control"></textarea>
								</div>
								<div class="col-2 text-center d-grid">
									<button class="btn btn-primary">수정</button>
								</div>
							</div>  
						</li>
				   </div> 
				</div>
			   
			   
				<div class="row text-end mt-3"> 
				  <div class="col"></div>
				  <div class="col-2">
				     <a href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do" style=" color:black; text-decoration:none"><i style="font-size: 25px; color: black;"class="bi bi-house-door-fill"></i>&nbsp;목록으로</a><!-- 홈 -->	
				  </div>
				</div>  

		
			</div>
		</div>
	</div>  
	</div>

	<div style="width: 100%; margin: 0 auto;">
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous"></script>
</body>
</html>