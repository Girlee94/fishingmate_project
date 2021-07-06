<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<div class="container-fluid my-4">
			<div class="row">
				<div class="col border-end border-1">
					<!-- 사이드 시작 -->
						<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
					<!-- 사이드 끝 -->
				</div>
				<div class="col-10 ">
					<div class="row">
						<div class="col-1"></div>
						<div class="col">
							<h1>글 작성하기</h1>
							<form
								action="${pageContext.request.contextPath }/review/reviewWriteContentProcess.do"
								method="post" enctype="multipart/form-data">
			
			
			
								<div class="row">
									<div class="row">
										<div class="col-10 mt-3 pb-5">
											<input class="form-control" type="text" style="width: 500px; height: 40px;" name="review_freeboard_title" placeholder="제목을 입력해주세요">
										</div>
										<br>
										<div class="col-2 mt-3">									
											<i class="bi bi-person-fill"></i>&nbsp; ${sessionUser.member_nick }
										</div>
									</div>
									<div class="row">
										<div class="col"></div>
									</div>
									<div class="row">
										<div class="col">
											<textarea class="form-control" rows="10" cols="60" name="review_freeboard_content"></textarea>
										</div>
									</div>
									<div class="row">
			
										<div class="col-6 mt-4">
											<input class="form-control" type="file" accept="image/*"
												multiple name="upload_files"><br>
										</div>
										<div class="col"></div>
										<div class="col-2 mt-4 text-end d-grid" style="width: 80px; height: 40px;">
											<input type="submit" class="btn btn-primary me-2" value="글 작성">
										</div>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous"></script>
</body>
</html>