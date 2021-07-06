<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/execDaumPostcode.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
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
				<div class="col"></div>
				<div class="col-10">
					<div class="row my-4 border-bottom border-2">
						<div class="col-7">
							<p class="h2 pb-2 ps-2 mt-2">평가 페이지</p>
						</div>
					</div>
					<div class="row mt-3 mb-2">
						<div class="col">
							<span class="text-muted">
								<small>${confirmListCount }명의 인원이 있습니다</small>
							</span>
						</div>
					</div>
					<div class="row">
						<div class="col border-top border-bottom border-1 p-0">
							<ul class="list-group list-group-flush">
								<li class="list-group-item">
									<div class="row">
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">이름</span>
										</div>
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">나이</span>
										</div>
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">성별</span>
										</div>
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">매너점수</span>
										</div>
										<div class="col-1 border-end border-1 text-center">
											<span class="fw-bold">평가하기</span>
										</div>
										<div class="col pe-2 border-end border-1 text-center">
											<span class="fw-bold">-</span>
										</div>
										<div class="col-1 text-center">
										</div>
									</div>
								</li>
								<li class="list-group-item">
									<div class="row">
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">이름</span>
										</div>
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">나이</span>
										</div>
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">성별</span>
										</div>
										<div class="col-1 pe-2 border-end border-1 text-center">
											<span class="fw-bold">매너점수</span>
										</div>
										<div class="col-1 border-end border-1 text-center">
											<span class="fw-bold">평가하기</span>
										</div>
										<div class="col pe-2 border-end border-1 text-center">
											<span class="fw-bold">-</span>
										</div>
										<div class="col-1 text-center">
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="row mt-4 pt-3 border-top border-2">
						<div class="col"></div>
						<div class="col-1 d-grid p-0 ms-2">
							<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/mate/mateReadContentPage.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">
								뒤로
							</a>
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