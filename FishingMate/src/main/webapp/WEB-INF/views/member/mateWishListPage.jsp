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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateWishListPage.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">
	var sessionMemberNo = null;
	var wishContentModal = null;
	
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
	
	//메이트 찜목록 불러오기 - 형준
	function getMateWishList() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				console.log(sessionMemberNo);
				
				var mate_wish_list = document.getElementById("mate_wishlist");
				mate_wish_list.innerText = "";
				
				var mate_wishlist_first = document.getElementById("mate_wishlist_first");
				var mateWishListFirstLi = mate_wishlist_first.cloneNode(true);
				mateWishListFirstLi.setAttribute("class", "list-group-item");
				mate_wish_list.appendChild(mateWishListFirstLi);
				
				for(var wishList of obj.mateWishList){
					
					var mateWishListLiBox = document.createElement("li");
					mateWishListLiBox.setAttribute("class", "list-group-item");
					
					var mateWishListRowBox = document.createElement("div");
					mateWishListRowBox.setAttribute("class", "row");
					
					var mateStatusColBox = document.createElement("div");
					mateStatusColBox.setAttribute("class", "col-1 border-end border-1 text-center");
					mateStatusColBox.innerText = wishList.mateCategoryVO.mate_category_name;
					mateWishListRowBox.appendChild(mateStatusColBox);
					
					var mateCategoryColBox = document.createElement("div");
					mateCategoryColBox.setAttribute("class", "col-2 border-end border-1 text-center");
					mateCategoryColBox.innerText = wishList.fishingCategoryVO.fishing_category_name + "/" + wishList.regionCategoryVO.region_category_name;
					mateWishListRowBox.appendChild(mateCategoryColBox);
					
					var mateTitleColBox = document.createElement("div");
					mateTitleColBox.setAttribute("class", "col border-end border-1");
					
					var mateTitleSpanBox = document.createElement("span");
					mateTitleSpanBox.setAttribute("id", "mateTitleSpanBox");
					mateTitleSpanBox.setAttribute("onclick", "openWishContentModal(" + wishList.mateFreeboardVO.mate_freeboard_no + ")");
					mateTitleSpanBox.innerText = wishList.mateFreeboardVO.mate_freeboard_title;
					
					var mateTitleCommentCountBox = document.createElement("small");
					mateTitleCommentCountBox.innerText = "(" + wishList.commentCount + ")";
					mateTitleSpanBox.appendChild(mateTitleCommentCountBox);
					mateTitleColBox.appendChild(mateTitleSpanBox);
					mateWishListRowBox.appendChild(mateTitleColBox);
					
					var mateWriterColBox = document.createElement("div");
					mateWriterColBox.setAttribute("class", "col-2 border-end border-1 text-center");
					mateWriterColBox.innerText = wishList.member_nick;
					mateWishListRowBox.appendChild(mateWriterColBox);
					
					var matePeriodColBox = document.createElement("div");
					matePeriodColBox.setAttribute("class", "col-2 text-center pe-0");
					var mateStartDate = new Date(wishList.mateFreeboardVO.mate_freeboard_startdate);
					var mateEndDate = new Date(wishList.mateFreeboardVO.mate_freeboard_enddate);
					matePeriodColBox.innerText = 
						(mateStartDate.getFullYear()).toString().substr(2, 4) + "/" + 
						(mateStartDate.getMonth() + 1 > 9 ? mateStartDate.getMonth() + 1 : "0" + (mateStartDate.getMonth() + 1)) + "/" +
						(mateStartDate.getDate() > 9 ? mateStartDate.getDate() : "0" + mateStartDate.getDate()) + " ~ " + 
						(mateEndDate.getFullYear()).toString().substr(2, 4) + "/" + 
						(mateEndDate.getMonth() + 1 > 9 ? mateEndDate.getMonth() + 1 : "0" + (mateEndDate.getMonth() + 1)) + "/" +
						(mateEndDate.getDate() > 9 ? mateEndDate.getDate() : "0" + mateEndDate.getDate());
					mateWishListRowBox.appendChild(matePeriodColBox);
					
					mateWishListLiBox.appendChild(mateWishListRowBox);
					mate_wish_list.appendChild(mateWishListLiBox);
				}
				
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getMateWishList.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		
	}
	
	//찜목록 게시글 클릭 시 게시글 내용 Modal로 Open - 형준
	function openWishContentModal(mate_freeboard_no) {
		wishContentModal = new bootstrap.Modal(document.getElementById("wishContentModal"));
		wishContentModal.show();
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				//게시글 제목 영역
				var mate_freeboard_title = document.getElementById("mate_freeboard_title");
				mate_freeboard_title.innerText = obj.oneMateContent.mateFreeboardVO.mate_freeboard_title;
				
				var title_sub_memberNick = document.getElementById("title_sub_memberNick");
				title_sub_memberNick.innerText = obj.member_nick;
				
				var title_sub_readcount = document.getElementById("title_sub_readcount");
				title_sub_readcount.innerText = obj.oneMateContent.mateFreeboardVO.mate_freeboard_readcount;

				var recommendCountBox = document.getElementById("recommendCountBox");
				recommendCountBox.innerText = obj.recommedCount;
				
				var title_sub_periodDate = document.getElementById("title_sub_periodDate");
				var mate_freeboard_writedate = new Date(obj.oneMateContent.mateFreeboardVO.mate_freeboard_writedate);
				title_sub_periodDate.innerText =
					mate_freeboard_writedate.getFullYear() + "-" +
					(mate_freeboard_writedate.getMonth() + 1 > 9 ? mate_freeboard_writedate.getMonth() + 1 : "0" + (mate_freeboard_writedate.getMonth() + 1)) + "-" + 
					(mate_freeboard_writedate.getDate() > 9 ? mate_freeboard_writedate.getDate() : "0" + mate_freeboard_writedate.getDate());
				
				//게시글 사진 영역
				var carousel_indicators = document.getElementById("carousel_indicators");
				carousel_indicators.innerText = "";
				for(var i=0; i < obj.imgSize; i++){
					var carousel_indicators_btn = document.createElement("button");
					carousel_indicators_btn.setAttribute("data-bs-target", "#carouselExampleIndicators");
					carousel_indicators_btn.setAttribute("data-bs-slide-to", i);
					carousel_indicators_btn.setAttribute("class", "active");
					carousel_indicators_btn.setAttribute("aria-current", "true");
					carousel_indicators_btn.setAttribute("aria-label", "Slide 1");
					carousel_indicators.appendChild(carousel_indicators_btn);
				}
				
				var carousel_inner = document.getElementById("carousel_inner");
				carousel_inner.innerText = "";
				if (obj.oneMateContent.mateFreeboardImageVOList.length == 0) {
					var carouselItemDivBox = document.createElement("div");
					   carouselItemDivBox.setAttribute("class", "carousel-item active");
					   
					   var carouselItemImg = document.createElement("img");
					   carouselItemImg.setAttribute("id", "mate_read_thumnail");
					   carouselItemImg.setAttribute("src", "${pageContext.request.contextPath}/resources/img/noimage.gif");
					   carouselItemImg.setAttribute("class", "d-block w-100");
					   carouselItemDivBox.appendChild(carouselItemImg);
					   carousel_inner.appendChild(carouselItemDivBox);
				}
				
				obj.oneMateContent.mateFreeboardImageVOList.forEach((images, index) => {
				   if(index == 0){
					   var carouselItemDivBox = document.createElement("div");
					   carouselItemDivBox.setAttribute("class", "carousel-item active");
					   
					   var carouselItemImg = document.createElement("img");
					   carouselItemImg.setAttribute("id", "mate_read_thumnail");
					   carouselItemImg.setAttribute("src", "/upload_files/" + images.image_location);
					   carouselItemImg.setAttribute("class", "d-block w-100");
					   carouselItemDivBox.appendChild(carouselItemImg);
					   carousel_inner.appendChild(carouselItemDivBox);
				   } else {
					   var carouselItemDivBox = document.createElement("div");
					   carouselItemDivBox.setAttribute("class", "carousel-item");
					   
					   var carouselItemImg = document.createElement("img");
					   carouselItemImg.setAttribute("id", "mate_read_thumnail");
					   carouselItemImg.setAttribute("src", "/upload_files/" + images.image_location);
					   carouselItemImg.setAttribute("class", "d-block w-100");
					   carouselItemDivBox.appendChild(carouselItemImg);
					   carousel_inner.appendChild(carouselItemDivBox);
				   }
				   
				});
				
				//게시글 정보 영역
				var confirm_count = document.getElementById("confirm_count");
				confirm_count.innerText = obj.oneMateContent.confirmGroupCount + "/" + obj.oneMateContent.mateFreeboardVO.mate_freeboard_maxnumber;
				
				var apply_count = document.getElementById("apply_count");
				apply_count.innerText = obj.oneMateContent.applyGroupCount;
				
				var mate_freeboard_fishing = document.getElementById("mate_freeboard_fishing");
				mate_freeboard_fishing.innerText = obj.oneMateContent.fishingCategoryVO.fishing_category_name;
				
				var mate_freeboard_roadAddr = document.getElementById("mate_freeboard_roadAddr");
				var detailAddress = "";
				if (obj.oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress != null) {
					detailAddress = obj.oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress;
				}
				mate_freeboard_roadAddr.innerText = 
					obj.oneMateContent.mateFreeboardVO.mate_freeboard_roadAddress + 
					detailAddress + 
					obj.oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress;
				
				var mate_freeboard_jibunAddr = document.getElementById("mate_freeboard_jibunAddr");
				mate_freeboard_jibunAddr.innerText = 
					obj.oneMateContent.mateFreeboardVO.mate_freeboard_jibunAddress + 
					detailAddress + 
					obj.oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress;
				
				var mate_freeboard_periodDate = document.getElementById("mate_freeboard_periodDate");
				var mateStartDate = new Date(obj.oneMateContent.mateFreeboardVO.mate_freeboard_startdate);
				var mateEndDate = new Date(obj.oneMateContent.mateFreeboardVO.mate_freeboard_enddate);
				mate_freeboard_periodDate.innerText = 
					mateStartDate.getFullYear() + "/" + 
					(mateStartDate.getMonth() + 1 > 9 ? mateStartDate.getMonth() + 1 : "0" + (mateStartDate.getMonth() + 1)) + "/" +
					(mateStartDate.getDate() > 9 ? mateStartDate.getDate() : "0" + mateStartDate.getDate()) + " ~ " + 
					mateEndDate.getFullYear() + "/" + 
					(mateEndDate.getMonth() + 1 > 9 ? mateEndDate.getMonth() + 1 : "0" + (mateEndDate.getMonth() + 1)) + "/" +
					(mateEndDate.getDate() > 9 ? mateEndDate.getDate() : "0" + mateEndDate.getDate());
				
				var mate_status_box = document.getElementById("mate_status_box");
				mate_status_box.innerText = "";
				var mateStatusBtn = document.createElement("button");
				mateStatusBtn.setAttribute("disabled", "disabled");
				if (obj.oneMateContent.mateCategoryVO.mate_category_no == 3) {
					mateStatusBtn.setAttribute("class", "btn btn-lg btn-outline-danger d-grid")
				} else {
					mateStatusBtn.setAttribute("class", "btn btn-lg btn-outline-primary d-grid")
				}
				mateStatusBtn.innerText = obj.oneMateContent.mateCategoryVO.mate_category_name;
				mate_status_box.appendChild(mateStatusBtn);
				
				var mate_apply_button = document.getElementById("mate_apply_button");
				mate_apply_button.innerText = "";
				var mateApplyBtn = document.createElement("button");
				mateApplyBtn.setAttribute("class", "btn btn-primary btn-lg d-grid");
				mateApplyBtn.setAttribute("disabled", "disabled");
				
				if(obj.oneMateContent.mate_confirm_no != 0 && obj.oneMateContent.mateCategoryVO.mate_category_no == 2){
					var mateApplyBtn = document.createElement("a");
					mateApplyBtn.setAttribute("class", "btn btn-primary btn-lg d-grid");
					mateApplyBtn.setAttribute("href", "${pageContext.request.contextPath }/mate/mateConfirmGroupPage.do?mate_freeboard_no=" + obj.oneMateContent.mateFreeboardVO.mate_freeboard_no);
					mateApplyBtn.innerText = "명단확인";
				} else if(obj.oneMateContent.mateCategoryVO.mate_category_no == 2){
					mateApplyBtn.innerText = "종료";
				} else if(obj.oneMateContent.mateCategoryVO.mate_category_no == 3){
					mateApplyBtn.innerText = "취소";
				} else if(obj.chkApplyGroup == 0) {
					var mateApplyBtn = document.createElement("a");
					mateApplyBtn.setAttribute("class", "btn btn-primary btn-lg d-grid");
					mateApplyBtn.setAttribute("href", "${pageContext.request.contextPath }/mate/mateReadContentPage.do?mate_freeboard_no=" + obj.oneMateContent.mateFreeboardVO.mate_freeboard_no);
					mateApplyBtn.innerText = "페이지 이동 후 신청";
				} else if(obj.chkApplyGroup != 0){
					mateApplyBtn.innerText = "신청완료";
				}
				
				mate_apply_button.appendChild(mateApplyBtn);
				
				//게시글 내용 영역
				var mate_read_content = document.getElementById("mate_read_content");
				mate_read_content.innerText = obj.oneMateContent.mateFreeboardVO.mate_freeboard_content;
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getMateOneWishListContent.do?mate_freeboard_no=" + mate_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	function init() {
		getSessionMemberNo();
		getMateWishList();
	}
	
