<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   .card_box{
      display: flex;
      flex-wrap: wrap;
      float: left;
      justify-content: center;
   }
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mheader.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/eventPPP.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">

</head>
<body>
   
   
   <div style="width: 1200px; margin: 0 auto;">
   <!-- 헤더 -->
   <jsp:include page="/WEB-INF/views/commons/header.jsp" />
   <!-- 헤더 끝 -->
   
   <div class="container-fluid">
      <div class="row">
         <div class="col border-end border-1">
            <!-- 사이드 시작 -->
               <jsp:include page="/WEB-INF/views/commons/eventPeriod.jsp" />
            <!-- 사이드 끝 -->
         </div>
         <div class="col-10">
            <div class="row mt-3">
               <div class="col-1"></div>
               <div class="col" align="center">
                  <span id="festival"><img src="${pageContext.request.contextPath }/resources/img/fishing_loving_everyday.png" width="70" height="70">Fishing Festival_Manager</span>
                  <hr>
               </div>
            </div>
            <!-- 카드 -->
            <div class="row align-items-start mt-3">
               <div class="col-1"></div>
               <div class="col">
                  <div class="row">
                  <c:forEach items="${freeboardList}" var="list">
                     <%-- <c:if test="${list.eventVO.event_freeboard_approve != 'N'}"> --%>
                        <div class="col-3 card mt-3 me-1 ms-1 p-0" style="width: 26%;">
                           <a href="${pageContext.request.contextPath }/manager/managerReadPage.do?event_freeboard_no=${list.eventVO.event_freeboard_no}">
                           <img style="width: 100%; height: 13rem;" src="/upload_files/${list.imageList[0].image_location}" class="img-fluid" alt="...">
                           <div class="card-body me-2" style="width: 100%; text-align: center;">
                              <h5 class="card-title fs-3" style="width: 100%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${list.eventVO.event_freeboard_title}</h5>
                              
                                 <div class="row">
                                    <div class="col-1"><i class="bi bi-person"></i></div>
                                    <div class="col-6 pe-0 me-0">${list.memberVO.member_nick}</div>
                                    <div class="col-1"><i class="bi bi-heart-fill"></i></div>
                                    <div class="col-3 pe-0 me-0">${list.recommendCount}</div>
                                 </div>
                                                            
                                 <div class="row fs-6">
                                    <div class="col-1">
                                       <i class="bi bi-stopwatch"></i>
                                    </div>
                                    <div class="col-6 pe-0 me-0">
                                       <small>
                                          <fmt:formatDate pattern="MM/dd" value="${list.eventVO.event_freeboard_startdate}" />~<fmt:formatDate pattern="MM/dd" value="${list.eventVO.event_freeboard_enddate}" />
                                       </small>
                                    </div>
                                    <div class="col-1">
                                       <i class="bi bi-eye"></i>   
                                    </div>
                                    <div class="col-3 pe-0 me-0">${list.eventVO.event_freeboard_readcount}</div>
                                 </div>
                           </div>
                           </a>
                        </div>
                  </c:forEach>
                  </div>
            <hr>
         
                   <!-- 페이지네이션 -->
                   <div class="row">
                       <div class="col-4"></div>
                       <div class="col-4" style="align-items:center;" id="eventpgnation" >
                           
                            <ul style="text-align:center;" class="pagination justify-content-center">
                              <li style="margin-left:0px; margin-right:0px; text-align:center;" class="page-item disabled mx-0">
                                 <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Prev</a>
                               </li>
                               <li style="margin-left:0px; margin-right:0px; text-align:center;" class="page-item mx-0"><a class="page-link" href="#">1</a></li>
                               <li style="margin-left:0px; margin-right:0px; text-align:center;" class="page-item active mx-0" aria-current="page">
                                 <a class="page-link" href="#">2</a>
                               </li>
                               <li style="margin-left:0px; margin-right:0px; text-align:center;" class="page-item mx-0"><a class="page-link" href="#">3</a></li>
                               <li style="margin-left:0px; margin-right:0px; text-align:center;" class="page-item mx-0">
                                 <a class="page-link" href="#">Next</a>
                               </li>
                            </ul>
                        
                        </div>
                        <div class="col-4" id="eventbttm"><a href="${pageContext.request.contextPath }/event/eventWritePage.do"><button type="button" class="btn btn-outline-light" style="color: white; float:right; background: #000080">수정</button></a></div>
                       </div>
                       
                       </div>
               
                  </div>
            
                   
                   </div>
                   </div>
                </div>
             </div>

<!--  -->

  <footer>

    <jsp:include page="/WEB-INF/views/commons/footer.jsp" />
    
  </footer> <!-- footer -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>