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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/matePage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/font.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">

	var mate_category_no = 0;
	var fishing_category_no = 0;
	var region_category_no = 0;
	var pageNum = 1;
	
	//------------ 카테고리 선택 시 no 적용 - 형준 --------------
	//지역 카테고리 값 적용 - 형준
	function setRegionCategoryNo() {
		var select_region_category = document.getElementById("select_region_category");
		region_category_no = select_region_category.options[select_region_category.selectedIndex].value;
		
		getAllMateContent(mate_category_no, fishing_category_no, region_category_no, 1);
	}
	
	//모집 분류 카테고리 값 적용 - 형준
	function setMateCategoryNo() {
		var select_mate_category = document.getElementById("select_mate_category"); 
		mate_category_no = select_mate_category.options[select_mate_category.selectedIndex].value;
		
		getAllMateContent(mate_category_no, fishing_category_no, region_category_no, 1);
	}
	
	//------------ 카테고리 선택 시 no 적용 끝 --------------
	//------------ 페이징 Num 적용 시작 - 형준 --------------
	function setPageNum(num) {
		pageNum = num;
		
		getAllMateContent(mate_category_no, fishing_category_no, region_category_no, pageNum);
	}
	
	
	//------------ 페이징 Num 적용 끝 --------------

	function readThisContent(mate_freeboard_no){
		location.href = "${pageContext.request.contextPath}/mate/mateReadContentPage.do?mate_freeboard_no=" + mate_freeboard_no;
	}
	
	//메이트 글목록 불러오기 - 형준
	function getAllMateContent(mate_category_no, fishing_category_no, region_category_no, pageNum) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var mateAllContentCount = document.getElementById("mateAllContentCount");
				mateAllContentCount.innerText = "▷ 총 "+obj.contentCount +"개의 글이 있습니다.";
					
				
				var mate_card_list = document.getElementById("mate_card_list");
				mate_card_list.innerText = "";
				
				var pagination_box = document.getElementById("pagination_box");
				pagination_box.innerText = "";
				
				//글목록 카드 부분
				for(var mateContentList of obj.mateContentList){
					
					var mateContentColBox = document.createElement("div");
					mateContentColBox.setAttribute("class", "col-4 mb-3");
					mateContentColBox.setAttribute("onclick", "readThisContent(" + mateContentList.mateFreeboardVO.mate_freeboard_no + ")");
					
					var mateContentCardBox = document.createElement("div");
					mateContentCardBox.setAttribute("id", "mate_cards");
					mateContentCardBox.setAttribute("class", "card");
					
					//카드 헤더부분
					var mateContentCardHeader = document.createElement("div");
					mateContentCardHeader.setAttribute("class", "card-header");
					
					var mateContentStatus = document.createElement("p");
					mateContentStatus.setAttribute("class", "text-center m-0");
					mateContentStatus.innerText = mateContentList.mateCategoryVO.mate_category_name + "(" + mateContentList.confirmGroupCount + "/" + mateContentList.mateFreeboardVO.mate_freeboard_maxnumber + ")";
					mateContentCardHeader.appendChild(mateContentStatus);
					mateContentCardBox.appendChild(mateContentCardHeader);
					
					//카드 이미지 부분
					var mateContentImg = document.createElement("img");
					
					if(mateContentList.mateFreeboardImageVO != null){
						mateContentImg.setAttribute("src", "/upload_files/" + mateContentList.mateFreeboardImageVO.image_location);
						mateContentImg.setAttribute("onerror", "this.src='${pageContext.request.contextPath}/resources/img/noimage.gif'");
					} else {
						mateContentImg.setAttribute("src", "${pageContext.request.contextPath}/resources/img/noimage.gif");
					}
					
					mateContentImg.setAttribute("class", "card-img-top");
					mateContentCardBox.appendChild(mateContentImg);
					
					//카드 바디부분
					var mateContentCardBody = document.createElement("div");
					mateContentCardBody.setAttribute("class", "card-body");
					
					var mateContentTitle = document.createElement("h5");
					mateContentTitle.setAttribute("class", "card-title fw-bold text-truncate");
					mateContentTitle.innerText = mateContentList.mateFreeboardVO.mate_freeboard_title;
					
					var mateContentTitleSmall = document.createElement("small");
					mateContentTitleSmall.innerText = "(" + mateContentList.commentCount + ")";
					mateContentTitle.appendChild(mateContentTitleSmall);
					mateContentCardBody.appendChild(mateContentTitle);
					
					var mateContentFishinghole = document.createElement("p");
					mateContentFishinghole.setAttribute("class", "card-text");
					mateContentFishinghole.innerText = 
						"낚시터명 - " + mateContentList.mateFreeboardVO.mate_freeboard_fishingholename + "\n" +
						"분류/지역 - " + mateContentList.fishingCategoryVO.fishing_category_name + "/" + mateContentList.regionCategoryVO.region_category_name;
					mateContentCardBody.appendChild(mateContentFishinghole);
					
					var mateContentDetail = document.createElement("p");
					mateContentDetail.setAttribute("class", "cart-text mb-0");
					
					var mateContentDetailSmall = document.createElement("small");
					var mateContentDetailSmallWriter = document.createElement("small");
					var writerIcon = document.createElement("i");
					writerIcon.setAttribute("class", "bi bi-person-fill");
					
					var mate_freeboard_startdate = new Date(mateContentList.mateFreeboardVO.mate_freeboard_startdate);
					var mate_freeboard_enddate = new Date(mateContentList.mateFreeboardVO.mate_freeboard_enddate);
					mateContentDetailSmall.innerText = 
						"일정 " + (mate_freeboard_startdate.getFullYear()).toString().substr(2, 4) + "/" + 
						(mate_freeboard_startdate.getMonth()+1 > 9 ? mate_freeboard_startdate.getMonth()+1 : "0" + (mate_freeboard_startdate.getMonth()+1)) + "/" +
						(mate_freeboard_startdate.getDate() > 9 ? mate_freeboard_startdate.getDate() : "0" + (mate_freeboard_startdate.getDate())) + " ~ " + 
						(mate_freeboard_enddate.getFullYear()).toString().substr(2, 4) + "/" + 
						(mate_freeboard_enddate.getMonth()+1 > 9 ? mate_freeboard_enddate.getMonth()+1 : "0" + (mate_freeboard_enddate.getMonth()+1)) + "/" +
						(mate_freeboard_enddate.getDate() > 9 ? mate_freeboard_enddate.getDate() : "0" + (mate_freeboard_enddate.getDate())) + "\n현재 신청인원 " + mateContentList.applyGroupCount + "명\n";
					
					mateContentDetailSmallWriter.innerText = " " + mateContentList.member_nick;
					
					mateContentDetail.appendChild(mateContentDetailSmall);
					mateContentDetail.appendChild(writerIcon);
					mateContentDetail.appendChild(mateContentDetailSmallWriter);
					mateContentCardBody.appendChild(mateContentDetail);
					mateContentCardBox.appendChild(mateContentCardBody);
					
					//카드 ul - 조회수&추천수 부분
					var mateContentCardBodyUl = document.createElement("ul");
					mateContentCardBodyUl.setAttribute("class", "list-group list-group-flush");
					
					var mateContentCardBodyLi = document.createElement("li");
					mateContentCardBodyLi.setAttribute("class", "list-group-item");
					
					var mateSpanSmallBox1 = document.createElement("small");
					var mateSpanSmallBox2 = document.createElement("small");
					mateSpanSmallBox2.setAttribute("class", "float-end");
					
					var mateSpanIntoLi1 = document.createElement("span");
					var mateSpanIntoLi2 = document.createElement("span");
					
					var mateReadCountImage = document.createElement("i");
					mateReadCountImage.setAttribute("class", "bi bi-emoji-smile me-1");
					
					mateSpanIntoLi1.innerText = "조회 " + mateContentList.mateFreeboardVO.mate_freeboard_readcount;
					
					mateSpanSmallBox1.appendChild(mateReadCountImage);
					mateSpanSmallBox1.appendChild(mateSpanIntoLi1);
					
					var mate_write_date = new Date(mateContentList.mateFreeboardVO.mate_freeboard_writedate);
					
					mateSpanIntoLi2.innerText = 
						(mate_write_date.getFullYear()).toString().substr(2, 4) + "/" + 
						(mate_write_date.getMonth()+1 > 9 ? mate_write_date.getMonth()+1 : "0" + (mate_write_date.getMonth()+1)) + "/" +
						(mate_write_date.getDate() > 9 ? mate_write_date.getDate() : "0" + (mate_write_date.getDate()));
					
					mateSpanSmallBox2.appendChild(mateSpanIntoLi2);
					
					mateContentCardBodyLi.appendChild(mateSpanSmallBox1);
					mateContentCardBodyLi.appendChild(mateSpanSmallBox2);
					mateContentCardBodyUl.appendChild(mateContentCardBodyLi);
					
					mateContentCardBox.appendChild(mateContentCardBodyUl);
					mateContentColBox.appendChild(mateContentCardBox);
					mate_card_list.appendChild(mateContentColBox);
				}
				
				//글목록 페이징
				var paginationLi = document.createElement("li");
				if (obj.beginPage <= 1) {
					paginationLi.setAttribute("class", "page-item disabled");
				} else {
					paginationLi.setAttribute("class", "page-item");
					paginationLi.setAttribute("onclick", "setPageNum(" + (obj.beginPage-1) + ")");
				}
				var paginationATag = document.createElement("a");
				paginationATag.setAttribute("class", "page-link");
				paginationATag.setAttribute("aria-label", "Previous");
				
				var paginationPreBtn = document.createElement("i");
				paginationPreBtn.setAttribute("class", "bi bi-chevron-left");
				paginationATag.appendChild(paginationPreBtn);
				paginationLi.appendChild(paginationATag);
				pagination_box.appendChild(paginationLi);
				
				for(var i = obj.beginPage; i <= obj.endPage; i++){
					
					var paginationLi = document.createElement("li");
					
					if (obj.currentPage == i) {
						paginationLi.setAttribute("class", "page-item active");
						paginationLi.setAttribute("onclick", "setPageNum(" + i + ")");
					} else {
						paginationLi.setAttribute("class", "page-item");
						paginationLi.setAttribute("onclick", "setPageNum(" + i + ")");
					}
					
					var paginationATag = document.createElement("a");
					paginationATag.setAttribute("class", "page-link");
					paginationATag.innerText = i;
					paginationLi.appendChild(paginationATag);
					
					
					pagination_box.appendChild(paginationLi);
				}
				
				var paginationLi = document.createElement("li");
				if (obj.endPage >= obj.totalPageCount) {
					paginationLi.setAttribute("class", "page-item disabled");
				} else {
					paginationLi.setAttribute("class", "page-item");
					paginationLi.setAttribute("onclick", "setPageNum(" + (obj.endPage+1) + ")");
				}
				var paginationATag = document.createElement("a");
				paginationATag.setAttribute("class", "page-link");
				paginationATag.setAttribute("aria-label", "Next");
				
				var paginationNextBtn = document.createElement("i");
				paginationNextBtn.setAttribute("class", "bi bi-chevron-right");
				paginationATag.appendChild(paginationNextBtn);
				paginationLi.appendChild(paginationATag);
				pagination_box.appendChild(paginationLi);
				
				}
			}
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/getAllMateContent.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("mate_category_no=" + mate_category_no + "&fishing_category_no=" + fishing_category_no + "&region_category_no=" + region_category_no + "&pageNum=" + pageNum);
	}
	
	//메이트 카테고리 목록 불러오기 - 형준
	function getMateCategoryList() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var select_mate_category = document.getElementById("select_mate_category");
				select_mate_category.innerText = "";
				
				var mateFirstOption = document.createElement("option");
				mateFirstOption.setAttribute("selected", "selected");
				mateFirstOption.setAttribute("value", "0");
				mateFirstOption.innerText = "모집 분류";
				select_mate_category.appendChild(mateFirstOption);
				
				for(var mateCategoryList of obj){
					var mateOption = document.createElement("option");
					mateOption.setAttribute("value", mateCategoryList.mate_category_no);
					mateOption.innerText = mateCategoryList.mate_category_name;
					select_mate_category.appendChild(mateOption);
				}
				
			}
		}
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getMateCategoryList.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//낚시 종류에 따른 지역 카테고리 목록 불러오기 - 형준
	function getRegionCategoryList() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		var select_fishing = document.getElementById("select_fishing_category");
		fishing_category_no = select_fishing.options[select_fishing.selectedIndex].value;
		var select_fishing_value = select_fishing.options[select_fishing.selectedIndex].value;
		
		if(select_fishing.selectedIndex == 0){
			var select_region_category = document.getElementById("select_region_category");
			select_region_category.innerText = "";
			
			var regionFirstOption = document.createElement("option");
			regionFirstOption.setAttribute("selected", "selected");
			regionFirstOption.innerText = "지역";
			select_region_category.appendChild(regionFirstOption);
			
			return;
		}
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				getAllMateContent(mate_category_no, fishing_category_no, region_category_no, 1);
				
				var select_region_category = document.getElementById("select_region_category");
				select_region_category.innerText = "";
				
				var regionFirstOption = document.createElement("option");
				regionFirstOption.setAttribute("selected", "selected");
				regionFirstOption.setAttribute("value", "0");
				regionFirstOption.innerText = "지역";
				select_region_category.appendChild(regionFirstOption);
				
				for(var regionList of obj.regionListVO){
					
					var regionOption = document.createElement("option");
					regionOption.setAttribute("value", regionList.region_category_no);
					regionOption.innerText = regionList.region_category_name;
					select_region_category.appendChild(regionOption);
				}
				
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getRegionCategoryList.do?select_fishing_value=" + select_fishing_value, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//전체 버튼 클릭 시 초기화 - 형준
	function setDefaultNo(mateCategoryNo, fishingCategoryNo, regionCategoryNo, pageDefaultNum) {
		mate_category_no = mateCategoryNo;
		fishing_category_no = fishingCategoryNo;
		region_category_no = regionCategoryNo;
		pageNum = pageDefaultNum;
		
		var select_fishing_category = document.getElementById("select_fishing_category");
		select_fishing_category.selectedIndex = 0;
		
		var select_region_category = document.getElementById("select_region_category");
		select_region_category.selectedIndex = 0;
		
		var select_mate_category = document.getElementById("select_mate_category");
		select_mate_category.selectedIndex = 0;
		
		
		getAllMateContent(mate_category_no, fishing_category_no, region_category_no, pageNum);
	}
	
	function init() {
		getMateCategoryList();
		getAllMateContent(mate_category_no, fishing_category_no, region_category_no, pageNum);
	}
	
