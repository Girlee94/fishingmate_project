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
                     <h1>회원 가입</h1>
                     <form action="./joinMemberProcess.do" method="post">
                        <input type="text" name="member_id" class="form-control" placeholder="아이디"><br>
                        <input type="password" name="member_pw" class="form-control" placeholder="비밀번호"><br>
                        <input type="text" name="member_name" class="form-control" placeholder="이름"><br>
                        <input type="text" name="member_nick" class="form-control" placeholder="닉네임"><br>
                        <input type="radio" class="btn-check" name="member_gender" value="M" id="btnradio1" autocomplete="off" checked><label class="btn btn-outline-warning" for="btnradio1"><i class="bi bi-gender-male"></i></label>
                        <input type="radio" class="btn-check" name="member_gender" value="F" id="btnradio2" autocomplete="off"><label class="btn btn-outline-warning" for="btnradio2"><i class="bi bi-gender-female"></i></label><br><br>
                        
                        <img src="/fishingmate/resources/img/birth_icon.png" width="20" height="20">&nbsp;생일
                        <input type="date" name="member_birth" class="form-control" placeholder="생년월일"><br>
                        <input type="text" name="member_phone" class="form-control" placeholder="전화번호"><br>
                        <input type="text" name="member_email" class="form-control" placeholder="이메일"><br>
                        <img src="/fishingmate/resources/img/address_home.png" width="20" height="20">&nbsp;주소<hr>
                        
                            <input type="text" id="sample4_postcode" class="form-control" placeholder="우편번호" onclick="sample4_execDaumPostcode()"><br>
                            <input type="text" name="member_roadAddress" id="sample4_roadAddress" class="form-control" placeholder="도로명주소"><br>
                            <span id="guide" style="color:#999;display:none"></span>
                             <input type="text" name="member_jibunAddress" id="sample4_jibunAddress" class="form-control" placeholder="지번주소"><br>
                            <input type="text" name="member_detailAddress" id="sample4_detailAddress" class="form-control" placeholder="상세주소"><br>
                            <input type="text" name="member_extraAddress" id="sample4_extraAddress" class="form-control" placeholder="참고항목"><br>
                            <input type="submit" class="btn btn-warning" value="회원 가입">
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