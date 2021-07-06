<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

<script type="text/javascript">
	
	//글쓰기 예외 처리
	function tradeWriteContent() {
		var trade_freeboard_frm = document.getElementById("trade_freeboard_frm");
		
		//제목 예외처리
		var trade_freeboard_title = document.getElementById("trade_freeboard_title");
		if (trade_freeboard_title.value == "") {
			alert("제목을 입력하세요");
			trade_freeboard_title.focus();
			return false;
		}
		//카테고리
		var item_category = document.getElementById("item_category");
		if(item_category.selectedIndex == 0){
			alert("카테고리을 선택하세요");
			item_category.focus();
			return false;
		}
		
		//가격
				
		var trade_freeboard_itemprice = document.getElementById("trade_freeboard_itemprice");
		
		if (trade_freeboard_itemprice.value == "") {
			alert("가격을 입력하세요");
			trade_freeboard_itemprice.focus();
			return false;   
		}
		
		console.log(isNaN(trade_freeboard_itemprice.value));
		
		if(isNaN(trade_freeboard_itemprice.value)){
			alert("가격 입력 형식이 잘못되었습니다");
			trade_freeboard_itemprice.focus();
			return false;            
		} 
		
		//글내용 예외처리
		var trade_freeboard_content = document.getElementById("trade_freeboard_content");
		if (trade_freeboard_content.value == "") {
			alert("내용을 입력하세요");
			trade_freeboard_content.focus();
			return false;
		}
		
		
		trade_freeboard_frm.submit();
	}

</script>
</head>
<body>
	
	<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="container-fluid my-5">
		<div class="row">
			<div class="col border-end border-1">
				<!-- 사이드 시작 -->
					<jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
				<!-- 사이드 끝 -->
			</div>
			<div class="col-10 ps-5">
				<!-- 여기부터 -->
				<!-- 본문 시작 -->
				<form id="trade_freeboard_frm" action="${pageContext.request.contextPath }/trade/writeContentProcess.do" method="post" enctype="multipart/form-data">
					<!--제목  -->
					<div class="row border-bottom border-2 pb-2 mb-3 mt-4">
						<div class="col-8">
							<input type="text" name="trade_freeboard_title" id="trade_freeboard_title" class="form-control" placeholder="제목" >
						</div>
						<div class="col">
							<p class="text-end pt-2 mb-0">
								<small><i class="bi bi-person-fill"></i>&nbsp;${sessionUser.member_nick }</small>
							</p>
						</div>
					</div>
					<!--내용  -->
					<div class="row mb-3">
						<div class="col-3">	
							
							<select class="form-select" id="item_category" aria-label="Default select example" name="item_category_no">
								<option>물픔 카테고리</option>
								<c:forEach items="${itemCategoryList}" var="itemCategoryList">
									<option value="${itemCategoryList.item_category_no}">${itemCategoryList.item_category_name}</option>
								</c:forEach>  
								
							</select>
							 

						</div>
						<div class="col-3">
						   
							<input type="text" name="trade_freeboard_itemprice"
								class="form-control" placeholder="물품 가격" id="trade_freeboard_itemprice">
								
						</div>
					</div>
					
					<div class="row mb-3">
					    <div class="col my-2">
						  <div class="form-floating">
							  <textarea class="form-control h-100" name="trade_freeboard_content" id="trade_freeboard_content" placeholder="Leave a comment here" id="floatingTextarea2" col="60" rows="10"></textarea>
							  <label for="floatingTextarea2" style="color:gray;">상품상태  /교환여부  /거래지역을 반드시 입력해주세요.</label>
						   </div>
						</div>
						
					</div>
					<div class="row mb-3">
						<div class="col-5">
							<input class="form-control" type="file" accept="image/*" multiple name="upload_files">
						</div>
						<div class="col d-grid">
						    <button onclick="return tradeWriteContent()" class="btn btn-primary">작성</button>
							
						</div>
						<div class="col d-grid">
							<a class="btn btn-outline-primary" href="${pageContext.request.contextPath }/trade/tradePage.do">취소</a>
						</div>
						
					
					</div>




				</form>
				
				<!-- 본문 끝 -->
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