<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/execDaumPostcode.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateReadContentPage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">
	var sessionMemberNo = null;
	var mate_freeboard_no = ${oneMateContent.mateFreeboardVO.mate_freeboard_no};
	var apply_modal = null;
	var wishlist_toast = null;
	var toast_container = null;
	
	function redirectLoginPage(){
		location.href="${pageContext.request.contextPath }/member/loginPage.do";
	}
	
	function getSessionMemberNo() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
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
	
	//현재 신청인원 조회
	function getApplyGroupCount() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var apply_count = document.getElementById("apply_count");
				
				apply_count.innerText = obj.applyGroupCount;
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getApplyGroupCount.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	//-------------------------- 메이트 게시판 찜목록 시작 - 형준 -----------------------------
	//메이트 게시판 찜목록에 추가 - 형준
	function doMateFreeboardToWishListProcess() {
		if (sessionMemberNo == null) {
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}
		
		if(sessionMemberNo == "${oneMateContent.mateFreeboardVO.member_no}"){
			alert("자신의 글은 찜목록에 추가할 수 없습니다");
			return;
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var toast_boay_span = document.getElementById("toast_boay_span");
				
				if (obj.doWishListCount == 0) {
					toast_boay_span.innerText = "찜목록에서 제거되었습니다.";
					showToastAfterInsertWishList();
				} else {
					toast_boay_span.innerText = "찜목록에 추가되었습니다.";
					showToastAfterInsertWishList();
				}
				
				refreshWishListData();
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/doMateFreeboardToWishListProcess.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	//찜목록에 추가/삭제 시 Toast발생
	function showToastAfterInsertWishList() {
		wishlist_toast = new bootstrap.Toast(document.getElementById('liveToast'));
		//var wishlist_toast = document.getElementById('liveToast');
		//var toast_container = document.getElementById('toast_container');
		//toast_container.appendChild(wishlist_toast);
		
		//var aaa = new bootstrap.Toast(toast_container);
		//aaa.show();
		wishlist_toast.show();
	}
	
	
	function refreshWishListData() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var wishlist_btn = document.getElementById("wishlist_btn");
				if(obj.chkInsertWishList > 0){
					wishlist_btn.setAttribute("class", "bi bi-star-fill fs-3 text-warning");
				} else {
					wishlist_btn.setAttribute("class", "bi bi-star fs-3 text-warning");
				}
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getWishListData.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	//------------------------------ 메이트 게시판 찜목록 끝 -----------------------------------
	
	//추천
	function doRecommend() {
		
		if (sessionMemberNo == null) {
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				refreshRecommendData();
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/doRecommend.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	function refreshRecommendData(){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var recommend_btn = document.getElementById("recommend_btn");
				if(obj.chkDoRecommend > 0){
					recommend_btn.setAttribute("class", "bi bi-hand-thumbs-up-fill fs-3 ms-2 text-primary");
				} else {
					recommend_btn.setAttribute("class", "bi bi-hand-thumbs-up fs-3 ms-2 text-primary");
				}
				
				var recommendCountBox = document.getElementById("recommendCountBox");
				recommendCountBox.innerText = obj.recommedCount;
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getRecommendData.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	//댓글 입력
	function mateWriteComment(){
		if (sessionMemberNo == null) {
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}
		
		var mate_comment_content = document.getElementById("mate_comment_content");
		if(mate_comment_content.value == ""){
			alert("댓글을 입력해주세요.");
			mate_comment_content.focus();
			return;
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				refreshMateCommentData();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/mateWriteCommentProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("mate_freeboard_no=" + mate_freeboard_no + "&mate_comment_content=" + mate_comment_content.value);	
	}
	
	//댓글 삭제
	function mateDeleteComment(mate_comment_no) {
		 if (confirm("댓글을 삭제하시겠습니까?")) {
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
			
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
					//var obj = JSON.parse(xmlhttp.responseText);
					
					refreshMateCommentData();
				}
			};
			
			xmlhttp.open("post","${pageContext.request.contextPath}/mate/mateDeleteCommentProcess.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("mate_comment_no=" + mate_comment_no);
		} else {
			return;
		}
	}
	
	//댓글 수정 입력란 불러오기
	function mateUpdateComment(mate_comment_no, commentRowBox) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		var comment_updateContent_area = document.getElementById("comment_updateContent_area");
		if(comment_updateContent_area){
			console.log("있");
			comment_updateContent_area.previousSibling.children[0].children[2].children[0].removeAttribute("disabled");
			comment_updateContent_area.remove();
		}
		
		var parentLiBox = commentRowBox.parentElement.parentElement.parentElement;
		commentRowBox.setAttribute("disabled", "disabled");
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var comment_list_update_frm = document.getElementById("comment_list_update_frm");
				var commet_update_box = comment_list_update_frm.cloneNode(true);
				commet_update_box.removeAttribute("class");
				commet_update_box.setAttribute("class", "list-group-item");
				commet_update_box.setAttribute("id", "comment_updateContent_area");
				commet_update_box.firstElementChild.children[1].children[0].innerText = obj.mateFreeboardCommentVO.mate_comment_content;
				
				//수정 버튼
				commet_update_box.firstElementChild.children[2].children[0].setAttribute("id", "comment_update_btn");
				commet_update_box.firstElementChild.children[2].children[0].setAttribute("onclick", "mateUpdateCommentProcess(" + obj.mateFreeboardCommentVO.mate_comment_no + ")");
				
				//삭제 버튼
				commet_update_box.firstElementChild.children[3].children[0].setAttribute("onclick", "mateUpdateCommentCancel()");
				
				parentLiBox.after(commet_update_box);
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getMateOneCommentData.do?mate_comment_no=" + mate_comment_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//댓글 수정 입력란 제거(수정 취소) - 형준
	function mateUpdateCommentCancel() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				refreshMateCommentData();
			}
		};
		
		xmlhttp.open("get","#", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//댓글 수정 - 형준
	function mateUpdateCommentProcess(mate_comment_no) {
		
		var mate_comment_updateContent = document.getElementById("mate_comment_updateContent").value;
		var comment_update_btn = document.getElementById("comment_update_btn");
		comment_update_btn.removeAttribute("disabled");
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				refreshMateCommentData();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/mateUpdateCommentProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("mate_comment_no=" + mate_comment_no + "&mate_comment_content=" + mate_comment_updateContent);
	}
	
	
	//댓글 불러오기
	function refreshMateCommentData() {
		
		var comment_count = document.getElementById("comment_count");
		var mate_comment_content = document.getElementById("mate_comment_content");
		if(sessionMemberNo != null){
			mate_comment_content.value = "";
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				comment_count.innerText = "댓글(" + obj.commentCount + ")";
				var comment_list = document.getElementById("comment_list");
				comment_list.innerText = "";
				
				var comment_list_first = document.getElementById("comment_list_first");
				var commentLi = comment_list_first.cloneNode(true);
				commentLi.removeAttribute("class");
				commentLi.setAttribute("class", "list-group-item");
				comment_list.appendChild(commentLi);
				
				for(var commentList of obj.mateCommentList){
					
					var commentLi = document.createElement("li");
					commentLi.setAttribute("class", "list-group-item");
					
					var commentRowBox = document.createElement("div");
					commentRowBox.setAttribute("class", "row");
					
					//댓글 작성자 부분
					var commentMemberColBox = document.createElement("div");
					var commentMemberSpanBox = document.createElement("span");
					var commentDateSmallBox = document.createElement("small");
					commentMemberColBox.setAttribute("class", "col-2 pe-2 border-end border-1");
					commentMemberSpanBox.innerText = commentList.member_nick + "\n";
					var commentWriteDate = new Date(commentList.mateFreeboardCommentVO.mate_comment_writedate);
					commentDateSmallBox.innerText = "(" + 
							(commentWriteDate.getFullYear()).toString().substr(2, 4) + "." + 
							(commentWriteDate.getMonth()+1 > 9 ? commentWriteDate.getMonth()+1 : "0" + (commentWriteDate.getMonth()+1)) + "." + 
							(commentWriteDate.getDate() > 9 ? commentWriteDate.getDate() : "0" + commentWriteDate.getDate())
							+ " " + commentWriteDate.getHours() + ":" + commentWriteDate.getMinutes() + 
							")";
					commentMemberSpanBox.appendChild(commentDateSmallBox);
					commentMemberColBox.appendChild(commentMemberSpanBox);
					commentRowBox.appendChild(commentMemberColBox);
					
					//댓글 내용 부분
					var commentContentColBox = document.createElement("div");
					var commentContentSpanBox = document.createElement("span");
					commentContentColBox.setAttribute("class", "col-8 pe-2 border-end border-1");
					commentContentSpanBox.innerText = commentList.mateFreeboardCommentVO.mate_comment_content;
					commentContentColBox.appendChild(commentContentSpanBox);
					commentRowBox.appendChild(commentContentColBox);
					
					//댓글 버튼 영역 부분
					var commentUpdateColBox = document.createElement("div");
					commentUpdateColBox.setAttribute("class", "col-1 text-center position-relative");
					if(sessionMemberNo == commentList.mateFreeboardCommentVO.member_no){
						var commentUpdateButton = document.createElement("button");
						commentUpdateButton.setAttribute("class", "btn btn-outline-primary btn-sm position-absolute start-50 top-50 translate-middle");
						commentUpdateButton.setAttribute("onclick", "mateUpdateComment(" + commentList.mateFreeboardCommentVO.mate_comment_no + ", this)");
						commentUpdateButton.innerText = "수정";
						commentUpdateColBox.appendChild(commentUpdateButton);
					}
					commentRowBox.appendChild(commentUpdateColBox);
					
					var commentDeleteColBox = document.createElement("div");
					commentDeleteColBox.setAttribute("class", "col-1 text-center position-relative");
					if(sessionMemberNo == commentList.mateFreeboardCommentVO.member_no){
						var commentDeleteButton = document.createElement("button");
						commentDeleteButton.setAttribute("class", "btn btn-outline-danger btn-sm position-absolute start-50 top-50 translate-middle");
						commentDeleteButton.setAttribute("onclick", "mateDeleteComment(" + commentList.mateFreeboardCommentVO.mate_comment_no + ")");
						commentDeleteButton.innerText = "삭제";
						commentDeleteColBox.appendChild(commentDeleteButton);
					}
					commentRowBox.appendChild(commentDeleteColBox);
					
					commentLi.appendChild(commentRowBox);
					comment_list.appendChild(commentLi);
				}
				
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getMateCommentData.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//게시글 삭제 - 형준
	function deleteMateContentProcess() {
		if (confirm("글을 삭제하시겠습니까?")) {
			var content_delete_frm = document.getElementById("content_delete_frm");
			content_delete_frm.submit();
		} else {
			return;
		}
	}
	
	//메이트 신청 Modal 호출 - 형준
	function openApplyModal() {
		apply_modal = new bootstrap.Modal(document.getElementById("applyModal"));
		apply_modal.show();
	}
	
	//메이트 신청하기 - 형준
	function mateApplyGroupProcess() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				var mate_apply_btn = document.getElementById("mate_apply_btn");
				var mate_content = document.getElementById("mate_content");
				
				mate_apply_btn.setAttribute("disabled", "disabled");
				mate_apply_btn.innerText = "신청완료";
				
				apply_modal.hide();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/mateApplyGroupProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("mate_content=" + mate_content.value + "&mate_freeboard_no=" + mate_freeboard_no);	
	}
	
	function init() {
		getSessionMemberNo();
		refreshRecommendData();
		refreshMateCommentData();
		getApplyGroupCount();
		refreshWishListData();
	}
	
</script>
</head>
<body onload="init()">

	<div style="width: 1200px; margin: 0 auto;" >
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
		
		<!-- 게시글 보이기 부분 -->
		<div class="container-fluid mb-5">
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
							<p class="h2 pb-2 ps-2 mt-2">${oneMateContent.mateFreeboardVO.mate_freeboard_title }</p>
						</div>
						<div class="col border-bottom border-2 position-relative">
							<span class="position-absolute top-50 end-0 translate-middle-y">
							<small>
								<b>${oneMateContent.memberVO.member_nick }</b>&nbsp;&nbsp;|&nbsp;
								조회수&nbsp;${oneMateContent.mateFreeboardVO.mate_freeboard_readcount }&nbsp;&nbsp;|&nbsp;
								&nbsp;추천수&nbsp;<span id="recommendCountBox"></span>&nbsp;&nbsp;|&nbsp;
								<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_writedate }"/>
							</small>
							</span>
						</div>
					</div>
					<div class="row">
						<div class="col-1"></div>
						<div class="col-8 p-3 border border-1 me-1 text-center">
							<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
								<div class="carousel-indicators">
									<c:forEach items="${oneMateContent.mateFreeboardImageVOList }" var="images" varStatus="status">
										<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index }" class="active" aria-current="true" aria-label="Slide 1"></button>
									</c:forEach>
								</div>
								<div class="carousel-inner">
									<c:forEach items="${oneMateContent.mateFreeboardImageVOList }" var="images" varStatus="status">
										<c:choose>
											<c:when test="${status.index == 0 }">
												<div class="carousel-item active mt-4">
													<img id="mate_read_thumnail" src="/upload_files/${images.image_location }" class="d-block w-100">
												</div>
											</c:when>
											<c:otherwise>
												<div class="carousel-item mt-4">
													<img id="mate_read_thumnail" src="/upload_files/${images.image_location }" class="d-block w-100">
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
								<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Previous</span>
								</button>
								<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Next</span>
								</button>
							</div>
						</div>
						<div class="col py-3 px-0 border border-1">
							<ul class="list-group list-group-flush border-bottom border-1">
								<li class="list-group-item">
									모집인원 - ${oneMateContent.confirmGroupCount }/${oneMateContent.mateFreeboardVO.mate_freeboard_maxnumber }명<br>
									<small>
										(현재 신청인원 <span id="apply_count"></span>명)
									</small>
								</li>
								<li class="list-group-item">
									낚시종류 - ${oneMateContent.fishingCategoryVO.fishing_category_name }
								</li>
								<li class="list-group-item">
									낚시터 위치 - <br>
									<small>
										(도로명)<br>
										${oneMateContent.mateFreeboardVO.mate_freeboard_roadAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress }<br>
									</small>
								</li>
								<li class="list-group-item">
									<small>
										(지번)<br>
										${oneMateContent.mateFreeboardVO.mate_freeboard_jibunAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress }
									</small>
								</li>
								<li class="list-group-item">
									낚시 일정<br>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_startdate}"/> ~ 
									<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_enddate}"/>
								</li>
							</ul>
							<div class="row d-flex flex-column align-items-end">
								<div class="col">
									<span class="mt-2 py-2 d-grid">
										<c:choose>
											<c:when test="${oneMateContent.mateCategoryVO.mate_category_no == 3 }">
												<button type="button" class="btn btn-lg btn-outline-danger d-grid" disabled>
													${oneMateContent.mateCategoryVO.mate_category_name }
												</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-lg btn-outline-primary d-grid" disabled>
													${oneMateContent.mateCategoryVO.mate_category_name }
												</button>
											</c:otherwise>
										</c:choose>
									</span>
								</div>
								<div class="col">
									<span class="mt-2 d-grid">
										<c:choose>
											<c:when test="${!empty sessionUser && sessionUser.member_no == oneMateContent.memberVO.member_no && oneMateContent.mateCategoryVO.mate_category_no == 1 }">
												<a class="btn btn-primary btn-lg d-grid" href="${pageContext.request.contextPath }/mate/mateConfirmGroupPageByLeader.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">
													신청현황
												</a>
											</c:when>
											<c:when test="${!empty sessionUser && !empty oneMateContent.mate_confirm_no && oneMateContent.mateCategoryVO.mate_category_no == 2}">
												<a class="btn btn-primary btn-lg d-grid" href="${pageContext.request.contextPath }/mate/mateConfirmGroupPage.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">
													명단 확인
												</a>
											</c:when>
											<c:when test="${oneMateContent.mateCategoryVO.mate_category_no == 2 }">
												<button class="btn btn-primary btn-lg d-grid" disabled>종료</button>
											</c:when>
											<c:when test="${oneMateContent.mateCategoryVO.mate_category_no == 3 }">
												<button class="btn btn-primary btn-lg d-grid" disabled>취소</button>
											</c:when>
											<c:when test="${!empty sessionUser && chkApplyGroup eq 0 }">
												<button type="button" id="mate_apply_btn" class="btn btn-primary btn-lg d-grid" onclick="openApplyModal()">신청</button>
											</c:when>
											<c:when test="${!empty sessionUser && chkApplyGroup ne 0 }">
												<button class="btn btn-primary btn-lg d-grid" disabled>신청완료</button>
											</c:when>
											<c:otherwise>
												<button class="btn btn-primary btn-lg d-grid" disabled>로그인 후 신청 가능</button>
											</c:otherwise>
										</c:choose>
									</span>
								</div>
							</div>
						</div> 
					</div>
					<div class="row mt-2">
						<div class="col-1"></div>
						<div class="col border border-1 py-3">
							<p id="mate_read_content">
								${oneMateContent.mateFreeboardVO.mate_freeboard_content }
							</p>
						</div>
					</div>
					<div class="row mt-4 pb-2 align-items-end">
						<div class="col-1"></div>
						<div class="col border-bottom border-1"></div>
						<div class="col-2 border-bottom border-1 text-end p-0">
							<i id="wishlist_btn" onclick="doMateFreeboardToWishListProcess()"></i>
							<i id="recommend_btn" onclick="doRecommend()"></i>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-1"></div>
						<div class="col ps-0">
							<span id="comment_count" class="h6 fw-bold"></span>
						</div>
					</div>
					<div id="mate_comment_form" class="row mt-2 pb-2">
						<div class="col-1"></div>
						<div class="col px-0 d-grid border-bottom border-1 pb-2">
							<c:choose>
								<c:when test="${empty sessionUser }">
									<div class="row px-0">
										<div class="col d-grid">
											<textarea class="form-control resize-none" name="mate_comment_content" placeholder="로그인 후 입력 가능합니다" disabled></textarea>
										</div>
										<div class="col-2 d-grid">
											<button class="btn btn-primary align-middle" onclick="redirectLoginPage()">로그인</button>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="row">
										<div class="col d-grid">
											<textarea class="form-control" id="mate_comment_content" name="mate_comment_content" placeholder="댓글을 입력하세요"></textarea>
										</div>
										<div class="col-2 d-grid">
											<button class="btn btn-primary" onclick="mateWriteComment()">작성</button>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="row">
						<div class="col-1"></div>
						<div class="col border-bottom border-1 p-0">
							<ul id="comment_list" class="list-group list-group-flush"></ul>
						</div>
					</div>
					<div class="row mt-4 pt-3">
						<div class="col-1"></div>
						<div class="col border-top border-2"></div>
						<c:if test="${!empty sessionUser && sessionUser.member_no == oneMateContent.mateFreeboardVO.member_no }">
							<div class="col-1 d-grid p-0 border-top border-2">
								<a class="btn btn-primary mt-2" href="${pageContext.request.contextPath }/mate/mateUpdateContentPage.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">수정</a>
							</div>
							<div class="col-1 p-0 border-top border-2">
								<form id="content_delete_frm" class="p-0 d-grid" action="${pageContext.request.contextPath }/mate/deleteContentProcess.do" method="post">
									<input type="hidden" value="${oneMateContent.mateFreeboardVO.mate_freeboard_no }" name="mate_freeboard_no">
									<button class="btn btn-outline-danger ms-2 mt-2" onclick="deleteMateContentProcess()">삭제</button>
								</form>
							</div>
						</c:if>
						<div class="col-1 d-grid p-0 border-top border-2">
							<a class="btn btn-outline-primary ms-2 mt-2" href="${pageContext.request.contextPath }/mate/matePage.do">목록</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!--============================ UI 복사용 / hidden 시작 =========================================-->
	<!--  -->
	<li id="comment_list_first" class="list-group-item visually-hidden">
		<div class="row">
			<div class="col-2 pe-2 border-end border-1">
				<span class="fw-bold">작성자</span>
			</div>
			<div class="col pe-2 border-end border-1">
				<span class="fw-bold">내용</span>
			</div>
			<div class="col-1 text-center">
			</div>
			<div class="col-1 text-center">
			</div>
		</div>
	</li>
	
	<!-- 댓글 수정 입력 폼 -->
	<li id="comment_list_update_frm" class="list-group-item visually-hidden">
		<div class="row">
			<div class="col-2 pe-2 border-end border-1"></div>
			<div class="col pe-2 border-end border-1">
				<textarea id="mate_comment_updateContent" name="mate_comment_content" class="form-control"></textarea>
			</div>
			<div class="col-1 text-center position-relative">
				<button class="btn btn-primary btn-sm position-absolute start-50 top-50 translate-middle">수정</button>
			</div>
			<div class="col-1 text-center position-relative">
				<button class="btn btn-outline-danger btn-sm position-absolute start-50 top-50 translate-middle">취소</button>
			</div>
		</div>
	</li>
	
	
	<!--============================ UI 복사용 / hidden 끝 =========================================-->
	<!--============================ Toast =========================================-->
	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 5">
		<div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
			<div class="toast-header">
				<i class="bi bi-star-fill fs-6 me-2 text-warning"></i>
				<strong class="me-auto">찜목록</strong>
				<small></small>
				<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
			<div class="toast-body">
				<span id="toast_boay_span"></span>
			</div>
		</div>
	</div>
	
	<div id="toast_container" class="toast-container">
	</div>
	<!--============================ Toast 끝 =========================================-->
	<!--============================ Modal =========================================-->
	<div class="modal fade" id="applyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">메이트 신청</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row mt-2 pb-2 border-bottom border-1">
						<div id="mate_read_content_form" class="col-9 border border-1 py-3 me-1">
							<p id="mate_read_content">
								${oneMateContent.mateFreeboardVO.mate_freeboard_content }
							</p>
						</div>
						<div class="col py-3 px-0 border border-1">
							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									낚시종류 - ${oneMateContent.fishingCategoryVO.fishing_category_name }
								</li>
								<li class="list-group-item">
									낚시터 위치 - <br>
									<small>
										(도로명)<br>
										${oneMateContent.mateFreeboardVO.mate_freeboard_roadAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress }<br>
									</small>
								</li>
								<li class="list-group-item">
									<small>
										(지번)<br>
										${oneMateContent.mateFreeboardVO.mate_freeboard_jibunAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress }
										${oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress }
									</small>
								</li>
								<li class="list-group-item">
									낚시 일정<br>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_startdate}"/> ~ 
									<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_enddate}"/>
								</li>
							</ul>
						</div>
						<div id="mate_content_form" class="row mt-3 pb-2">
							<div class="row px-0 d-grid">
								<div class="col d-grid text-center ms-3">
									<textarea class="form-control" id="mate_content" name="mate_content" placeholder="요구사항과 간단한 자기소개를 입력하세요"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="mateApplyGroupProcess()">신청</button>
						<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!--============================ Modal 끝 =========================================-->

	<div style="width: 100%; margin: 0 auto;">
		<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
		<!-- 푸터 끝 -->
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>