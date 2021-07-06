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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/index.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<style type="text/css">

</style>
</head>
<body onload="init()">
   
   <!-- 이벤트 배너 -->
      <div style="width: 1200px; margin: 0 auto;">
         <!-- 헤더 -->
         <jsp:include page="/WEB-INF/views/commons/header.jsp" />
         <!-- 헤더 끝 -->
      </div>
      
         <div style="width: 1200px; margin: 0 auto;">
         <div class="container-fluid mt-5 mb-3">
            <div class="row">
               <div class="col">
                  <div id="carouselExampleCaptions" class="carousel slide border-bottom border-1 pb-3" data-bs-ride="carousel">
                     <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
                     </div>
                     <div class="carousel-inner">
                        <div class="carousel-item active">
                           <img id="carousel-item-img" src="${pageContext.request.contextPath }/resources/img/gone_fishing.png" class="d-block w-100 img-fluid">
                        </div>
                        <div class="carousel-item">
                           <img id="carousel-item-img" src="${pageContext.request.contextPath }/resources/img/1.png" class="d-block w-100 img-fluid">
                        </div>
                        <div class="carousel-item">
                           <img id="carousel-item-img" src="${pageContext.request.contextPath }/resources/img/2.png" class="d-block w-100 img-fluid">
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
                  <div id="carouselExampleControls" class="carousel slide mt-3 mb-3" data-bs-ride="carousel">
                     <div class="carousel-inner">
                        <div class="carousel-item active text-center">
                           <span style="font-size: 35px; color:#32438e; font-weight:bold;">
                                  	자랑 게시판          
                           </span>
                        </div> 
                        <div class="carousel-item text-center">
                           <span style="font-size: 35px; color:#8691c0; font-weight:bold;">
                             	 메이트 게시판
                           </span>
                        </div>
                        <div class="carousel-item text-center">
                           <span style="font-size: 35px; color:#106612; font-weight:bold;">
                                 	정보 게시판
                           </span>
                        </div>
                        <div class="carousel-item text-center">
                           <span style="font-size: 35px; color:#800000; font-weight:bold;">  
                                  	자유 게시판
                           </span>
                        </div>   
                        <div class="carousel-item text-center">
                           <span style="font-size: 35px; color:#b95A87; font-weight:bold;">
                                  	중고거래 게시판   
                           </span>
                        </div>
                     </div>
                     <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev" style="width: 25px;">
                        <img src="${pageContext.request.contextPath}/resources/img/left-arrow.png">
                     </button>
                     <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next" style="width: 25px;">
                        <img src="${pageContext.request.contextPath}/resources/img/right-arrow.png">
                     </button>
                  </div>
                  <div class="row mb-4 mt-2 " style="height:500px;">
                     <div class="col-4 p-0" style="background-color: #edf3fa;">
                        <div class="row text-center mt-3 mb-1"><span class="fw-bold fs-4 mt-2 mb-0"> <img src="${pageContext.request.contextPath}/resources/img/loud-speaker.png" width="24" height="24">&nbsp; NOTICE</span></div>
                        <div class="row p-3">
                            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">   
                             <div class="carousel-indicators">
                               <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                               <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                               <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                             </div>
                             <div class="carousel-inner text-center">
                               <div class="carousel-item active">
                                 <img src="${pageContext.request.contextPath}/resources/img/eventImag.jpg" width="300" height="350" >                                 
                               </div>
                               <div class="carousel-item">
                                 <img src="${pageContext.request.contextPath}/resources/img/fishevent.png" width="300" height="350" >
                               </div>
                               <div class="carousel-item">
                                 <img src="${pageContext.request.contextPath}/resources/img/fishmag.jpg" width="300" height="350" >
                               </div>   
                             </div>  
                             <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev" >
                               <span class="carousel-control-prev-icon" aria-hidden="true" style="color:red;"></span>
                               <span class="visually-hidden">Previous</span>
                             </button>
                             <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                               <span class="carousel-control-next-icon" aria-hidden="true"></span>
                               <span class="visually-hidden">Next</span>
                             </button>
                           </div>
                             
                        </div>
                        </div>
                        
	                     <div class="col ps-4">
	                        <div class="row align-items-start" id="all_card_list"></div>
	                        <div class="row mt-1">
	                           <div class="col text-end border-bottom border-3 pb-2 mb-2">
	                              <span class="text-muted align-bottom">
	                                  <small>
	                                    <a href="${pageContext.request.contextPath }/main/boast.do" class="text-muted" id="move_listPage">+전체보기</a>
	                                 </small>
	                              </span>
	                           </div>
	                        </div>
	                        <div class="row">
	                        	<div class="col">
	                        		<div class="row mb-3 align-bottom text-center">
	                        			<div class="col">
	                        				<span class="fw-bold fs-5">
	                        					Q&A
	                        				</span>
	                        			</div>
	                        		</div>   
	                        		<c:forEach items="${latestQnaContentList }" var="qnaList">
	                        			<div class="d-flex mt-0 my-3 border-bottom border-1 pb-1">
	                        				<div class="me-3 pe-2 fw-bold">
	                        					${qnaList.QNA_CATEGORY_NAME }
	                        				</div>
		                        			<div>
		                        				<a class="text-decoration-none text-dark" href="${pageContext.request.contextPath }/qna/QnaListPage.do">
		                        					${qnaList.QNA_FREEBOARD_TITLE }
		                        				</a>
		                        			</div>
		                        			<div class="ms-auto">
		                        				<small>
		                        					<fmt:formatDate value="${qnaList.QNA_FREEBOARD_WRITEDATE }" pattern="yyyy/MM/dd"/>
		                        				</small>
		                        			</div>
		                        		</div>
	                        		</c:forEach>
	                        	</div>
	                        </div>
	                     </div>
                     </div> 
                  </div>
                  </div>
                  </div>
               </div>
               
               <div style="width: 100%; margin: 0 auto; background-color: #f7f7f7;">
                  <div style="width: 1200px; margin: 0 auto;">
                     <div class="container-fluid mt-5 mb-4">
                        <div class="row">
                           <div class="col">
                              <div class="row pt-4 mb-3">
                                 <div class="col text-center">
                                    <span class="fs-4 fw-bold" >GAMES</span>
                                 </div>
                              </div>
                              <div class="row pb-4">
                                 <div class="col">
                                    <div class="row" id="fishingGame_icons">
                                       <div id="fishingdiv" class="col-3 text-center" onmouseover="fishingmouse()" onmouseout="fishingimg()">
                                             <a id="fishinga" href="${pageContext.request.contextPath }/fishingGame/fishingGame.do">
                                                <img class="mb-2 rounded-circle" id="fishingimg">
                                                <span id="fishingspan"></span>
                                             </a>
                                          </div>
                                          <div id="fishsharediv" class="col-3 text-center" onmouseover="fishsharemouse()" onmouseout="fishshareimg()">
                                             <a id="fishsharea" href="${pageContext.request.contextPath }/fishingshare/fishingshare.do">
                                                <img class="mb-2 rounded-circle" id="fishshareimg">
                                                <span id="fishsharespan"></span>
                                             </a>
                                          </div>
                                          <div id="dicediv" class="col-3 text-center" onmouseover="dicemouse()" onmouseout="diceimg()">
                                             <a id="dicea" href="${pageContext.request.contextPath }/dice/dicePage.do">
                                                <img class="mb-2 rounded-circle" id="diceimg">
                                                <span id="dicespan"></span>
                                             </a>
                                          </div>
                                          <div id="lottodiv" class="col-3 text-center" onmouseover="lottomouse()" onmouseout="lottoimg()">
                                             <a id="lottoa" href="${pageContext.request.contextPath }/infofreeboard/lotto45.do">
                                                <img class="mb-2 rounded-circle" id="lottoimg">
                                                <span id="lottospan"></span>
                                             </a>
                                          </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
                  
         <div style="width: 1200px; margin: 0 auto;">
            <div class="container-fluid mb-5 mt-2">
               <div class="row">
                  <div class="col">
                     <div class="row">
                        <div class="col">
                           <div class="row">
                              <div class="col">
                                 <div class="row">
                                    <div class="col-6 border-end " >
                                       <div class="row mt-3 mb-3 ps-4" style="font-size:23px; font-weight:bold;">
                                          COUNSELING
                                       </div>
                                        <div class="row pe-3 ps-3">
                                          <img src="${pageContext.request.contextPath }/resources/img/banerbaner1.jpg" height="280px" width="520px">
                                       </div>
                                    </div>
                                    <div class="col-6" >
                                       <div class="row mt-3 mb-3 ps-4" style="font-size:23px; font-weight:bold;">
                                          INTRODUCTION
                                       </div>
                                        <div class="row pe-3 ps-3">
                                          <img src="${pageContext.request.contextPath }/resources/img/banerbaner2.png" height="280px" width="520px">
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
   <!-- 이벤트 배너 끝 -->



   <!-- 푸터 -->
   <div style="width: 100%; margin: 0 auto;">
      <jsp:include page="/WEB-INF/views/commons/footer.jsp" />
   </div>
   <!-- 푸터 끝 -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<script type="text/javascript">

