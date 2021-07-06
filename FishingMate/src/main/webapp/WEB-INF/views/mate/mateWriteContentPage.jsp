<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/execDaumPostcode.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateWriteContentPage.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">

	//낚시 종류에 따른 지역 카테고리 호출 - 형준
	function getRegionCategoryList() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		var select_fishing = document.getElementById("select_fishing_category");
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
				
				var select_region_category = document.getElementById("select_region_category");
				select_region_category.innerText = "";
				
				var regionFirstOption = document.createElement("option");
				regionFirstOption.setAttribute("selected", "selected");
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
	
	//글쓰기 예외 처리 - 형준
	function mateWriteContentProcess() {
		
		var mate_freeboard_frm = document.getElementById("mate_freeboard_frm");
		
		//제목 예외처리
		var mate_freeboard_title = document.getElementById("floatingInput");
		if (mate_freeboard_title.value == "") {
			alert("제목을 입력하세요");
			mate_freeboard_title.focus();
			return false;
		}
		
		//조건 예외처리
		var select_fishing_category = document.getElementById("select_fishing_category");
		if (select_fishing_category.selectedIndex == 0) {
			alert("낚시 종류를 선택하세요");
			select_fishing_category.focus();
			return false;
		}
		
		var select_region_category = document.getElementById("select_region_category");
		if(select_region_category.selectedIndex == 0){
			alert("지역을 선택하세요");
			select_region_category.focus();
			return false;
		}
		
		//인원 선택 예외처리
		var mate_freeboard_maxnumber = document.getElementById("mate_freeboard_maxnumber");
		if(mate_freeboard_maxnumber.selectedIndex == 0){
			alert("인원수를 선택하세요");
			mate_freeboard_maxnumber.focus();
			return false;
		}
		
		//낚시터명 예외처리
		var mate_freeboard_fishingholename = document.getElementById("mate_freeboard_fishingholename");
		if (mate_freeboard_fishingholename.value == "") {
			alert("낚시터명을 입력하세요");
			mate_freeboard_fishingholename.focus();
			return false;
		}
		
		//주소 예외처리
		var sample4_postcode = document.getElementById("sample4_postcode");
		if(sample4_postcode.value == ""){
			alert("주소를 입력하세요");
			sample4_postcode.focus();
			return false;
		}
		
		//날짜 예외처리
		var mate_freeboard_startdate = document.getElementById("mate_freeboard_startdate");
		if (mate_freeboard_startdate.value == "") {
			alert("시작날짜를 입력하세요");
			mate_freeboard_startdate.focus();
			return false;
		} else {
			if (!chkStartDateEffectiveness(mate_freeboard_startdate.value)) {
				alert("날짜를 확인하세요.");
				mate_freeboard_startdate.focus();
				return false;
			}
		}
		
		var mate_freeboard_enddate = document.getElementById("mate_freeboard_enddate");
		if (mate_freeboard_enddate.value == "") {
			alert("종료날짜를 입력하세요");
			mate_freeboard_enddate.focus();
			return false;
		} else {
			if(chkEndDateEffectiveness(mate_freeboard_startdate.value, mate_freeboard_enddate.value) == 0){
				alert("시작날짜의 이전 날짜는 선택 불가능합니다.");
				mate_freeboard_enddate.focus();
				return false;
			} 
			
			if (chkEndDateEffectiveness(mate_freeboard_startdate.value, mate_freeboard_enddate.value) == 1){
				alert("시작날짜의 최소 하루가 지난 날짜를 선택해야 합니다.");
				mate_freeboard_enddate.focus();
				return false;
			}
		}
		
		//글내용 예외처리
		var floatingTextarea2 = document.getElementById("floatingTextarea2");
		if (floatingTextarea2.value == "") {
			alert("내용을 입력하세요");
			floatingTextarea2.focus();
			return false;
		}
		
		mate_freeboard_frm.submit();
	}
	
	//시작날짜 유효성 검사 - 형준
	function chkStartDateEffectiveness(startDate) {
		var currentDate = new Date();
		var start_date = new Date(startDate);
		
		if (start_date - currentDate < 0) {
			return false;
		} else {
			return true;
		}
	}
	
	//종료날짜 유효성 검사 - 형준
	function chkEndDateEffectiveness(startDate, endDate) {
		
		var start_date = new Date(startDate);
		var end_date = new Date(endDate);
		
		if (end_date - start_date < 0){
			return 0;
		} else if (end_date - start_date == 0){
			return 1;
		} else {
			return 2;
		}
	}
	
	
