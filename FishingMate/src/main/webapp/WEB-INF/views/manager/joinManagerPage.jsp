<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/execDaumPostcode.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
</head>
<body>
   <div style="width: 1200px; margin: 0 auto;">
   <!-- 헤더 -->
   <jsp:include page="/WEB-INF/views/commons/header.jsp" />
   <!-- 헤더 끝 -->
   <div class="container-fluid">
   <div class="row">
      <div class="col"></div>
      <div class="col-8">
         <div class="row mb-3" style="border: 3px solid orange; border-radius: 2em;">
            <div class="col">
               <div class="row mb-3 mt-2">
                  <div class="col"></div>
                  <div class="col-8 text-center py-2">
                     <h1>관리자 등록</h1>
                     <form action="./joinManagerProcess.do" method="post">
                        <input type="text" name="manager_id" class="form-control" placeholder="아이디"><br>
                        <input type="password" name="manager_pw" class="form-control" placeholder="비밀번호"><br>
                        <input type="text" name="manager_name" class="form-control" placeholder="이름"><br>
                        <input type="text" name="manager_nick" class="form-control" placeholder="닉네임"><br>
                        <input type="text" name="manager_phone" class="form-control" placeholder="전화번호"><br>
                        <input type="text" name="manager_email" class="form-control" placeholder="이메일"><br>
                           
                     <input type="submit" class="btn btn-warning" value="관리자 등록">
                     </form>
                     </div>
               <div class="col"></div>
               </div>
            </div>
         </div>
      </div>
      <div class="col"></div>
   </div>
   </div>
   </div>

   <!-- 푸터 -->
   <jsp:include page="/WEB-INF/views/commons/footer.jsp" />
   <!-- 푸터 끝 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>