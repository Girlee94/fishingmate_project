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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/eventPPP.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">


<script type="text/javascript">

   var sessionMemberNo = null;
   var event_freeboard_no = ${list.eventVO.event_freeboard_no};
   
   function getSessionMemberNo(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         
         sessionMemberNo = obj.member_no;
      }
   };
   
   xmlhttp.open("get","${pageContext.request.contextPath}/event/getSessionMemberNo.do", true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();      

}
   
   function recommend(){
      
      if(sessionMemberNo == null){
         location.href="${pageContext.request.contextPath}/member/loginPage.do";
         return;
      }
      
      //AJAX 호출.....
      var xmlhttp = new XMLHttpRequest();
      
      //호출 후 값을 받았을때... 처리 로직....
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            //var obj = JSON.parse(xmlhttp.responseText);
            refreshRecommend();
         }
      };
      
      xmlhttp.open("post","./recommend.do", true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("event_freeboard_no="+event_freeboard_no);      

   }
   
   function deleteRecommend(){
      
      if(sessionMemberNo == null){
         location.href="${pageContext.request.contextPath}/member/loginPage.do";
         return;
      }
      
      //AJAX 호출.....
      var xmlhttp = new XMLHttpRequest();
      
      //호출 후 값을 받았을때... 처리 로직....
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            //var obj = JSON.parse(xmlhttp.responseText);
            refreshRecommend();
         }
      };
      
      xmlhttp.open("post","./deleteRecommend.do", true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("event_freeboard_no="+event_freeboard_no);      

   }   
   
   function refreshRecommend(){
      //AJAX 호출.....
      var xmlhttp = new XMLHttpRequest();
      
      //호출 후 값을 받았을때... 처리 로직....
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            var obj = JSON.parse(xmlhttp.responseText);
            
            var recommendCountBox = document.getElementById("recommendCountBox");
            var recommendButton = document.getElementById("recommendButton");
            var recommendImage = document.createElement("img");
         
            if(obj.myRecommendCount <= 0){
               /* var a1 = document.createElement("a");
               a1.setAttribute("href", "#");
               a1.setAttribute("onclick", "recommend(); return false;");
               a1.setAttribute("style", "margin-right:10px;"); */
               
               recommendButton.innerText="";
               recommendImage.setAttribute("src","/fishingmate/resources/img/recommend_mh.png");
               recommendButton.setAttribute("onclick", "recommend(); return false;");
               recommendImage.setAttribute("width","30");
               
               recommendCountBox.innerText = obj.recommendCount;
            }else{
               
               recommendButton.innerText="";
               recommendImage.setAttribute("src","/fishingmate/resources/img/recommend2_mh.png");
               recommendButton.setAttribute("onclick", "deleteRecommend(); return false;");
               recommendImage.setAttribute("width","30");
               
               recommendCountBox.innerText = obj.recommendCount;
            }
            
               recommendButton.appendChild(recommendImage);
               var recommendCountBox = document.getElementById("recommendCountBox");
         }
      };
      
      xmlhttp.open("get","./getRecommendData.do?event_freeboard_no=" + event_freeboard_no, true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send();      

   }
   
   function wishlist(){
      
      if(sessionMemberNo == null){
         location.href="${pageContext.request.contextPath}/member/loginPage.do";
         return;
      }
      
      //AJAX 호출.....
      var xmlhttp = new XMLHttpRequest();
      
      //호출 후 값을 받았을때... 처리 로직....
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            //var obj = JSON.parse(xmlhttp.responseText);
            refreshWishlist();
         }
      };
      
      xmlhttp.open("post","./wishlist.do", true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("event_freeboard_no="+event_freeboard_no);      

   }
   
   function deletewishlist(){
      if(sessionMemberNo == null){
         location.href="${pageContext.request.contextPath}/member/loginPage.do";
         return;
      }
      
      //AJAX 호출.....
      var xmlhttp = new XMLHttpRequest();
      
      //호출 후 값을 받았을때... 처리 로직....
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            //var obj = JSON.parse(xmlhttp.responseText);
            refreshWishlist();
         }
      };
      
      xmlhttp.open("post","./deleteWishlist.do", true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("event_freeboard_no="+event_freeboard_no);      

   }   
   
   
    function refreshWishlist(){
      //AJAX 호출.....
      var xmlhttp = new XMLHttpRequest();
      
      //호출 후 값을 받았을때... 처리 로직....
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            var obj = JSON.parse(xmlhttp.responseText);
            
            var recommendCountBox = document.getElementById("recommendCountBox");
            var wishlistButton = document.getElementById("wishlistButton");
            var wishlistImage = document.createElement("img");
            wishlistButton.innerText="";
            
             if(obj.wishlistCount <= 0){
               
                wishlistButton.innerText="";
                wishlistButton.setAttribute("onclick", "wishlist(); return false;");
                wishlistImage.setAttribute("src","/fishingmate/resources/img/cat_paw_1.png");
                wishlistImage.setAttribute("width","30");
                
                
             }else{
                
                wishlistButton.innerText="";
                wishlistButton.setAttribute("onclick", "deletewishlist(); return false;");
                wishlistImage.setAttribute("src","/fishingmate/resources/img/cat_paw_2.png");
                wishlistImage.setAttribute("width","30");
             }
             
            
               
             wishlistButton.appendChild(wishlistImage);
            var recommendCountBox = document.getElementById("recommendCountBox");
            /* recommendCountBox.innerText = obj.wishlistCount; */
            
            
         }
      };
      
      xmlhttp.open("get","./getWishlistData.do?event_freeboard_no=" + event_freeboard_no, true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send();      

   } 
   
   
   function init(){
      getSessionMemberNo();
      refreshRecommend();
      refreshWishlist();
   }

   
   
   
   
