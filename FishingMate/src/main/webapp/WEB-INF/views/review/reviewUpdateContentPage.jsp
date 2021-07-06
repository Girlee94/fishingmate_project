<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
</head>
<body>
	<div style="width: 1200px; margin: 0 auto;">
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
		<div class="container-fluid mb-5">
			<div class="row">
				<div class="col border-end border-1">
					<!-- 사이드 시작 -->
						<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
					<!-- 사이드 끝 -->
				</div>
				<div class="col-10 ps-5">
				
					<h1>자유게시판 글 수정</h1><small><i class="bi bi-person-fill"></i>&nbsp;${sessionUser.member_nick }</small>
					<form action="${pageContext.request.contextPath }/review/reviewUpdateContentProcess.do" method="post">
					<!-- 내용시작 -->
						<input class="form-control" name="review_freeboard_title" type="text" value="${data.reviewVO.review_freeboard_title }" placeholder="제목">
						
					<!-- 제목끝 -->
					<br>
					<textarea class="form-control h-100" name="review_freeboard_content" col="60" rows="10">${data.reviewVO.review_freeboard_content }</textarea><br>
					<div class="row">
						<div class="col-10"></div>
						<div class="col-2 ps-4">					
							<input class="btn btn-primary" type="submit" value="작성">
							<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/review/reviewReadContentPage.do?review_freeboard_no=${data.reviewVO.review_freeboard_no}">취소</a>
							<input type="hidden" name="review_freeboard_no" value="${data.reviewVO.review_freeboard_no }">
						</div>	
					</div>
					</form>
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