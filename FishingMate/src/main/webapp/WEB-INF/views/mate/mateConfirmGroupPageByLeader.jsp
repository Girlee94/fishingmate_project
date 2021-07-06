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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">
	var sessionMemberNo = null;
	var mate_freeboard_no = ${oneMateContent.mateFreeboardVO.mate_freeboard_no};
		
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
	
	//메이트 게시판 그룹 신청 거절하기 - 형준
	function denyMateApplyGroupProcess(member_no) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				refreshApplyGroupList();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/denyMateApplyGroupProcess.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no + "&mate_freeboard_no=" + mate_freeboard_no);	
	}
	
	//메이트 게시판 확정 그룹에 회원 추가하기 - 형준
	function insertMateConfirmGroupProcess(member_no) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
			
				refreshApplyGroupList();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/insertMateConfirmGroupProcess.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no + "&mate_freeboard_no=" + mate_freeboard_no);	
	}
	
	//메이트 게시판 확정 그룹에 회원 제거하기 - 형준
	function denyMateConfirmGroupProcess(member_no, mate_confirm_no) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
			
				refreshApplyGroupList();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/deleteMateConfirmGroupProcess.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no + "&mate_freeboard_no=" + mate_freeboard_no + "&mate_confirm_no=" + mate_confirm_no);	
	}
	
	//메이트 게시판 신청 그룹 목록 가져오기
	function refreshApplyGroupList() {
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var apply_count = document.getElementById("apply_count");
				apply_count.innerText = obj.applyGroupCount;
				
				var confirm_count = document.getElementById("confirm_count");
				confirm_count.innerText = obj.confirmGroupCount;
				
				var apply_group_list = document.getElementById("apply_group_list");
				apply_group_list.innerText = "";
				
				var apply_group_list_first = document.getElementById("apply_group_list_first");
				var applyListLiBox = apply_group_list_first.cloneNode(true);
				applyListLiBox.removeAttribute("class");
				applyListLiBox.setAttribute("class", "list-group-item");
				apply_group_list.appendChild(applyListLiBox);
			 
				for(var applyList of obj.applyGroupList){
					
					var applyListLiBox = document.createElement("li");
					applyListLiBox.setAttribute("class", "list-group-item");
					
					var applyListRowBox = document.createElement("div");
					applyListRowBox.setAttribute("class", "row");
					
					var applyListNickColBox = document.createElement("div");
					var applyListNickSpanBox = document.createElement("span");
					applyListNickColBox.setAttribute("class", "col-1 pe-2 border-end border-1 text-center");
					applyListNickSpanBox.setAttribute("class", "align-middle");
					applyListNickSpanBox.innerText = applyList.member_nick;
					applyListNickColBox.appendChild(applyListNickSpanBox);
					applyListRowBox.appendChild(applyListNickColBox);
					
					var applyListAgeColBox = document.createElement("div");
					var applyListAgeSpanBox = document.createElement("span");
					applyListAgeColBox.setAttribute("class", "col-1 pe-2 border-end border-1 text-center");
					applyListAgeSpanBox.setAttribute("class", "align-middle");
					applyListAgeSpanBox.innerText = applyList.member_age;
					applyListAgeColBox.appendChild(applyListAgeSpanBox);
					applyListRowBox.appendChild(applyListAgeColBox);
					
					var applyListGenderColBox = document.createElement("div");
					var applyListGenderSpanBox = document.createElement("span");
					applyListGenderColBox.setAttribute("class", "col-1 pe-2 border-end border-1 text-center");
					applyListGenderSpanBox.setAttribute("class", "align-middle");
					applyListGenderSpanBox.innerText = applyList.member_gender;
					applyListGenderColBox.appendChild(applyListGenderSpanBox);
					applyListRowBox.appendChild(applyListGenderColBox);
					
					var applyListMannerColBox = document.createElement("div");
					var applyListMannerSpanBox = document.createElement("span");
					applyListMannerColBox.setAttribute("class", "col-1 pe-2 border-end border-1 text-center");
					applyListMannerSpanBox.setAttribute("class", "align-middle");
					applyListMannerSpanBox.innerText = "7.4";
					applyListMannerColBox.appendChild(applyListMannerSpanBox);
					applyListRowBox.appendChild(applyListMannerColBox);
					
					var applyListContentColBox = document.createElement("div");
					var applyListContentSpanBox = document.createElement("span");
					applyListContentColBox.setAttribute("class", "col pe-2 border-end border-1");
					applyListContentSpanBox.setAttribute("class", "align-middle");
					applyListContentSpanBox.innerText = applyList.mateGroupVO.mate_content;
					applyListContentColBox.appendChild(applyListContentSpanBox);
					applyListRowBox.appendChild(applyListContentColBox);
					
					var applyListApproveColBox = document.createElement("div");
					var applyListApproveSpanBox = document.createElement("span");
					applyListApproveColBox.setAttribute("class", "col-1 pe-2 border-end border-1 text-center");
					applyListApproveSpanBox.setAttribute("class", "align-middle");
					applyListApproveSpanBox.innerText = applyList.mateGroupVO.mate_approve;
					applyListApproveColBox.appendChild(applyListApproveSpanBox);
					applyListRowBox.appendChild(applyListApproveColBox);
					
					var applyListConfirmColBox = document.createElement("div");
					var applyListConfirmButton = document.createElement("button");
					applyListConfirmColBox.setAttribute("class", "col-1 text-center");
					applyListConfirmButton.setAttribute("class", "btn btn-primary btn-sm");
					
					if (applyList.mate_confirm_no == 0) {
						applyListConfirmButton.setAttribute("onclick", "insertMateConfirmGroupProcess(" + applyList.mateGroupVO.member_no + ")");
						applyListConfirmButton.innerText = "승인";
					} else {
						applyListConfirmButton.setAttribute("disabled", "disabled");
						applyListConfirmButton.setAttribute("class", "btn btn-primary btn-sm px-1");
						applyListConfirmButton.innerText = "승인완료";
					}
					
					applyListConfirmColBox.appendChild(applyListConfirmButton);
					applyListRowBox.appendChild(applyListConfirmColBox);
					
					var applyListDenyColBox = document.createElement("div");
					var applyListDenyButton = document.createElement("button");
					applyListDenyColBox.setAttribute("class", "col-1 text-center");
					applyListDenyButton.setAttribute("class", "btn btn-secondary btn-sm");
					applyListDenyButton.innerText = "거절";
					
					if (applyList.mate_confirm_no == 0) {
						applyListDenyButton.setAttribute("onclick", "denyMateApplyGroupProcess(" + applyList.mateGroupVO.member_no + ")");
					} else {
						applyListDenyButton.setAttribute("onclick", "denyMateConfirmGroupProcess(" + applyList.mateGroupVO.member_no + ", " + applyList.mate_confirm_no + ")");
					}
					
					if (applyList.mateGroupVO.mate_approve == '거절') {
						applyListDenyButton.setAttribute("disabled", "disabled");
						applyListDenyButton.innerText = "거절됨";
					}
					
					applyListDenyColBox.appendChild(applyListDenyButton);
					applyListRowBox.appendChild(applyListDenyColBox);
					
					
					
					applyListLiBox.appendChild(applyListRowBox);
					apply_group_list.appendChild(applyListLiBox);
				}
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/mate/getApplyGroupList.do?mate_freeboard_no=" + mate_freeboard_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	function init() {
		getSessionMemberNo();
		refreshApplyGroupList();
	}
	
