<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->

	<!--본문시작 -->
<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				<form action="${pageContext.request.contextPath }/infofreeboard/modifyinfoCommentProcess.do" method="post">
					<!-- 내용 시작 -->
					<div class="row border-bottom border-2 mb-3">
						<div class="col">
							<h5 class="text-start">댓글 수정</h5>
						</div>
						<div class="col">
							<p class="text-end">
								<small>작성자&nbsp;${sessionUser.member_nick }</small>
							</p>
						</div>
					</div>
					<!-- 제목 끝 -->
					<!-- 내용 시작 -->
					<div class="row">
						<div class="col">
							
						</div>
					</div>
					<div class="row border-bottom border-2 mb-3 pb-2">
						<div class="col my-2">
  							<textarea class="form-control" name="info_comment_content" rows="5">${infofreeboardCommentVO.info_comment_content }</textarea>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col-9"></div>
						<div class="col d-grid">
							<input type="hidden" value="${infofreeboardCommentVO.member_no }" name="member_no">
							<input type="hidden" value="${infofreeboardCommentVO.info_comment_no }" name="info_comment_no">
							<input type="hidden" value="${infofreeboardCommentVO.info_freeboard_no }" name="info_freeboard_no">
							<input class="btn btn-primary" type="submit" value="수정">
						</div>
						<div class="col d-grid">
							<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/infofreeboard/readinfoContentPage.do?freeboard_no=${infofreeboardCommentVO.info_freeboard_no}">취소</a>
						</div>
					</div>
					<!-- 내용 끝 -->
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>
	<!-- 본문 끝 -->


	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>