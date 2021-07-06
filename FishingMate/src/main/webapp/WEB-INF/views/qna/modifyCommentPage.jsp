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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
</head>
<body>
	<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	
	<div class="container-fluid mb-5">
		<div class="row">
			<div class="col border-end border-1"></div>
	 			<div class="col-10">
		<br>
		
				<form action="${pageContext.request.contextPath }/qna/modifyCommentProcess.do" method="post">
					<!-- 내용 시작 -->
					<div class="row border-bottom border-2 mb-3">
						<div class="col">
							<h5 class="text-start">댓글 수정 ${QnaCommentVO.qna_freeboard_no }</h5>
						</div>
						<div class="col">
							<p class="text-end">
								<small>작성자&nbsp;${sessionUser.member_nick }</small>
							</p>
						</div>
					</div>
		
				<div class="row border-bottom border-2 mb-3 pb-2">
						<div class="col my-2">
  							<textarea class="form-control" name="qna_comment_content" rows="5">${QnaCommentVO.qna_comment_content }</textarea>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col-9"></div>
						<div class="col d-grid mx-0">
							<input type="hidden" value="${QnaCommentVO.manager_no }" name="manager_no">
							<input type="hidden" value="${QnaCommentVO.qna_comment_no }" name="qna_comment_no">
					    	<input type="hidden" value="${QnaCommentVO.qna_freeboard_no }" name="qna_freeboard_no">
							<input class="btn btn-primary" type="submit" value="수정">
						</div>
						<div class="col d-grid mx-0">
							<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/qna/QnaContentPage.do?qna_freeboard_no=${QnaCommentVO.qna_freeboard_no}">취소</a>
						</div>
					</div>
		</form>
		
		</div>
		<div class="col"></div>
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
