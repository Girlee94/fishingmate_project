<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
   <jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
   
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
                     <span id="fnewsposting">Edit <span id="fpostingb">Posting_</span><img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70"></span>
                     <hr>
                  </div>
            </div>
              <div class=" row mb-3">
                    <div class="col"></div>
                    <div class="col" align="center">
                       <form action="${pageContext.request.contextPath }/event/updateEventProcess.do" method="post" enctype="multipart/form-data">   
                          <div class="row mb-3">
                             <div class="col">
                               ${sessionUser.member_nick}
                             </div>
                          </div>
                          <div class="row mb-3">
                             <div class="col" align="left">
                               <label for="exampleFormControlInput1" class="row form-label position-static"><h5>Title</h5></label>
                             <input type="text" class="col form-control" value="${data.eventVO.event_freeboard_title}" id="exampleFormControlInput1" style="width:600px; height:30px" name="event_freeboard_title">
                           </div>
                        </div>
                        <div class="row mb-3" align="left">
                           <div class="col">
                             <label for="exampleFormControlTextarea1" class="row form-label position-static"><h5>Content</h5></label>
                             <textarea class="col form-control" id="exampleFormControlTextarea1" name="event_freeboard_content" style="width:600px; height:200px; margin:5px 5px 5px 0" rows="3">${data.eventVO.event_freeboard_content}</textarea>
                           </div>
                        </div>
                        <div class="row mb-3" align="left">
                           <div class="col">
                              <input type="hidden" name="member_no" value="${data.eventVO.member_no}">
                              <input type="hidden" name="event_freeboard_no" value="${data.eventVO.event_freeboard_no}">
                              
                              <!-- 파일선택 -->   
                              <div class="row mb-3">
                                 <div class="col">
                                   <label for="formFileMultiple" class="row form-label"></label>
                                   <input class="col form-control" type="file" accept="image/*" name="upload_files" style="width:600px;" id="formFileMultiple" multiple>
                                 </div>
                              </div>   
                              <div class="col">               
                                 <div class="row-2 position-end" id="evntwrt">
                                    <div class="col">
                                       <button type="submit" class="btn btn-outline-light" style="color: white; float:right; background: #000080">수정</button>
                                    </div>
                                 </div>
                                  <div class="row position-end" id="evenwrt">
                                     <div class="col">
                                        <a href="${pageContext.request.contextPath }/event/eventPage.do"><button type="button" class="btn btn-outline-light" style="color: white; float:right; background: #000080">취소</button></a>
                                     </div>
                                  </div>
                              </div>
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
      <!-- 푸터 -->
      <jsp:include page="/WEB-INF/views/commons/footer.jsp" />
      <!-- 푸터 끝 -->
   </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>   
</body>
</html>