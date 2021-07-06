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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<style type="text/css">
 #box1{
	margin-right: 5px;
	margin-top: 2px;
 	}
 #box2{
	margin-right: 20px;
 	}
 #box3{
 	margin-right: 25px;
 	}
 #box4{
 	margin-left: 60px;
 	}
</style>
</head>
<body>
<!-- 본문 시작  -->
	<div style="width: 1200px; margin: 0 auto;">
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/commons/header.jsp" />
<!-- 헤더 끝 -->
<form action="${pageContext.request.contextPath }/boast/updateContentProcess.do" method="post" enctype="multipart/form-data">
<div class="row container-fluid">
	<div class="col border-end border-1">
		<div class="row">
			<div class="col">
				<!-- 사이드 시작 -->
					<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
				<!-- 사이드 끝 -->
			</div>
		</div>
	</div>
	<div class="col-10">
		<div class="row pe-4">
			<div class="col-1"></div>
			<div class="col-7 border-bottom border-3"><h3>자랑 게시판</h3></div>
			<div class="col-4 border-bottom border-3"></div>
		</div>
		<div class="row mt-3">
			<div class="col-1">
			</div>
			<div class="col-2 mb-1" id="box1">
				<select name="fish_no" class="form-select" style="width:120px;" aria-label="Default select example">
					<c:forEach items="${FishCategoryList }" var="FishVO">
						<option value="${FishVO.fish_no }">${FishVO.fish_name }</option>
					</c:forEach>
				</select>	
			</div>
			<div class="col-2 mt-1" id="box2">
				<input type="text" style="width:170px;" name="showoff_freeboard_fishlength" class="form-control" value="${data.showoffVO.showoff_freeboard_fishlength}">
			</div>
			<div class="col-3 mt-2">
			</div>
			<div class="col">
			</div>
		</div>
		<div class="row">
			<div class="col-1">
			</div>
			<div class="col-4 mt-1 text-center" id="box3">
				<input id="input_showoff_title" name="showoff_freeboard_title" type="text" style="width:400px;" class="form-control" value="${data.showoffVO.showoff_freeboard_title }">
			</div>
			<div class="col-2 mt-1" id="box4">
			</div>
			<div class="col">
			</div>
		</div>
		<div class="row mt-3">
			<div class="col-1">
			</div>
			<div class="col">
				<textarea class="form-control h-100" name="showoff_freeboard_content" cols="50" rows="10">${data.showoffVO.showoff_freeboard_content }</textarea>
			</div>
			<div class="col">
			</div>
		</div>
		<div class="row mt-3 mb-3">
			<div class="col-1"></div>
			<div class="col-4">
				<input class="form-control" type="file" accept="image/*" multiple name="upload_files">
			</div>
			<div class="col-4">
				<input class="btn btn-secondary btn float-right" type="submit" value="작성">
				<button type="button" onclick="location.href ='${pageContext.request.contextPath }/main/boast.do';" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-content="Bottom popover">
						취소</button>	
			</div>
			<div class="col">
				<input type="hidden" value="${data.showoffVO.showoff_freeboard_no }" name="showoff_freeboard_no">
				<input type="hidden" value="${data.showoffVO.member_no }" name="member_no">
				<input type="hidden" value="${data.showoffVO.showoff_freeboard_fishlength }" name="fishlength">
				<c:forEach items="${FishCategoryList }" var="FishVO">
					<input type="hidden" value="${FishVO.fish_no }" name="fish">
				</c:forEach>
			</div>
		</div>
	</div>
</div>
</form>
<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
<!-- 푸터 끝 -->
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>