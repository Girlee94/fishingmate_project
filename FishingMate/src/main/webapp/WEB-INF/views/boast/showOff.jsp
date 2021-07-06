<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자랑 게시판 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script type="text/javascript">
var pageNum = 1;
function setPageNum(num) {
   pageNum = num;
   
   page(pageNum);
   content(pageNum);
}
//글 목록 불러오기 - 명화
function content(pageNum){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         /*총게시글 수  시작 */
         var totalFreeboardCount = document.getElementById("totalCount");
         totalFreeboardCount.innerText="▷ 총 "+obj.contentCount +"개의 글이 있습니다."
         
         
         /*총게시글 수  끝*/
         
         
         var b=0;
         
         var testdiv = document.getElementById("testdiv");
         var imgul = document.getElementById("imgul");
         testdiv.innerText="";
         
         for (var showOffList of Object.keys(obj)) {
            var testdiv1 = document.createElement("testdiv1");
            var testdiv2 = document.createElement("testdiv2");
            var testdiv3 = document.createElement("testdiv3");
            testdiv1.setAttribute("class","row border-bottom border-1 mt-2");
            testdiv2.setAttribute("class","col-4  mb-3 pb-3");
            testdiv3.setAttribute("class","col text-truncate");
            
            
            var imgli = document.createElement("span");
            var liBox = document.createElement("span");
            var rink = document.createElement("a");
            var imgs = document.createElement("img");
            var contentimg = document.createElement("img");
            var dateimg = document.createElement("img");
            var nickimgs = document.createElement("img");
            var imagsa = document.createElement("a");
            var spanone = document.createElement("span");
            var strong = document.createElement("strong");
            var spantitleone = document.createElement("span");
            var spantitletwo = document.createElement("span");
            var spancontnet = document.createElement("span");
            var spannick = document.createElement("span");
            var spandate = document.createElement("small");
            var imaspan = document.createElement("span");
            
            const str = '\n';
            const sbr = '&nbsp'; 
            
            var aaa = new Date(obj["freeboardList"][b].showOffVO.showoff_freeboard_writedate);
  
            testdiv2.innerText = ""+str;
            rink.setAttribute("href","${pageContext.request.contextPath }/boast/showOffreadContentPage.do?freeboard_no="+obj["freeboardList"][b].showOffVO.showoff_freeboard_no);
            imagsa.setAttribute("href","${pageContext.request.contextPath }/boast/showOffreadContentPage.do?freeboard_no="+obj["freeboardList"][b].showOffVO.showoff_freeboard_no);
            nickimgs.setAttribute("src","/fishingmate/resources/img/name_mh.png");
            contentimg.setAttribute("src","/fishingmate/resources/img/content_mh.png");
            dateimg.setAttribute("src","/fishingmate/resources/img/calendar_mh2.png");
            
            dateimg.setAttribute("width","20","height","20");
            nickimgs.setAttribute("width","20","height","20");
            contentimg.setAttribute("width","20","height","20");
            
            if(obj["freeboardList"][b].showoffImageVO[0] != null){
               imgs.setAttribute("src","/upload_files/"+obj["freeboardList"][b].showoffImageVO[0].image_location);
            }else{
               imgs.setAttribute("src","/fishingmate/resources/img/noimage.gif");
            }
            imgs.setAttribute("width","192");
            imgs.setAttribute("height","148");
            if(obj["freeboardList"][b].showOffVO.showoff_freeboard_no%5==0){
            spantitleone.setAttribute("style","font-size:1.2em; color:#39950C; border-right:1px solid gray;");
            }
            if(obj["freeboardList"][b].showOffVO.showoff_freeboard_no%5==1){
               spantitleone.setAttribute("style","font-size:1.2em; color:#b95A87; border-right:1px solid gray;");
               }
            if(obj["freeboardList"][b].showOffVO.showoff_freeboard_no%5==2){
               spantitleone.setAttribute("style","font-size:1.2em; color:#666666; border-right:1px solid gray;");
               }
            if(obj["freeboardList"][b].showOffVO.showoff_freeboard_no%5==3){
               spantitleone.setAttribute("style","font-size:1.2em; color:#D39500; border-right:1px solid gray;");
               }
            if(obj["freeboardList"][b].showOffVO.showoff_freeboard_no%5==4){
               spantitleone.setAttribute("style","font-size:1.2em; color:#E35101; border-right:1px solid gray;");
               }
            spantitleone.innerText = str+""+"자랑게시판"+"\t";
            spantitletwo.setAttribute("style","font-size:1.2em; color:black; margin-left:20px;");
            spantitletwo.innerText = "\t"+obj["freeboardList"][b].showOffVO.showoff_freeboard_title+""+str+"";
            spancontnet.setAttribute("style","font-size:1.2em; color:black");
            spancontnet.innerText = "\t"+obj["freeboardList"][b].showOffVO.showoff_freeboard_content+""+str+""+str;
            spandate.setAttribute("style","font-size:0.8em; color:black");
            spannick.setAttribute("style","font-size:0.8em; color:black");
            
            spannick.innerText = "\t"+obj["freeboardList"][b].memberVO.member_nick+""+str;
            spandate.innerText = 
                 "\t"+(aaa.getFullYear()).toString().substr(2, 4) + "/" + 
                     (aaa.getMonth()+1 > 9 ? aaa.getMonth()+1 : "0" + (aaa.getMonth()+1)) + "/" +
                     (aaa.getDate()+1 > 9 ? aaa.getDate() : "0" + (aaa.getDate()));
          
            imgli.appendChild(imgs);
            imgli.appendChild(imaspan);
            imagsa.appendChild(imgli);
            strong.appendChild(spantitleone);
            strong.appendChild(spantitletwo);
       
            spanone.appendChild(strong);
            spanone.appendChild(contentimg);
            spanone.appendChild(spancontnet);
            
            
            rink.appendChild(spanone);
            rink.appendChild(nickimgs);
            rink.appendChild(spannick);
            rink.appendChild(dateimg);
            rink.appendChild(spandate);
            
            liBox.appendChild(rink);
            testdiv2.appendChild(imagsa);
            testdiv3.appendChild(liBox);
            testdiv1.appendChild(testdiv2);
            testdiv1.appendChild(testdiv3);
            testdiv.appendChild(testdiv1);
            b++;
         }
         
      }
   };
   xmlhttp.open("post","../Showoff/mainPage.do", true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("search_word="+contenting.value+"&search_type="+selecting.options[selecting.selectedIndex].value+"&page_num="+pageNum);
   
   }