</script>
</head>
<body onload="init()">
	<div style="width: 1200px; margin: 0 auto;">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
		<div class="container-fluid my-4">
			<div class="row">
				<div class="col border-end border-1">
					<!-- 사이드 시작 -->
						<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
					<!-- 사이드 끝 -->
				</div>
				<div class="col-10">
					<div class="row">
						<div class="col-1"></div>
						<div class="col">
							<span class="fs-2 fw-bold">메이트 게시판</span>
						</div>
					</div>
					<div class="row my-3">
						<div class="col-1"></div>
						<div class="col-1 d-grid">
							<button class="btn btn-outline-primary" onclick="setDefaultNo(0, 0, 0, 1)">전체</button>
						</div>
						<div class="col-2 d-grid me-0">
							<select class="form-select border border-1" id="select_fishing_category" name="fishing_category_no" onchange="getRegionCategoryList()" aria-label="Default select example">
								<option value="0" selected>낚시 종류</option>
								<c:forEach items="${fishingList }" var="fishing">
									<option value="${fishing.fishing_category_no }">${fishing.fishing_category_name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-2 d-grid">
							<select class="form-select border border-1" id="select_region_category" name="region_category_no" onchange="setRegionCategoryNo()" aria-label="Default select example">
								<option selected>지역</option>
							</select>
						</div>
						<div class="col-2 d-grid btn-group">
							<select class="form-select border border-1" id="select_mate_category" name="mate_category_no" onchange="setMateCategoryNo()">
								<option selected>모집 분류</option>
							</select>
						</div>
					</div>
					<div class="row mb-0 pb-2 mb-3">
						<div class="col-1"></div>
						<div class="col border-bottom border-3 pb-2">
							<span id="mateAllContentCount"></span>
						</div>
					</div>
					<div class="row">
						<div class="col-1"></div>
						<div class="col">
							<div id="mate_card_list" class="row align-items-start me-1"></div>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col-1"></div>
						<div class="col-2 border-top border-3 pt-3"></div>
						<div class="col border-top border-3 pt-3">
							<nav aria-label="Page navigation example">
								<ul id="pagination_box" class="pagination justify-content-center">
									<li class="page-item">
										<a class="page-link" href="#" aria-label="Previous">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</li>
									<li class="page-item">
									<a class="page-link" href="#" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
									</li>
								</ul>
							</nav>
						</div>
						
						<div class="col-2 border-top border-3 pt-3" >
								<c:if test="${! empty sessionUser  }">
								  <a href="${pageContext.request.contextPath}/mate/mateWriteContentPage.do" style="text-decoration:none;color:black; font-size:20px; " class="btn btn-writeBtn"><i class="bi bi-pencil-square"></i>&nbsp;글쓰기</a>
								</c:if>
				        </div>
						</div>
					
					<div class="row mb-3 mt-3">
						<div class="col-2 me-5"></div>
						<div class="col-8 text-center">
							<form class="row">
								<div class="col-2 d-grid btn-group">
									<button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
										선택
									</button>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#">제목</a></li>
										<li><a class="dropdown-item" href="#">제목+내용</a></li>
										<li><a class="dropdown-item" href="#">작성자</a></li>
									</ul>
								</div>
								<div class="col">
									<input class="form-control" type="text">
								</div>
								<div class="col-2 pe-2 d-grid">
									<input class="btn btn-primary" type="submit" value="검색">
								</div>
							</form>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>