<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<style type="text/css">
   #divmb{
      margin-bottom:241px;
      }
   #divmt{
      margin-top : 100px;
   }
</style>
</head>
<body>
   <div style="width: 1200px; margin: 0 auto;">
      <!-- 헤더 -->
      <jsp:include page="/WEB-INF/views/commons/header.jsp" />
      <!-- 헤더 끝 -->
      <div class="container-fluid mb-5">
         <div class="row">
            <div class="col"></div>
            <div id="divmt" class="col-3 text-center">
               <span class="fw-bold fs-3 mb-4">관리자 LOGIN</span>
               <form action="${pageContext.request.contextPath }/manager/managerLoginProcess.do" method="post">
               <div class="form-floating mb-3">
                  <input type="text" class="form-control" name="manager_id" id="floatingInput" placeholder="ID">
                  <label for="floatingInput">ID</label>
               </div>
               <div class="form-floating mb-3">
                  <input type="password" class="form-control" name="manager_pw" id="floatingInput" placeholder="PW">
                  <label for="floatingInput">PW</label>
               </div>
               <div id="divmb" class="row">
                  <div class="col d-grid">
                     <input class="btn btn-primary btn-lg" type="submit" value="로그인">
                  </div>
                  <div class="col d-grid">
                     <a class="btn btn-secondary btn-lg" href="${pageContext.request.contextPath }/manager/joinManagerPage.do">관리자<br>등록</a>
                  </div>
               </div>
               </form>
            </div>
            <div class="col"></div>
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