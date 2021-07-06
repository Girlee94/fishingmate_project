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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mheader.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

</head>
<body>

   <header>
      
      <jsp:include page="/WEB-INF/views/commons/header.jsp" /></jsp:include>
            
   </header> <!-- header -->


   <div class="container-fluid">
      <div class="row">
         <div class="col-sm"></div>
         <div class="col-sm">
            <!-- 헤더 -->
            <div class="row">
               <div class="col">
                  <span id="fnewsposting">Edit 
                     <span id="fpostingb">Posting_</span>
                     <img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70">
                  </span>
                  <hr>
                   <div class="col-4"></div>
                   <div class="col-4" style="align-items:center;">
                   
                   
               </div>
            </div>
            <!-- 바디 -->
            <div class="row">
               <div class="col">
               
               </div>
            </div>



         </div>
         <div class="col-sm">One of three columns</div>
      </div>
   </div>


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


   <div class="container-fluid">
      <div class="row" style="text-align: center;">
         <span id="fnewsposting">Edit <span id="fpostingb">Posting_</span><img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70"></span>
         <hr>
          <div class="col-4"></div>
            <div class="col-4" style="align-items:center;">
           
              <div class=" row mb-3">
              <form action="${pageContext.request.contextPath }/event/updateEventPrecess.do" method="post" enctype="multipart/form-data">
              <div class="row mb-3" style="text-align:left">
                ${sessionUser.member_nick}
              </div>
              <div class="row mb-3">
                <label for="exampleFormControlInput1" class="row form-label position-static">Title</label>
              <input type="text" class="col form-control" value="${data.eventVO.event_freeboard_title }" id="exampleFormControlInput1" style="width:600px; height:30px" name="event_freeboard_title">
            </div>
            <div class="row mb-3">
               <div class="col">
                  <fmt:formatDate pattern="yyyy/MM/dd" value="${data.eventVO.event_freeboard_startdate}"/> - 
                  <input type="date" class="col form-control" value="${data.eventVO.event_freeboard_startdate }" id="exampleFormControlInput1" style="width:600px; height:30px" name="event_freeboard_startdate" >
                  
               </div>
               <div class="col">
                  <fmt:formatDate pattern="yyyy/MM/dd" value="${data.eventVO.event_freeboard_enddate}"/>
                  <input type="date" class="col form-control" value="${data.eventVO.event_freeboard_enddate }" id="exampleFormControlInput1" style="width:600px; height:30px" name="event_freeboard_enddate" >
               </div>
            </div>
            <div class="row mb-3">
              <label for="exampleFormControlTextarea1" class="row form-label position-static">Content</label>
              <textarea class="col form-control" id="exampleFormControlTextarea1" name="event_freeboard_content" style="width:600px; height:200px; margin:5px 5px 5px 0" rows="3">${data.eventVO.event_freeboard_content}</textarea>
            </div>
            <div class="mb-3">
               <input type="hidden" name="manager_no" value="${data.eventVO.manager_no}">
               <input type="hidden" name="event_freeboard_no" value="${data.eventVO.event_freeboard_no}"> 
            <!-- 파일선택 -->   
            <div class="row mb-3">
              <label for="formFileMultiple" class="row form-label"></label>
              <input class="col form-control" type="file" accept="image/*" name="upload_files" style="width:600px;" id="formFileMultiple" multiple>
            </div>   
      <div class="col">         
      <div class="row-2 position-end" id="evntwrt"><button type="submit" formaction="${pageContext.request.contextPath }/manager/managerUpdateProcess.do" class="btn btn-outline-light" style="color: white; float:right; background: #000080">수정</button></div>
       <div class="row-10 position-end" id="evenwrt"><a href="${pageContext.request.contextPath }/manager/managerEventList.do"><button type="button" class="btn btn-outline-light" style="color: white; float:right; background: #000080">취소</button></a></div>
            </div>   
            </div>
            </form>
              </div>
                 
            
            </div>
            <div class="col"></div>
         </div>
   
   </div>
   
   
   
   <!--  -->
   
   <footer>

    <jsp:include page="/WEB-INF/views/commons/managerFooter.jsp"></jsp:include>
    
  </footer> <!-- footer -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>   
</body>
</html>