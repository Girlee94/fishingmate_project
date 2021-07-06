<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
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
			   <div class="col-1"></div> 
			    <div class="col">
			    <div class="row mb-3">  
				<span class="fs-2 fw-bold">정보 글작성</span>  
				</div>		
				<form action="${pageContext.request.contextPath }/infofreeboard/writeinfoprocess.do" method="post" enctype="multipart/form-data">
				
				<div class="row mb-3">
					<div class="col-2 text-center">
				<span class="align-middle fs-5 fw-bold">작성자</span>			
				 	</div>
				
					<div class="col-3">
						<div class="idset">
							<span class="align-middle fs-5 fw-bold"> ${sessionUser.member_nick }</span>	
						</div>
					</div>
				</div>
					
			
						
				
				<!-- 타이틀 -->
				<div class="row mb-3">
					<div class="col-2 text-center">
						<span class="align-middle fs-5 fw-bold">제목</span>
					</div>
					<div class="col form-floating">
						<input type="text" name="info_freeboard_title" class="form-control" id="floationgInput"><br>
						<label for="floationgInput">제목</label>
					</div>
				</div>
				
				<!-- 카테고리 선택 -->
				<div class="row mb-2">
					<div class="col-2 text-center">
						<span class="align-middle fs-5 fw-bold">카테고리 선택</span>
					</div>
					<div class="col-2 d-grid">
							<select class="form-select" id="select_info_category" name="info_category_no" aria-label="Defult select example">	
							<option>카테고리</option>
							<c:forEach items="${infoCategoryList }" var="infoCategoryList">
							<option value="${infoCategoryList.info_category_no }">${infoCategoryList.freeboard_category_name}</option>
							</c:forEach>
							</select>	
					</div>	
				</div>
				
				<!-- 내용 -->
				<div class="row mb-2">
					<div class="col-2"></div>
						<div class="col form-floating">
						<textarea class="form-control" name="info_freeboard_content" id="floatingTextarea" style="hight:200px; resize: none;"></textarea>
						<label for="floatingTextarea">내용</label>
						</div>
				</div>
				<!-- 이미지 -->
				<div class="row mb-3">
					<div class="col-2 text-center">
						<span class="align-middle fs-5 fw-bold">이미지</span>			
					</div>
						<div class="col-3">
							<div class="input-group">
								<input class="form-control" type="file" accept="image/*" multiple name="upload_files" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
							</div>
						</div>
				</div>
				
				<hr class="my-3">
				<div class="row">
					<div class="col"></div>
					<div class="col-1 d-grid">
					<input type="submit" class="btn btn-primary" value="작성">
					</div>
			
				<div class="col-1 d-grid">
				<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/freeboard/boardList.do">취소</a>
				
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>