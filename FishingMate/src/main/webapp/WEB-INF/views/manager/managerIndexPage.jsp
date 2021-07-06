<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mheader.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

</head>
<body>
   <!-- 헤더 -->
   <jsp:include page="/WEB-INF/views/commons/managerHeader.jsp"/>
   <!-- 헤더 끝 -->

    
    <!-- 이벤트 배너 -->
   <div class="row">
      <div class="col"></div>
      <div class="col-8">
         <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
               <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
               <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
               <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
               <div class="carousel-item active">
                  <img id="carousel-item-img" src="${pageContext.request.contextPath }/resources/img/fishing_loving_everyday.png" class="d-block w-100 img-fluid">
                  <div class="carousel-caption d-none d-md-block">
                  <h5>First slide label</h5>
                  <p>Some representative placeholder content for the first slide.</p>
                  </div>
               </div>
               <div class="carousel-item">
                  <img id="carousel-item-img" src="${pageContext.request.contextPath }/resources/img/festival16_1.jpg" class="d-block w-100 img-fluid">
                  <div class="carousel-caption d-none d-md-block">
                  <h5>Second slide label</h5>
                  <p>Some representative placeholder content for the second slide.</p>
                  </div>
               </div>
               <div class="carousel-item">
                  <img id="carousel-item-img" src="${pageContext.request.contextPath }/resources/img/festival11_3.jpg" class="d-block w-100 img-fluid">
                  <div class="carousel-caption d-none d-md-block">
                     <h5>Third slide label</h5>
                     <p>Some representative placeholder content for the third slide.</p>
                  </div>
               </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
               <span class="carousel-control-prev-icon" aria-hidden="true"></span>
               <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
               <span class="carousel-control-next-icon" aria-hidden="true"></span>
               <span class="visually-hidden">Next</span>
            </button>
         </div>
      </div>
      <div class="col"></div>
   </div>
   <!-- 이벤트 배너 끝 -->
 
 
 
 
   <!-- 푸터 -->
   <jsp:include page="/WEB-INF/views/commons/managerFooter.jsp" />
   <!-- 푸터 끝 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>