</script>
</head>
<body onload="init()">
	
	<div style="width: 1200px; margin: 0 auto;">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
	
		<div class="container-fluid mb-5">
			<div class="row">
				<div class="col"></div>
				<div class="col-10">
					<div class="row my-4 border-bottom border-2">
						<div class="col-7">
							<p class="h2 pb-2 ps-2 mt-2">${oneMateContent.mateFreeboardVO.mate_freeboard_title }</p>
						</div>
						<div class="col position-relative">
							<span class="position-absolute top-50 end-0 translate-middle-y fs-5">
								인원 현황&nbsp;-&nbsp;
								<span id="confirm_count"></span>/${oneMateContent.mateFreeboardVO.mate_freeboard_maxnumber }명
							</span>
						</div>
					</div>
					<div class="row mt-3 mb-2">
						<div class="col">
							<span class="text-muted">
								<small><span id="apply_count"></span>명의 신청인원이 있습니다</small>
							</span>
						</div>
					</div>
					<div class="row">
						<div class="col border-top border-bottom border-1 p-0">
							<ul id="apply_group_list" class="list-group list-group-flush"></ul>
						</div>
					</div>
					<div class="row mt-4 pt-3 border-top border-2">
						<div class="col"></div>
						<div class="col-1 d-grid p-0 ms-2">
							<a class="btn btn-primary" href="${pageContext.request.contextPath }/mate/updateMateFreeboardStatusToComplete.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">
								모집완료
							</a>
						</div>
						<div class="col-1 d-grid p-0 ms-2">
							<a class="btn btn-outline-danger" href="${pageContext.request.contextPath }/mate/updateMateFreeboardStatusToCancel.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">
								모집취소
							</a>
						</div>
						<div class="col-1 d-grid p-0 ms-2">
							<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/mate/mateReadContentPage.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">
								뒤로
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- UI 복사용/Clone -->
	<li id="apply_group_list_first" class="list-group-item visually-hidden">
		<div class="row">
			<div class="col-1 pe-2 border-end border-1 text-center">
				<span class="fw-bold">이름</span>
			</div>
			<div class="col-1 pe-2 border-end border-1 text-center">
				<span class="fw-bold">나이</span>
			</div>
			<div class="col-1 pe-2 border-end border-1 text-center">
				<span class="fw-bold">성별</span>
			</div>
			<div class="col-1 pe-2 border-end border-1 text-center">
				<span class="fw-bold">매너점수</span>
			</div>
			<div class="col pe-2 border-end border-1 text-center">
				<span class="fw-bold">요구사항</span>
			</div>
			<div class="col-1 border-end border-1 text-center">
				<span class="fw-bold">상태</span>
			</div>
			<div class="col-1 text-center">
			</div>
			<div class="col-1 text-center">
			</div>
		</div>
	</li>

	<div style="width: 100%; margin: 0 autol;">
		<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
		<!-- 푸터 끝 -->
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>