</script>
</head>
<body>
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
						<div class="col mb-4">
							<span class="fs-2 fw-bold">메이트 글작성</span>
						</div>   
					</div>
					
					<div class="row">
					  <div class="col-1"></div>
						<div class="col">
							<form id="mate_freeboard_frm" action="${pageContext.request.contextPath }/mate/mateWriteContentProcess.do" method="post" enctype="multipart/form-data">
								<!-- 제목 입력 -->
								<div class="row mb-3"> 
									<div class="col-2 text-center align-self-center">  
										<span class="align-middle fs-5 fw-bold self">제목</span>
									</div>
									<div class="col form-floating">
										<input type="text" name="mate_freeboard_title" class="form-control" id="floatingInput">
										<label for="floatingInput">제목</label>
									</div>
								</div>
								<!-- 조건 선택 -->
								<div class="row mb-2">
									<div class="col-2 text-center">
										<span class="align-middle fs-5 fw-bold">조건 선택</span>
									</div>
									<div class="col-2 d-grid">
										<select class="form-select" id="select_fishing_category" name="fishing_category_no" onchange="getRegionCategoryList()" aria-label="Default select example">
											<option selected>낚시 종류</option>
											<c:forEach items="${commonCategoryList.fishingCategoryList }" var="fishingCategory">
												<option value="${fishingCategory.fishing_category_no }">${fishingCategory.fishing_category_name }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-3 d-grid">
										<select class="form-select" id="select_region_category" name="region_category_no" aria-label="Default select example">
											<option selected>지역</option>
										</select>
									</div>
									<div class="col"></div>
								</div>
								<!-- 인원 수 선택 -->
								<div class="row mb-2">
									<div class="col-2 text-center">
										<span class="align-middle fs-5 fw-bold">인원 선택</span>
									</div>
									<div class="col-2 d-grid">
										<select class="form-select" id="mate_freeboard_maxnumber" name="mate_freeboard_maxnumber" aria-label="Default select example">
											<option selected>인원 수 선택</option>
											<c:forEach begin="1" end="4" var="num">
												<option value="${num }">${num }명</option>
											</c:forEach>
										</select>
									</div>
									<div class="col"></div>
								</div>
								<!-- 낚시터명 입력 -->
								<div class="row mb-2">
									<div class="col-2 text-center">
										<span class="align-middle fs-5 fw-bold">낚시터명</span>
									</div>
									<div class="col-3">
										<input type="text" id="mate_freeboard_fishingholename" class="form-control" name="mate_freeboard_fishingholename">
									</div>
									<div class="col"></div>
								</div>
								<!-- 낚시터 주소 입력 -->
								<div class="row mb-2">
									<div class="col-2 text-center">
										<span class="align-middle fs-5 fw-bold">낚시터 주소</span>
									</div>
									<div class="col-3">
										<input type="text" class="form-control" name="mate_freeboard_postcode" id="sample4_postcode" placeholder="우편번호" >
									</div>
									<div class="col-2">
										<input type="button" class="btn btn-secondary" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
									</div>
									<div class="col"></div>
								</div>
								<div class="row mb-2">
									<div class="col-2"></div>
									<div class="col-2">
										<input type="text" class="form-control" name="mate_freeboard_roadAddress" id="sample4_roadAddress" placeholder="도로명주소">
									</div>
									<div class="col-2">
										<input type="text" class="form-control" name="mate_freeboard_jibunAddress" id="sample4_jibunAddress" placeholder="지번주소">
										<span id="guide" style="color:#999;display:none"></span>
									</div>
									<div class="col-2">
										<input type="text" class="form-control" name="mate_freeboard_detailAddress" id="sample4_detailAddress" placeholder="상세주소">
									</div>
									<div class="col-2">
										<input type="text" class="form-control" name="mate_freeboard_extraAddress" id="sample4_extraAddress" placeholder="참고항목">
									</div>
								</div>
								<div class="row mb-2">
									<div class="col-2 text-center">
										<span class="align-middle fs-5 fw-bold">낚시 일정</span>
									</div>
									<div class="col-3">
										<input type="date" class="form-control" id="mate_freeboard_startdate" name="mate_freeboard_startdate">
									</div>
									<div class="col-1 text-center mx-0 px-0">
										<span class="fs-4 fw-bold">~</span>
									</div>
									<div class="col-3">
										<input type="date" class="form-control" id="mate_freeboard_enddate" name="mate_freeboard_enddate">
									</div>
								</div>
								<div class="row mb-2">
									<div class="col-2"></div>
									<div class="col form-floating">
										<textarea class="form-control" name="mate_freeboard_content" id="floatingTextarea2"></textarea>
										<label for="floatingTextarea2">내용</label>
									</div>
								</div>
								<div class="row mb-3">
									<div class="col-2 text-center">
										<span class="align-middle fs-5 fw-bold">이미지</span>
									</div>
									<div class="col-3">
										<div class="input-group">
											<input type="file" id="mate_freeboard_img" accept="image/*" multiple name="upload_files" class="form-control" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
										</div>
									</div>
									<div class="col"></div>
								</div>
								<hr class="my-3">
								<div class="row">
									<div class="col"></div>
									<div class="col-1 d-grid">
										<button onclick="return mateWriteContentProcess()" class="btn btn-primary">작성</button>
									</div>
									<div class="col-1 d-grid">
										<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/mate/matePage.do">취소</a>
									</div>
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