</script>
</head>
<body onload="init()">

	<div style="width: 1200px; margin: 0 auto;">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
	
		<div class="container-fluid">
			<div class="row border-bottom border-2 pb-2 mb-3">
				<div class="col text-center">
					<span id="updatefestivM">
					<img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70">
					메이트 찜목록
					</span>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/member/myPageTop.jsp" />
			<div class="row">
				<div class="col">
					<ul id="mate_wishlist" class="list-group list-group-flush border-top border-bottom border-1 my-3"></ul>
				</div>
			</div>
		</div>
	</div>
	
	<!--============================ UI 복사용 / hidden 시작 =========================================-->
	<li id="mate_wishlist_first" class="list-group-item visually-hidden">
		<div class="row">
			<div class="col-1 border-end border-1 text-center fw-bold">
				상태
			</div>
			<div class="col-2 border-end border-1 text-center fw-bold">
				낚시종류/장소
			</div>
			<div class="col border-end border-1 fw-bold">
				제목
			</div>
			<div class="col-2 border-end border-1 text-center fw-bold">
				작성자
			</div>
			<div class="col-2 text-center fw-bold">
				날짜
			</div>
		</div>
	</li>

	<!--============================ UI 복사용 / hidden 끝 =========================================-->
	<!--============================ Modal =========================================-->
	<div class="modal fade" id="wishContentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row mb-4 border-bottom border-2">
						<div class="col-7">
							<p id="mate_freeboard_title" class="h2 pb-2 ps-2 mt-2">${oneMateContent.mateFreeboardVO.mate_freeboard_title }</p>
						</div>
						<div class="col position-relative">
							<span class="position-absolute top-50 end-0 translate-middle-y">
							<small id="mate_freeboard_title_sub">
								<span id="title_sub_memberNick" class="fw-bold">${oneMateContent.memberVO.member_nick }</span>&nbsp;&nbsp;|&nbsp;
								조회수&nbsp;<span id="title_sub_readcount"></span>&nbsp;&nbsp;|&nbsp;
								추천수&nbsp;<span id="recommendCountBox"></span>&nbsp;&nbsp;|&nbsp;
								<span id="title_sub_periodDate"></span>
							</small>
							</span>
						</div>
					</div>
					<div class="row">
						<div class="col-9 p-3 border border-1 me-1 text-center">
							<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
								<div id="carousel_indicators" class="carousel-indicators"></div>
								<div id="carousel_inner" class="carousel-inner"></div>
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
								<li id="mate_freeboard_count" class="list-group-item">
									모집인원 - <span id="confirm_count"></span>명<br>
									<small>
										(현재 신청인원 <span id="apply_count"></span>명)
									</small>
								</li>
								<li class="list-group-item">
									낚시종류 - <span id="mate_freeboard_fishing"></span>
								</li>
								<li class="list-group-item">
									낚시터 위치 - <br>
									<small>
										(도로명)<br>
										<span id="mate_freeboard_roadAddr"></span><br>
									</small>
								</li>
								<li class="list-group-item">
									<small>
										(지번)<br>
										<span id="mate_freeboard_jibunAddr"></span>
									</small>
								</li>
								<li class="list-group-item">
									낚시 일정<br>
									<span id="mate_freeboard_periodDate"></span>
								</li>
							</ul>
							<div class="row d-flex flex-column align-items-end">
								<div class="col">
									<span id="mate_status_box" class="mt-2 py-2 d-grid"></span>
								</div>
								<div class="col">
									<span id="mate_apply_button" class="mt-2 d-grid"></span>
								</div>
							</div>
						</div> 
					</div>
					<div class="row mt-2">
						<div class="col border border-1 py-3">
							<p id="mate_read_content"></p>
						</div>
					</div>
				</div>
				<div class="modal-footer">
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