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
						Message_
					</span>
				</div>
			</div>
		<jsp:include page="/WEB-INF/views/member/myPageTop.jsp" />
		<div class="row">
			<div class="col"></div>
			<div class="col-8 fw-bold">
				<div class="row">
					<div class="col-5 border border-1 p-2">
						<i class="bi bi-envelope"></i> 받은 쪽지 내용  확인
						<div class="mb-3">
						  <label for="exampleFormControlTextarea1" class="form-label"></label>
						  
						  <p><i class="bi bi-calendar"></i> <fmt:formatDate pattern="yyyy/MM/dd (hh:mm)" value="${inboxReadVO.message_senddate }"/></p>
						  <p><i class="bi bi-person"></i> 보낸 사람_ ${fromMemberNick}</p>
						  
						  <p><i class="bi bi-chat-square-text"></i> ${inboxReadVO.message_content }</p>
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