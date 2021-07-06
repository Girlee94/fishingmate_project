<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
   function loginConfirm(){
      if(${empty sessionUser}){
         alert("로그인을 해주세요");
         location.href="${pageContext.request.contextPath}/member/loginPage.do";
         return;
      }else{
         form1.submit();
         return;
      }
   }
   
   function setEndMin(){
      var startdate = document.getElementById("startdate");
      var enddate = document.getElementById("enddate");
      
      enddate.min = startdate.value;
   }
   
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/eventPPP.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

</head>
<body>
   
   <div style="width: 1200px; margin: 0 auto;">
      <header>
         <jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
      </header> <!-- header -->
   
      <div class="container-fluid">
         <div class="row">
            <div class="col border-end border-1">
               <!-- 사이드 시작 -->
                  <jsp:include page="/WEB-INF/views/commons/eventPeriod.jsp" />
               <!-- 사이드 끝 -->
            </div>
            <div class="col-10" style="text-align: center;">
            
               <div class="row">
                  <div class="col-1"></div>
                  <div class="col">
                     <span id="fnewsposting">Festival News <span id="fpostingb">Posting_</span><img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70"></span>
                     <hr>
                  </div>
               </div>
               <!--  -->
               <div class="row mb-3">
                  <div class="col"></div>
                  <div class="col" align="center">
                     <form id="form1" action="${pageContext.request.contextPath }/event/eventWriteProcess.do" method="post" enctype="multipart/form-data">
                        <!-- 닉네임  -->
                        <div class="row mb-3">
                           <div class="col">
                              ${sessionUser.member_nick}
                           </div>
                        </div>
                        <!-- 제목 -->
                        <div class="row mb-3">
                           <div class="col" align="left">
                              <h5>Title</h5>
                               <input type="text" class="col form-control" id="exampleFormControlInput1" style="width:600px; height:30px" name="event_freeboard_title">
                           </div>
                        </div>   
                        <!-- 날짜 헤더 -->
                        <div class="row mb-3">
                           <div class="col" align="left">
                              <h5>Festival Period</h5>
                           </div>
                        </div>
                        
                        <!-- 날짜 선택 -->
                        <div class="row mb-3">
                           <div class="col">
                              <input id="startdate" type="date" name="event_freeboard_startdate" class="form-control" onchange="setEndMin()">
                           </div>
                           <div class="col-1">
                              ~
                           </div>
                           <div class="col">
                              <input id="enddate" type="date" name="event_freeboard_enddate" class="form-control">
                           </div>
                        </div>   
                        
                        <!-- 내용 -->
                        <div class="row mb-3">
                           <div class="col" align="left">
                              <h5>Content</h5>
                                <textarea class="col form-control" id="exampleFormControlTextarea1" name="event_freeboard_content" style="width:600px; height:200px; margin:5px 5px 5px 0" rows="3"></textarea>
                           </div>
                        </div>
                        <!-- 파일 선택 이미지 업로드 -->
                        <div class="row mb-3">
                        <div class="col">
                           <label for="formFileMultiple" class="row form-label"></label>
                             <input class="col form-control" type="file" accept="image/*" name="upload_files" style="width:600px;" id="formFileMultiple" multiple>
                        </div>
                        </div>
                        <div class="row mb-3">
                        <div class="col">
                           <div class="row-2 position-end" id="evntwrt"><button type="button" formaction="${pageContext.request.contextPath }/event/eventWriteProcess.do" class="btn btn-outline-light" style="color: white; float:right; background: #000080" onclick="loginConfirm()">완료</button></div>
                            <div class="row-10 position-end" id="evenwrt"><a href="${pageContext.request.contextPath }/event/eventPage.do"><button type="button" class="btn btn-outline-light" style="color: white; float:right; background: #000080">취소</button></a></div>
                        </div>
                        </div>
                     </form>
                  </div>
                  <div class="col"></div>
               </div>
            
               
               
               
            </div>
         </div>
      </div>
   </div>

<!--  -->
   
   <div style="width: 100%; margin: 0 auto;">
      <footer>
       <jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
       </footer> <!-- footer -->
   </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>