//글 페이징 - 명화
function page(pageNum){
   var xmlhttp = new XMLHttpRequest();

   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         
         var pageBox = document.getElementById("IDpage");
         pageBox.innerText="";
         
         var paginationBox= document.createElement("ul");
         paginationBox.setAttribute("class","pagination");
         if(obj.beginPage <= 1){
            var nextBox = document.createElement("li");
            nextBox.setAttribute("class","page-item disabled");
            var anextBox = document.createElement("a");
            anextBox.innerText = "<";
            anextBox.setAttribute("class","page-link");
            console.log("aa");
            nextBox.appendChild(anextBox);
            paginationBox.appendChild(nextBox);
            pageBox.appendChild(paginationBox);
         } 
         else{
            var nextBox = document.createElement("li");
            nextBox.setAttribute("class","page-item");
            var anextBox = document.createElement("a");
            anextBox.innerText = "<";
            anextBox.setAttribute("class","page-link");
            
            nextBox.appendChild(anextBox);
            nextBox.setAttribute("onClick","setPageNum(" + (obj.beginPage-1) + ")");
            nextBox.appendChild(anextBox);
            paginationBox.appendChild(nextBox);
            pageBox.appendChild(paginationBox);
         }
         for(var a=obj.beginPage; a<=obj.endPage; a++){
            if(a == obj.currentPage){
               var numBox = document.createElement("li");
               var anumBox = document.createElement("a");
               anumBox.innerText = a;
               console.log("1");
               anumBox.setAttribute("class","page-link");
               numBox.setAttribute("class","page-item active");
               
               numBox.appendChild(anumBox);
               paginationBox.appendChild(numBox);
               pageBox.appendChild(paginationBox);
         }
            else{
               var numBox = document.createElement("li");
               var anumBox = document.createElement("a");
               anumBox.innerText = a;
               anumBox.setAttribute("class","page-link");
               numBox.setAttribute("class","paitem");
               console.log("2");
               numBox.setAttribute("onClick","setPageNum(" + (a) + ")");
               numBox.appendChild(anumBox);
               paginationBox.appendChild(numBox);
               pageBox.appendChild(paginationBox);
            
         }
         
      }
         if(obj.endPage>=obj.totalPageCount){
            var totalBox =document.createElement("li");
            var atotalBox = document.createElement("a");
            atotalBox.innerText =">";
            atotalBox.setAttribute("class","page-link");
            totalBox.setAttribute("class","page-item disabled");
            totalBox.appendChild(atotalBox);
            paginationBox.appendChild(totalBox);
            pageBox.appendChild(paginationBox);
         }
         else{
            var totalBox =document.createElement("li");
            var atotalBox = document.createElement("a");
            atotalBox.innerText =">";
            atotalBox.setAttribute("class","page-link");
            totalBox.setAttribute("class","page-item");
            totalBox.setAttribute("onClick","setPageNum(" + (obj.endPage+1) + ")");
            totalBox.appendChild(atotalBox);
            paginationBox.appendChild(totalBox);
            pageBox.appendChild(paginationBox);
         }

      }
   };
   
   /* xmlhttp.open("get","../Showoff/mainPage.do?page_num="+pageNum, true); */
   xmlhttp.open("post","../Showoff/mainPage.do", true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("search_word="+contenting.value+"&search_type="+selecting.options[selecting.selectedIndex].value+"&page_num="+pageNum);
   
}
   function init(){
      page(pageNum);
      content(pageNum);
   }
