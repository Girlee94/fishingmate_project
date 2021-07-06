<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/execDaumPostcode.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
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
			<div class="col-10">
				<div class="row my-4">
					<span class="fs-2 fw-bold">정보 글수정</span>
				</div>
				<form
					action="${pageContext.request.contextPath }/infofreeboard/updateinfoContentProcess.do"
					method="post" enctype="multipart/form-data">
					<div class="row mb-3">
						<div class="col-2"></div>
						<div class="col form-floating">
							<input class="form-control" name="info_freeboard_title"
								id="floatingInput" type="text"
								value="${data.infoFreeboardVO.info_freeboard_title }"
								placeholder="title"> <label for="floatingInput">제목</label>
						</div>
					</div>
					<div class="col">
						<p class="text-end pt-2 mb-0">
							<small>작성자&nbsp;${sessionUser.member_nick }</small>
						</p>
					</div>

					<div class="row mb-2">
						<div class="col-2"></div>
						<div class="col form-floating">
							<textarea class="form-control" name="info_freeboard_content"
								id="floatingTextarea" style="hight: 200px; resize: none;"></textarea>
							<label for="floatingTextarea">내용</label>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-2 text-center">
							<span class="align-middle fs-5 fw-bold">이미지추가</span>
						</div>
						<div class="col-3">
							<div class="input-group">
								<input type="file" class="form-control" id="inputGroupFile04" name="upload_files"
									aria-describedby="inputGroupFileAddon04" aria-label="Upload">
							</div>
						</div>
						<div class="col"></div>
					</div>
					
					<div class="row mb-2">
						<c:forEach items="${getimageNo}" var="imageno">
							<img src="/upload_files/${imageno.image_location}">
						<a href="${pageContext.request.contextPath}/infofreeboard/deleteContentImageProcess.do?image_no=${imageno.image_no}&&info_freeboard_no=${data.infoFreeboardVO.info_freeboard_no}"><button type="button" class="btn btn-warning">삭제</button></a>
					</c:forEach>	
					
					
					</div>
					

					<div class="col d-grid">
						<input type="hidden" name="info_freeboard_no"
							value="${data.infoFreeboardVO.info_freeboard_no }"> <input
							class="btn btn-primary" type="submit" value="작성">
					</div>
					<div class="col d-grid">
						<a class="btn btn-outline-primary"
							href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">취소</a>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous"></script>

</body>
</html>
