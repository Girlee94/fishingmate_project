<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">


</head>
<body>
	
	
	<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="container-fluid mb-5">
		<div class="row border-bottom border-1 pb-2 mb-4">
			<div class="col text-center">
				<span id="updatefestivM">
				<img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70">
					My Page_
				</span>
			</div>
		</div>
		<div class="row">
			<div class="col text-center">
				<div class="row mb-4 pb-2">
					<div class="col text-center">
						<span class="fs-4 fw-bold">${sessionUser.member_nick }</span>
					</div>
				</div>
				<jsp:include page="/WEB-INF/views/member/myPageTop.jsp" />
				<div class="row mb-4">
					<div class="col">
					
					</div>
				</div>
				<div class="row mt-1">
							<div class="col"></div>
							<div class="col-4">
							<span class="fw-bold mt-1">내 매너점수</span>
								<div class="progress" style="height: 4px; margin-top: 11px;">
									<div class="progress-bar" role="progressbar" style="width: ${evaluteValueRate }%;" aria-valuenow="${memberEvaluateVO.member_evaluate_value }" aria-valuemin="0" aria-valuemax="10"></div>
								</div>
							</div>
							<div class="col text-start ps-0">
								<small>${memberEvaluateVO.member_evaluate_value }</small>
							</div>
							
							<br>
							
							<div class="row mt-3">
								<div class="col-5"></div>
								<div class="col text-start ps-5" >
									<i class="bi bi-thermometer-half"></i> 레벨_ ${sessionUser.level_no }<br>
									<i class="bi bi-sort-up"></i> 경험치_ ${sessionUser.member_levelvalue }<br>
									
									<i class="bi bi-person-check"></i> 아이디_ ${sessionUser.member_id }<br>
									<i class="bi bi-person-check-fill"></i> 이름_ ${sessionUser.member_name }<br>
									<i class="bi bi-person"></i> 닉네임_ ${sessionUser.member_nick }<br>
																		
									<i class="bi bi-gender-ambiguous"></i> 성별_ ${sessionUser.member_gender }<br>
									<i class="bi bi-gift"></i> 생일_ <fmt:formatDate pattern="yyyy/MM/dd" value="${sessionUser.member_birth }"/><br>
									<i class="bi bi-display"></i> 가입일_ <fmt:formatDate pattern="yyyy/MM/dd" value="${sessionUser.member_signup }"/><br>
									
								</div>
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