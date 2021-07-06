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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
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
         <div class="col">
	<br>
         
         
         
         <div class="col">
				<p class="text-end pt-2 mb-0">
					<small>작성자&nbsp;${sessionUser.member_nick }</small>
				</p>
		</div>
         
				<form action="${pageContext.request.contextPath }/qna/updateContentProcess.do"
					method="post" enctype="multipart/form-data">
					<div class="row mb-3">
						<div class="col form-floating">
							<input class="form-control" name="qna_freeboard_title"
								id="Input" type="text"
								value="${data.QnaVO.qna_freeboard_title }"
								placeholder="title"> <label for="floatingInput">제목</label>
						</div>
					</div>
					



					<div class="row mb-2">
						<div class="col form-floating">
							<textarea class="form-control" name="qna_freeboard_content"
								id="Textarea" style="height: 400px; resize: none;">${data.QnaVO.qna_freeboard_content }</textarea>
							<label for="Textarea">내용</label>
						</div>
					</div>



					<div class="row mb-3">
						<div class="col-3">
							<div class="input-group">
								<input type="file" class="form-control" id="inputGroupFile04" name="upload_files"
									aria-describedby="inputGroupFileAddon04" aria-label="Upload">
							</div>
						</div>
						<div class="col"></div>
					</div>
	





					<div class="row mt-4">
						<div class="col-9"></div>
					<div class="col d-grid mx-0">
						<input type="hidden" name="qna_freeboard_no"
							value="${data.QnaVO.qna_freeboard_no }"> 
							<input	class="btn btn-primary" type="submit" value="작성">
					</div>
					
					<div class="col d-grid mx-0">
						<a class="btn btn-outline-info"
							href="${pageContext.request.contextPath }/qna/QnaContentPage.do?qna_freeboard_no=${data.QnaVO.qna_freeboard_no}">취소</a>
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