var myCarousel = document.getElementById('carouselExampleControls');

myCarousel.addEventListener('slid.bs.carousel', function(e) {
   getLatestThreeContents(e.to);
});

//페이지 이동
function moveSelectContentPage(contentNode) {
   location.href = contentNode.children[0].value;
}


//최신글 가져오기
function getLatestThreeContents(freeboard_type){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         
         var all_card_list = document.getElementById("all_card_list");
         var contextRoute = obj.contextRoute;
         
         var move_listPage = document.getElementById("move_listPage");
         move_listPage.setAttribute("href", "${pageContext.request.contextPath}/" + obj.pageRoute);
         
//          var list_name = document.getElementById("list_name");
//          list_name.innerText = obj.freeboardName;
         
         all_card_list.innerText = "";

         for(var latestContentList of obj.latestContentList){
            var contentColBox = document.createElement("div");
            contentColBox.setAttribute("class", "col-4");
            
            var contentCardBox = document.createElement("div");
            contentCardBox.setAttribute("id", "latest_cards");
            contentCardBox.setAttribute("class", "card border-0");
            contentCardBox.setAttribute("onclick", "moveSelectContentPage(this)");
            
            var contentHiddenLink = document.createElement("input");
            contentHiddenLink.setAttribute("type", "hidden");
            contentHiddenLink.setAttribute("value", "${pageContext.request.contextPath}/" + contextRoute + latestContentList.latestFreeboardVO.FREEBOARD_NO);
            contentCardBox.appendChild(contentHiddenLink);
            
            var contentImgBox = document.createElement("img");
            if (latestContentList.contentImageVO[0] != null) {
               contentImgBox.setAttribute("src", "/upload_files/" + latestContentList.contentImageVO[0].IMAGE_LOCATION);
            } else {
               contentImgBox.setAttribute("src", "/fishingmate/resources/img/noimage.gif");
            }
            
            contentImgBox.setAttribute("class", "card-img-top");
            contentCardBox.appendChild(contentImgBox);
            
            var contentCardBodyBox = document.createElement("div");
            contentCardBodyBox.setAttribute("class", "card-body text-truncate ps-0");
            
            var contentCardTitleBox = document.createElement("span");
            contentCardTitleBox.setAttribute("class", "card-title ps-2");
            contentCardTitleBox.setAttribute("style", "border-left: 3px solid " + obj.titleColor + "; color: black;");
            contentCardTitleBox.innerText = latestContentList.latestFreeboardVO.FREEBOARD_TITLE;
            contentCardBodyBox.appendChild(contentCardTitleBox);
            contentCardBox.appendChild(contentCardBodyBox);
            contentColBox.appendChild(contentCardBox);
            all_card_list.appendChild(contentColBox);
         }
         
      }
   };
   xmlhttp.open("get","${pageContext.request.contextPath}/main/getLatestThreeContents.do?freeboard_type=" + freeboard_type ,true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();
   
   }
   

   //낚시 마우스 없을때 - 명화
   function fishingimg(){
      
      var fishingdiv = document.getElementById("fishingdiv");
      
      var fishinga = document.getElementById("fishinga");
      var fishingimg = document.getElementById("fishingimg");
      var fishingspan = document.getElementById("fishingspan");
      
      fishingimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/fishingmh.png");
      fishingimg.setAttribute("width","300");
      fishingimg.setAttribute("height","200");
      
      fishingspan.setAttribute("class","fw-bold");
      fishingspan.innerText = "FISHING";
      
      fishinga.appendChild(fishingimg);
      fishinga.appendChild(fishingspan);
      fishingdiv.appendChild(fishinga);
      
   }//낚시 마우스 있을때 - 명화
   function fishingmouse(){
      var fishingdiv = document.getElementById("fishingdiv");
      
      var fishinga = document.getElementById("fishinga");
      var fishingimg = document.getElementById("fishingimg");
      var fishingspan = document.getElementById("fishingspan");
      
      fishingimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/fishingmh2.png");
      fishingimg.setAttribute("width","300");
      fishingimg.setAttribute("height","200");
            
      fishingspan.setAttribute("class","fw-bold");
      fishingspan.innerText = "FISHING";
      
      fishinga.appendChild(fishingimg);
      fishinga.appendChild(fishingspan);
      fishingdiv.appendChild(fishinga);
   }//주식 마우스 있을때 - 명화
   function fishshareimg(){
      var fishsharediv = document.getElementById("fishsharediv");
      
      var fishsharea = document.getElementById("fishsharea");
      var fishshareimg = document.getElementById("fishshareimg");
      var fishsharespan = document.getElementById("fishsharespan");
      
      fishshareimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/graphmh.jpeg");
      fishshareimg.setAttribute("width","300");
      fishshareimg.setAttribute("height","200");
            
      fishsharespan.setAttribute("class","fw-bold");
      fishsharespan.innerText = "STOCK";
      
      fishsharea.appendChild(fishshareimg);
      fishsharea.appendChild(fishsharespan);
      fishsharediv.appendChild(fishsharea);
   }//주식 마우스 없을때 - 명화
   function fishsharemouse(){
      var fishsharediv = document.getElementById("fishsharediv");
      
      var fishsharea = document.getElementById("fishsharea");
      var fishshareimg = document.getElementById("fishshareimg");
      var fishsharespan = document.getElementById("fishsharespan");
      
      fishshareimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/graphmh2.jpg");
      fishshareimg.setAttribute("width","300");
      fishshareimg.setAttribute("height","200");
            
      fishsharespan.setAttribute("class","fw-bold");
      fishsharespan.innerText = "STOCK";
      
      fishsharea.appendChild(fishshareimg);
      fishsharea.appendChild(fishsharespan);
      fishsharediv.appendChild(fishsharea);
   }//주사위 마우스 있을때 - 명화
   function diceimg(){
      var dicediv = document.getElementById("dicediv");
      
      var dicea = document.getElementById("dicea");
      var diceimg = document.getElementById("diceimg");
      var dicespan = document.getElementById("dicespan");
      
      diceimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/dicemh2.png");
      diceimg.setAttribute("width","300");
      diceimg.setAttribute("height","200");
            
      dicespan.setAttribute("class","fw-bold");
      dicespan.innerText = "DICE";
      
      dicea.appendChild(diceimg);
      dicea.appendChild(dicespan);
      dicediv.appendChild(dicea);
   }
   //주사위 마우스 있을때 - 명화
   function dicemouse(){
      var dicediv = document.getElementById("dicediv");
      
      var dicea = document.getElementById("dicea");
      var diceimg = document.getElementById("diceimg");
      var dicespan = document.getElementById("dicespan");
      
      diceimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/dicemh.png");
      diceimg.setAttribute("width","300");
      diceimg.setAttribute("height","200");
            
      dicespan.setAttribute("class","fw-bold");
      dicespan.innerText = "DICE";
      
      dicea.appendChild(diceimg);
      dicea.appendChild(dicespan);
      dicediv.appendChild(dicea);
   }//로또 마우스 없을때 - 명화
   function lottoimg(){
      var lottodiv = document.getElementById("lottodiv");
      
      var lottoa = document.getElementById("lottoa");
      var lottoimg = document.getElementById("lottoimg");
      var lottospan = document.getElementById("lottospan");
      
      lottoimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/lottomh3.png");
      lottoimg.setAttribute("width","300");
      lottoimg.setAttribute("height","200");
            
      lottospan.setAttribute("class","fw-bold");
      lottospan.innerText = "LOTTO";
      
      lottoa.appendChild(lottoimg);
      lottoa.appendChild(lottospan);
      lottodiv.appendChild(lottoa);
   }//로또 마우스 있을때 - 명화
   function lottomouse(){
      var lottodiv = document.getElementById("lottodiv");
      
      var lottoa = document.getElementById("lottoa");
      var lottoimg = document.getElementById("lottoimg");
      var lottospan = document.getElementById("lottospan");
      
      lottoimg.setAttribute("src","${pageContext.request.contextPath }/resources/img/lottomh1.png");
      lottoimg.setAttribute("width","300");
      lottoimg.setAttribute("height","200");
            
      lottospan.setAttribute("class","fw-bold");
      lottospan.innerText = "LOTTO";
      
      lottoa.appendChild(lottoimg);
      lottoa.appendChild(lottospan);
      lottodiv.appendChild(lottoa);
   }
   
      
      
   function init(){
      getLatestThreeContents(0);
      fishingimg();
      fishshareimg();
      diceimg();
      lottoimg();
   }
</script>
</body>
</html>