</script>
   <style type="text/css">
   a { text-decoration:none } 
   </style>

</head>
<body onload="init()">

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
             <div class="row my-4">
                  <div class="col-1"></div>
                  <div class="col-6 border-bottom border-2">
                     <p class="h2 mt-2">${num}${list.eventVO.event_freeboard_title }</p>
                  </div>
                  <div class="col border-bottom border-2 position-relative">
                     <span class="position-absolute top-50 end-0 translate-middle-y">
                     <small>
                        <i class="bi bi-person-fill"></i>&nbsp;<b>${list.memberVO.member_nick }</b> &nbsp;&nbsp;
                        <i class="bi bi-eye-fill"></i>&nbsp;${list.eventVO.event_freeboard_readcount }&nbsp;&nbsp;
                        <i class="bi bi-heart-fill"></i>&nbsp;<span id="recommendCountBox">${list.eventVO.event_freeboard_readcount }</span>&nbsp;&nbsp;
                        <i class="bi bi-calendar-check"></i>&nbsp;<fmt:formatDate value="${list.eventVO.event_freeboard_startdate}" pattern="yyyy.MM.dd" />~<fmt:formatDate value="${list.eventVO.event_freeboard_enddate}" pattern="yyyy.MM.dd" />
                     </small>
                     </span>
                  </div>
             </div>
            <div class="row">
               <div class="col-1"></div>
               <div class="col p-3 border border-1 me-1 text-center">
                   <div id="carouselExampleIndicators">
                     <c:forEach items="${imageList}" var="image">
                        <div class=" row mb-3">
                           <div class="col">
                              <img width="800" height="450" src="/upload_files/${image.image_location}">
                           </div>
                        </div>
                      </c:forEach>   
                  </div>   
               </div>         
            </div>
            <div class="row mt-3">
               <div class="col-1"></div>
               <!-- 내용 -->  
               <div class="col border border-1 p-3" style="height: 300px; overflow-x: hidden;">             
                  ${list.eventVO.event_freeboard_content }
               </div>
            </div>
            <div class="row mt-3 mb-3">
               <div class="col"></div>
               <div id="recommendBox" class="col-2">
               <button id="recommendButton" class="border-0" type="button" style="background : none;"></button>
               <button id="wishlistButton" class="border-0" type="button" style="background : none;"></button>
               &nbsp;<span id="recommendCountBox"></span>
               </div>
            </div>   
            <div class="row">
                 <div class="col-1"></div>
               <div class="col border-bottom border-1 p-0">
               </div> 
            </div>
            
            
            <div class="row text-end mt-3 mb-3"> 
              <div class="col"></div>
              <div class="col-3">
                 <c:if test="${!empty sessionUser && list.eventVO.member_no == sessionUser.member_no}">
                     <a href="${pageContext.request.contextPath }/event/updateEventPage.do?event_freeboard_no=${list.eventVO.event_freeboard_no}"><i style="font-size: 25px; color: blue;" class="bi bi-pencil-square"></i>수정</button></a>
                 </c:if>
                 <a href="${pageContext.request.contextPath}/event/eventPage.do?searchNo=1" style=" color:black; text-decoration:none"><i style="font-size: 25px; color: black;"class="bi bi-house-door-fill"></i>&nbsp;목록으로</a><!-- 홈 -->
              </div>
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