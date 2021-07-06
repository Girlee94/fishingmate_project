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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateApplyGroupPage.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->

	<div class="container-fluid mb-5">
		<div class="row">
			<div class="col"></div>
			<div class="col-8">
				<div class="row my-4 border-bottom border-2">
					<div class="col">
						<p class="h2 pb-2 ps-2 mt-2">${oneMateContent.mateFreeboardVO.mate_freeboard_title }</p>
					</div>
				</div>
				<div class="row mt-2 pb-2 border-bottom border-1">
					<div id="mate_read_content_form" class="col-9 border border-1 py-3 me-1">
						<p id="mate_read_content">
							${oneMateContent.mateFreeboardVO.mate_freeboard_content }
						</p>
					</div>
					<div class="col py-3 px-0 border border-1">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								낚시종류 - ${oneMateContent.fishingCategoryVO.fishing_category_name }
							</li>
							<li class="list-group-item">
								낚시터 위치 - <br>
								<small>
									(도로명)<br>
									${oneMateContent.mateFreeboardVO.mate_freeboard_roadAddress }
									${oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress }
									${oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress }<br>
								</small>
							</li>
							<li class="list-group-item">
								<small>
									(지번)<br>
									${oneMateContent.mateFreeboardVO.mate_freeboard_jibunAddress }
									${oneMateContent.mateFreeboardVO.mate_freeboard_detailAddress }
									${oneMateContent.mateFreeboardVO.mate_freeboard_extraAddress }
								</small>
							</li>
							<li class="list-group-item">
								낚시 일정<br>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_startdate}"/> ~ 
								<fmt:formatDate pattern="yyyy-MM-dd" value="${oneMateContent.mateFreeboardVO.mate_freeboard_enddate}"/>
							</li>
						</ul>
					</div>
				</div>
				<div id="mate_content_form" class="row mt-2 pb-2 border-bottom border-1">
					<div class="col px-0 d-grid">
						<form id="applyFrm" class="row px-0" action="${pageContext.request.contextPath }/mate/mateApplyGroupProcess.do" method="post">
							<div class="col d-grid">
								<textarea class="form-control resize-none" name="mate_content" placeholder="요구사항과 간단한 자기소개를 입력하세요"></textarea>
								<input type="hidden" name="member_no" value="${sessionUser.member_no }">
								<input type="hidden" name="mate_freeboard_no" value="${oneMateContent.mateFreeboardVO.mate_freeboard_no }">
							</div>
						</form>
					</div>
				</div>
				<div class="row mt-4 pt-3 border-top border-2">
					<div class="col"></div>
					<div class="col-1 d-grid p-0">
						<button class="btn btn-primary" onclick="applyGroup()">신청</button>
					</div>
					<div class="col-1 d-grid p-0 ms-2">
						<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/mate/mateReadContentPage.do?mate_freeboard_no=${oneMateContent.mateFreeboardVO.mate_freeboard_no}">취소</a>
					</div>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>


	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
<script type="text/javascript">
	function applyGroup(){
		var applyFrm = document.getElementById("applyFrm");
		applyFrm.submit();
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>