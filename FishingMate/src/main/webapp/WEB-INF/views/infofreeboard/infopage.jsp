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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/matePage.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="container-fluid my-4">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">

				<div class="row" id="review_card_list">
					<div id="total">▷ 총 ${contentCount }개의 글이 있습니다.</div>

					<c:forEach items="${reviewList}" var="data">
						<div class="col-3 mb-4" >
							<div class="card" style="width: 18rem;">							
									<img src="/upload_files/${data.reviewImageVOList[0].image_location}" class="card-img-top" onerror="this.src='${pageContext.request.contextPath}/resources/img/noimage.gif'">								
								<div class="card-body">
									<h5 class="card-title">${data.reviewVO.review_freeboard_title }</h5>
									<p class="card-text">작성자: ${data.memberVO.member_nick }&nbsp; 
														  작성날짜 :<fmt:formatDate value="${data.reviewVO.review_writedate }" pattern="yy.MM.dd" /></p>
									<p class="card-text">조회수:${data.reviewVO.review_freeboard_readcount }&nbsp; 댓글수 :${data.commentCount}</p>
									<a href="${pageContext.request.contextPath}/review/reviewReadContentPage.do?review_freeboard_no=${data.reviewVO.review_freeboard_no }" class="btn btn-primary">글 보러가기</a>
								</div>
							</div>
						</div>
						
						<div class="text-wrap bd-highlight" style="width: 8rem;">
 						 This text should overflow the parent.
						</div>
						
						
						
					</c:forEach>
					<div class="row mt-3 mb-3">
						<div class="col">&nbsp;</div>
						<div class="col">
							<span class="align-middle">◀ 이전 1 다음 ▶</span>
						</div>
						<div class="col-2 d-flex ms-auto justify-content-end">
							<c:if test="${! empty sessionUser  }">
								<input type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewWriteContentPage.do'" class="btn btn-primary" value="글쓰기">
							</c:if>
						</div>
					</div>



				</div>
			</div>
			<div class="col"></div>
		</div>

	</div>


	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>