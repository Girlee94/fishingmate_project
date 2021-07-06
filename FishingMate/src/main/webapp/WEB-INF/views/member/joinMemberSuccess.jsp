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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<style type="text/css">
   a { text-decoration:none }
   
   #divmb{
      margin-bottom:207px;
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
      <div class="row">
         <div class="col"></div>
         <div class="col-5">
         <div id="divmt"class="col" style="text-align:center;">
               <img src="/fishingmate/resources/img/check_mh.png" width="70" height="70">
               <h3>회원가입이 <strong>완료</strong> 되었습니다</h3>
               낚시의 세계에 가입하신걸 축하드립니다.<br>
            <div id="divmb" class="row border-top border-1 mt-3">
               <div class="col border border-1 mt-5 mb-5" style="height:100px; background-color:#F5F5F5">
                  <br>
                  <a href="${pageContext.request.contextPath }/main/index.do"><img src="/fishingmate/resources/img/home_mh.png" width="40" height="40"><br>
                  <span style="color:black">홈으로</span></a>
               </div>
               <div class="col border border-1 mt-5 mb-5" style="height:100px; background-color:#424242">
                  <br>
                  <a href="./loginPage.do"><img src="/fishingmate/resources/img/enter_mh2.png" width="40" height="40"><br>
                  <span style="color:#FAFAFA">로그인</span></a>
               </div>
            </div>
         </div>
         </div>
         <div class="col"></div>
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