</script>
   <style type="text/css">
   a { text-decoration:none } 
   
   #divmargin{
      margin: 0;
       padding: 0;
   }
   </style> 
</head>

<body onload="init()">
   
   <!-- 본문 시작  -->
   <div style="width: 1200px; margin: 0 auto;">
      <!-- 헤더 -->
      <jsp:include page="/WEB-INF/views/commons/header.jsp" />
      <!-- 헤더 끝 -->
      <div class="container-fluid my-4">
            <div class="row">
               <div class="col border-end border-1">
                  <!-- 사이드 시작 -->
                     <jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />
                  <!-- 사이드 끝 -->
               
               </div>
         
         <div class="col-10">
               <div class="row">
                  <div class="col-1"></div>
                  <div class="col">
                     <span class="fs-2 fw-bold">자랑 게시판</span>
                  </div>
               </div>
            <!-- 본문 끝 -->
               <!--검색  -->
                     <div class="row mt-3 pb-3">  
                        <div class="col-1"></div>               
                        <div class="col">
                           <select id="selecting" name="search_type" class="form-control">
                        <option id="title" value="title">제목</option>
                        <option id="content" value="content">내용</option>
                        <option id="nick" value="nick">작성자</option>
                           </select>
                        </div>
                        <div class="col-8">
                           <input name="search_word" type="text" id="contenting" onkeyup="if(window.event.keyCode==13){content(1)}" class="form-control">
                        </div>
                        <div id="divmargin" class="col d-grid">
                     <button type="button" class="border-0" style="background : none;" onClick="content(1)">
                      <span style="font-size:25px;"><i style="float: left;" class="bi bi-search"></i></span>
                     </button>
                        </div>
                     </div>
                  <!-- 검색기능 끝 --> 
            <!-- 게시판 추가 -->
            <div class="row">
               <div class="col-1"></div>
               <div class="col">
                  <div class="pb-2" id="totalCount"></div>
               </div>
            </div>
            
            <div class="row">
               <div class="col-1">
               </div>
               <div class="col-11">
                   
                  <div class="row" id="testdiv">
                     <div class="col-4 border border-1">
                        <ul id="imgul"></ul>
                     </div>
                     <div class="col border border-1">
                     </div> 
                  </div>      
                  <div class="col-2">
                  </div>
               </div>
            
            <div class="row mt-3">
               <div class="col-4"></div>
               <div class="col-4">
               <!-- ------------------- -->
                  <nav aria-label="..." id="IDpage">
                  </nav>
               <!-- ------------------- -->
               </div>
               <div class="col-2 d-flex ms-auto justify-content-end align-self-center" >
                        <c:if test="${! empty sessionUser  }">
                          <a href="${pageContext.request.contextPath}/boast/showOffWritePage.do" style="text-decoration:none;color:black; font-size:20px; " class="btn btn-writeBtn"><i class="bi bi-pencil-square"></i>&nbsp;글쓰기</a>
                        </c:if>
                </div>
               
               
            </div>
            </div>
         </div>
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