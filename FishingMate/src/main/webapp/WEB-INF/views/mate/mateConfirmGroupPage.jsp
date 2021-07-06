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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateConfirmGroupPage.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">
	
	var sessionMemberNo = null;
	var evaluate_modal = null;
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
	
	//회원평가 Modal 호출 - 형준
	function openEvaluateModal(mate_confirm_no, member_no, num) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		evaluate_modal = new bootstrap.Modal(document.getElementById("staticBackdrop"));
		var evaluate_member_nick = document.getElementById("evaluate_member_nick");
		var evaluate_content = document.getElementById("evaluate_content");
		var evaluate_submit = document.getElementById("evaluate_submit");
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				evaluate_modal.show();
				evaluate_member_nick.innerText = obj.member_nick;
				if(evaluate_content.value.length > 0){
					evaluate_content.value = "";
				}
				evaluate_submit.setAttribute("onclick", "evaluteMemberProcess(" + mate_confirm_no + "," + member_no + "," + num + ")");
			}
		};
	
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/getEvaluateToMemberNick.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no);
	}

	//회원 평가 - 형준
	function evaluteMemberProcess(mate_confirm_no, member_no, num) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		var evaluate_type = document.getElementById("evaluate_type").value;
		var evaluate_content = document.getElementById("evaluate_content");
		var evaluate_button = document.getElementById("evaluate_button" + num);
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			//var obj = JSON.parse(xmlhttp.responseText);
			
			evaluate_button.setAttribute("disabled", "disabled");
			evaluate_button.innerText = "평가완료";
			evaluate_modal.hide();
			}
		};
	
		xmlhttp.open("post","${pageContext.request.contextPath}/mate/evaluteMemberProcess.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("mate_confirm_no=" + mate_confirm_no + "&to_member_no=" + member_no + "&evaluate_content=" + evaluate_content.value + "&evaluate_type=" + evaluate_type);	
	}
	

</script>
</head>
<body onload="getSessionMemberNo()">
	<div style="width: 1200px; margin: 0 auto;">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
		
		<div class="container-fluid mb-5">
			<div class="row">
				<div class="col"></div>
				<div class="col-11">
					<div class="row my-4 border-bottom border-2">
						<div class="col-7">
							<p class="h2 pb-2 ps-2 mt-2">${oneMateContent.mateFreeboardVO.mate_freeboard_title }</p>
						</div>
						<div class="col position-relative">
							<span class="position-absolute top-50 end-0 translate-middle-y fs-5">
								인원 현황&nbsp;-&nbsp;
								${confirmListCount }/${oneMateContent.mateFreeboardVO.mate_freeboard_maxnumber }명
							</span>
						</div>
					</div>
					<div class="row mt-3 mb-2">
						<div class="col">
							<span class="text-muted">
								<small>${confirmListCount }명의 인원이 있습니다</small>
							</span>
						</div>
					</div>
					<div class="row">
						<div class="col border-top border-bottom border-1 p-0">
							<ul id="mate_confirm_list" class="list-group list-group-flush">
								<li class="list-group-item">
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
											<span class="fw-bold">-</span>
										</div>
										<div class="col-1 text-center">
										</div>
										<div class="col-1 text-center">
										</div>
									</div>
								</li>
								<c:forEach items="${mateConfirmGroupList }" var="mateConfirmGroupList" varStatus="status">
									<li class="list-group-item">
										<div class="row">
											<div class="col-1 pe-2 border-end border-1 text-center">
												<span class="align-middle">
													${mateConfirmGroupList.memberVO.member_nick }
												</span>
											</div>
											<div class="col-1 pe-2 border-end border-1 text-center">
												<span class="align-middle">
													${mateConfirmGroupList.member_age }
												</span>
											</div>
											<div class="col-1 pe-2 border-end border-1 text-center">
												<span class="align-middle">
													${mateConfirmGroupList.member_gender }
												</span>
											</div>
											<div class="col-1 pe-2 border-end border-1 text-center">
												<span class="align-middle">
													7.4
												</span>
											</div>
											<div class="col pe-2 border-end border-1">
												<span class="align-middle">
													${applyGroupList.mateConfirmVO.mate_content }
												</span>
											</div>
											<div id="evaluate_btn_box" class="col-2 text-center d-grid">
												<c:choose>
													<c:when test="${!empty sessionUser && sessionUser.member_no == mateConfirmGroupList.memberVO.member_no}">
														<button class="btn btn-secondary btn-sm" disabled>본인</button>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${mateConfirmGroupList.chkEvaluateToMember <= 0 }">
																<button type="button" id="evaluate_button${status.count }" class="btn btn-secondary btn-sm" onclick="openEvaluateModal(${mateConfirmGroupList.mateConfirmVO.mate_confirm_no }, ${mateConfirmGroupList.memberVO.member_no}, ${status.count })">
																	평가하기
																</button>
															</c:when>
															<c:otherwise>
																<button type="button" class="btn btn-secondary btn-sm" disabled>
																	평가완료
																</button>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="row mt-4 pt-3 border-top border-2">
						<div class="col"></div>
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
	
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">평가하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row border-bottom border-1 pb-1 mb-2">
						<div class="col-2 border-end border-1 position-relative m-0">
							<span class="position-absolute start-50 top-50 translate-middle fs-6">이름</span>
						</div>
						<div class="col border-end border-1 position-relative">
							<span id="evaluate_member_nick" class="position-absolute start-50 top-50 translate-middle fs-5"></span>
						</div>
						<div class="col-4">
							<select id="evaluate_type" class="form-select" aria-label="Default select example">
								<option selected>평가 선택</option>
								<option value="0">좋아요</option>
								<option value="1">나빠요</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="form-floating">
								<textarea id="evaluate_content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
								<label for="floatingTextarea">평가 내용</label>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="evaluate_submit" class="btn btn-primary">완료</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
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