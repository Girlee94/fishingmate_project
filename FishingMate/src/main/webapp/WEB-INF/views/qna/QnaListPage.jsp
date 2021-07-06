<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/tradePage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/qnalist.css?ver=210604_8">
<script type="text/javascript">
   function content() {
      var aaa = 1;

      var xmlhttp = new XMLHttpRequest();

      //처리 로직
      xmlhppt.onreadystatechange = function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var obj = JSON.parse(xmlhppt.responseText);

            var contentlist = document.getElementById("contentlist");

            var rowBox = document.createElement("tr");

            var noBox = document.createElement("th");
            nobox.innerText = obj.freeboardList.qnaVO.qna_freeboard_content;
            rowBox.appendChild(noBox);
         }
      };

      xmlhppt.open("get", "../qna/qnaListPage.do?page_num=" + aaa, true);
      xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
      xmlhppt.send();
   }

   function page() {
      var xmlhppt = new XMLHttpRequest();
      var aaa = 1;

      xmlhttp.onreadystatechange = function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var obj = JSON.parse(xmlhttp.responseText);

            var contentlist = document.getElementById("contentlist");
            var pageBox = document.getElementById("IDpage");

            var paginationBox = document.createElement("ul");
            paginationBox.setAttribute("class", "pagination");
            if (obj.beginPage <= 1) {
               var nextBox = document.createElement("li");
               nextBox.setAttribute("class", "page-item disabled");
               var anextBox = document.createElement("a");
               anextBox.innerText = "Previous";
               anextBox.setAttribute("class", "page-link");
               nextBox.appendChild(anextBox);
               paginationBox.appendChild(nextBox);
            } else {
               var nextBox = document.createElement("li");
               nextBox.setAttribute("class", "page-item");
               var anextBox = document.createElement("a");
               anextBox.innerText = "Previous";
               anextBox.setAttribute("class", "page-link");
               nextBox.appendChild(anextBox);
               nextBox.setAttribute("onClick", "");

               nextBox.appendChild(anextBox);
               paginationBox.appendChild(nextBox);
            }
            for (var a = obj.beginPage; a == obj.endPage; a++) {
               if (a == obj.currentPage) {
                  var numBox = document.createElement("li");
                  var anumBox = document.createElement("a");
                  anumBox.innerText = a;
                  anumBox.setAttribute("class", "page-link");
                  numBox.setAttribute("class", "page-item active");

                  numBox.appendChild(anumBox);
                  paginationBox.appendChild(numBox);
               } else {
                  var numBox = document.createElement("li");
                  var anumBox = document.createElement("a");
                  anumBox.innerText = a;
                  anumBox.setAttribute("class", "page-link");
                  numBox.setAttribute("class", "paitem");
                  numBox.setAttribute("onClick", "");

                  numBox.appendChild(anumBox);
                  paginationBox.appendChild(numBox);

               }
               if (obj.endPage >= obj.totalPageCount) {
                  var totalBox = document.createElement("li");
                  var atotalBox = document.createElement("a");
                  atotalBox.innerText = "Next";
                  atotalBox.setAttribute("class", "page-link");
                  totalBox.setAttribute("class", "page-item disabled");
                  totalBox.setAttribute("onClick", "");

                  totalBox.appendChild(atotalBox);
                  paginationBox.appendChild(totalBox);
               } else {
                  var totalBox = document.createElement("li");
                  var atotalBox = document.createElement("a");
                  atotalBox.innerText = "Next";
                  atotalBox.setAttribute("class", "page-link");
                  totalBox.setAttribute("class", "page-item");
                  totalBox.setAttribute("onClick", "");

                  totalBox.appendChild(atotalBox);
                  paginationBox.appendChild(totalBox);
               }
               pageBox.appendChild(paginationBox);

            }
         }
         ;

         xmlhttp.open("get", "../qna/qnaListPage.do?page_num=" + aaa, true);
         xmlhttp.setRequestHeader("Content-type",
               "application/x-www-form-urlencoded");
         xmlhttp.send();

      }
   }

   function pagenum(pageNum) {
      var xmlhttp = new XMLHttpRequest();

      xmlhttp.onreadystatechange = function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var obj = JSON.parse(xmlhttp.responseText);

            var pageBox = document.getElementById("IDpage");
            pageBox.innerText = "";

            var paginationBox = document.createElement("ul");
            paginationBox.setAttribute("class", "pagination");
            if (obj.beginPage <= 1) {
               var nextBox = document.createElement("li");
               nextBox.setAttribute("class", "page-item disabled");
               var anextBox = document.createElement("a");
               anextBox.innerText = "Previous";
               anextBox.setAttribute("class", "page-link");
               console.log("aa");
               nextBox.appendChild(anextBox);
               paginationBox.appendChild(nextBox);
               pageBox.appendChild(paginationBox);
            } else {
               var nextBox = document.createElement("li");
               nextBox.setAttribute("class", "page-item");
               var anextBox = document.createElement("a");
               anextBox.innerText = "Previous";
               anextBox.setAttribute("class", "page-link");

               nextBox.appendChild(anextBox);
               nextBox.setAttribute("onClick", "setPageNum("
                     + (obj.beginPage - 1) + ")");
               nextBox.appendChild(anextBox);
               paginationBox.appendChild(nextBox);
               pageBox.appendChild(paginationBox);
            }
            for (var a = obj.beginPage; a <= obj.endPage; a++) {
               if (a == obj.currentPage) {
                  var numBox = document.createElement("li");
                  var anumBox = document.createElement("a");
                  anumBox.innerText = a;
                  console.log("1");
                  anumBox.setAttribute("class", "page-link");
                  numBox.setAttribute("class", "page-item active");

                  numBox.appendChild(anumBox);
                  paginationBox.appendChild(numBox);
                  pageBox.appendChild(paginationBox);
               } else {
                  var numBox = document.createElement("li");
                  var anumBox = document.createElement("a");
                  anumBox.innerText = a;
                  anumBox.setAttribute("class", "page-link");
                  numBox.setAttribute("class", "paitem");
                  console.log("2");
                  numBox.setAttribute("onClick", "setPageNum(" + (a)
                        + ")");
                  numBox.appendChild(anumBox);
                  paginationBox.appendChild(numBox);
                  pageBox.appendChild(paginationBox);

               }

            }
            if (obj.endPage >= obj.totalPageCount) {
               var totalBox = document.createElement("li");
               var atotalBox = document.createElement("a");
               atotalBox.innerText = "Next";
               atotalBox.setAttribute("class", "page-link");
               totalBox.setAttribute("class", "page-item disabled");
               totalBox.appendChild(atotalBox);
               paginationBox.appendChild(totalBox);
               pageBox.appendChild(paginationBox);
            } else {
               var totalBox = document.createElement("li");
               var atotalBox = document.createElement("a");
               atotalBox.innerText = "Next";
               atotalBox.setAttribute("class", "page-link");
               totalBox.setAttribute("class", "page-item");
               console.log("4");
               totalBox.setAttribute("onClick", "setPageNum("
                     + (obj.endPage + 1) + ")");
               totalBox.appendChild(atotalBox);
               paginationBox.appendChild(totalBox);
               pageBox.appendChild(paginationBox);
            }

         }
      };

      /* xmlhttp.open("get","../qna/QnaListPage.do?page_num="+pageNum, true); */
      xmlhttp.open("post", "../qna/QnaListPage.do", true);
      xmlhttp.setRequestHeader("Content-type",
            "application/x-www-form-urlencoded");
      xmlhttp.send("search_word=" + contenting.value + "&search_type="
            + selecting.options[selecting.selectedIndex].value
            + "&page_num=" + pageNum);

   }

   function init() {
      page();
      content();
   }
</script>

</head>
<body>
   <div style="width: 1200px; margin: 0 auto;">
      <!-- 헤더 -->
      <jsp:include page="/WEB-INF/views/commons/header.jsp" />
      <!-- 헤더 끝 -->

      <div class="container-fluid my-5">
         <div class="row">
            <!-- 사이드 시작 -->
            <%-- <div class="col border-end border-1">
               <jsp:include page="/WEB-INF/views/commons/leftSide.jsp" />              
            </div> --%>
            <!-- 사이드 끝 -->
            <div class="col">
               <br>

               <div class="bg">
                  <div class="row my-5">
                     <div class="col"></div>
                     <div class=" col-8 text-center">
                        <span id="fishing"> <a
                           class="text-decoration-none text-dark">Q&A </a>
                        </span>
                     </div>
                     <div class="col"></div>
                  </div>
               </div>





               <br>



               <div class="row">
                  <div class="col-12 text-center">
                     <div class="col d-grid">
                        <div class="btn-group" role="group"
                           aria-label="Basic radio toggle button group">

                           <c:choose>
                              <c:when test="${empty qna_category_no}">
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio1" autocomplete="off" checked>
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio1" onClick="location.href='./QnaListPage.do'">전체항목</label>

                              </c:when>
                              <c:otherwise>
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio1" autocomplete="off">
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio1" onClick="location.href='./QnaListPage.do'">전체항목</label>

                              </c:otherwise>
                           </c:choose>

                           <c:choose>
                              <c:when test="${qna_category_no == 1}">
                                 <input type="radio" class="btn-check mx-1" name="btnradio"
                                    id="btnradio2" autocomplete="off" checked>
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio2"
                                    onClick="location.href='./QnaListPage.do?qna_category_no=1'">계정관리</label>
                              </c:when>
                              <c:otherwise>
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio2" autocomplete="off">
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio2"
                                    onClick="location.href='./QnaListPage.do?qna_category_no=1'">계정관리</label>

                              </c:otherwise>
                           </c:choose>

                           <c:choose>
                              <c:when test="${qna_category_no == 2}">
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio3" autocomplete="off" checked>
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio3"
                                    onClick="location.href='./QnaListPage.do?qna_category_no=2'">중고거래</label>

                              </c:when>
                              <c:otherwise>
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio3" autocomplete="off">
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio3"
                                    onClick="location.href='./QnaListPage.do?qna_category_no=2'">중고거래</label>

                              </c:otherwise>
                           </c:choose>
                           <c:choose>
                              <c:when test="${qna_category_no == 3}">
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio4" autocomplete="off" checked>
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio4"
                                    onClick="location.href='./QnaListPage.do?qna_category_no=3'">기타문의</label>

                              </c:when>
                              <c:otherwise>
                                 <input type="radio" class="btn-check" name="btnradio"
                                    id="btnradio4" autocomplete="off">
                                 <label class="btn btn-outline-secondary btn-lg mx-1"
                                    for="btnradio4"
                                    onClick="location.href='./QnaListPage.do?qna_category_no=3'">기타문의</label>
                              </c:otherwise>
                           </c:choose>

                        </div>
                     </div>
                  </div>
               </div>









               <br>
               <!-- 
      <div class="row">
         <div class="col">
            <table class="table">
               <thead class="bg-secondary text-white">
                  <tr>
                     <th scope="col">번호</th>
                     <th scope="col">카테고리</th>
                     <th scope="col">제목</th>
                     <th></th>
                     <th></th>
                     <th></th>
                     <th scope="col">작성자</th>
                     <th scope="col">조회수</th>
                     <th scope="col">입력날짜</th>      
                     <th scope="col">답변</th> 
                  </tr>
               </thead>
                     
               <tbody>
               
                  <c:forEach items="${qnafreeboardList }" var="content">
                     <c:choose>
                        <c:when test="${content.commentCount != 0 || content.commentAdminCount != 0}">
                           <tr style="background-color: PapayaWhip">   
                        </c:when>
                        <c:otherwise>
                           <tr style="background-color: GhostWhite">
                        </c:otherwise>
                     </c:choose>
                     
                  
                     
                     
                     
                        <th scope="row">${content.qnaVO.qna_freeboard_no }</th>
                        <td>${content.qnaCategoryVO.qna_category_name } </td>
                        <td>
                        <c:choose>
                           <c:when test="${content.qnaVO.qna_freeboard_pw != null && empty sessionAdmin}">
                              <a class="text-decoration-none text-dark" href="${pageContext.request.contextPath}/qna/.do?qna_freeboard_no=${content.qnaVO.qna_freeboard_no }">
                                 ${content.qnaVO.qna_freeboard_title }<small>(${content.commentCount})&nbsp;<img src="${pageContext.request.contextPath}/resources/img/lock.png"width="15" height="15" ></small>&nbsp;
                              </a>   
                           </c:when>
                           <c:otherwise>
                              <a class="text-decoration-none text-dark" href="${pageContext.request.contextPath}/qna/QnaContentPage.do?qna_freeboard_no=${content.qnaVO.qna_freeboard_no }">
                                 ${content.qnaVO.qna_freeboard_title }<small>(${content.commentCount})</small>&nbsp;
                              </a>
                           </c:otherwise>
                        </c:choose>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>${content.memberVO.member_nick}</td>
                        <td>${content.qnaVO.qna_freeboard_readcount }</td>
                        <td><fmt:formatDate value="${content.qnaVO.qna_freeboard_writedate }" pattern="yyyy.MM.dd"/></td>
                        
                           <c:choose>
                              <c:when test="${content.commentAdminCount == 0 }">
                                 <th></th>
                              </c:when>
                              <c:otherwise>
                                 <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-check-circle text-success fw-bold"></i></th>
                              </c:otherwise>
                           </c:choose>
                        
                   
               
               </c:forEach>
            </tbody>
         </table>
      </div>
   </div>
 -->


               <div class="row ms-1">
                  <div class="accordion col" id="accordionPanelsStayOpenExample">
                     <c:forEach items="${qnafreeboardList }" var="content"
                        varStatus="status">
                        <div class="row">
                           <div class="accordion-item col-11">
                              <h2 class="accordion-header"
                                 id="panelsStayOpen-heading${status.count }">
                                 <button class="accordion-button collapsed" type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#panelsStayOpen-collapse${status.count }"
                                    aria-expanded="true"
                                    aria-controls="panelsStayOpen-collapse${status.count }">
                                    <img
                                       src="${pageContext.request.contextPath }/resources/img/question.png"
                                       width="40" height="40">
                                    <div class="col mt-2 ps-4">

                                       <strong> ${content.qnaVO.qna_freeboard_title }
                                          &nbsp; </strong>
                                          <c:if test="${content.qnaVO.qna_freeboard_pw != null }">
                                          	<i class="bi bi-lock-fill fs-5 text-warning"></i>
                                          </c:if>
                                          <br>
                                    </div>

                                 </button>
                              </h2>



                              <div id="panelsStayOpen-collapse${status.count }"
                                 class="accordion-collapse collapse"
                                 aria-labelledby="panelsStayOpen-heading${status.count }">


                                 <c:choose>
                                    <c:when test="${content.qnaVO.qna_freeboard_pw != null && empty sessionAdmin}">
                                       <div class="accordion-body">
                                          <img src="${pageContext.request.contextPath }/resources/img/blocked.png"
                                             width="40" height="40"> &nbsp;&nbsp;&nbsp;<strong>
                                             작성자에 의해 보호된 글입니다.</strong>
                                       </div>

                                    </c:when>
                                    <c:when test="${content.commentList.size() == 0 }">
                                       <div class="accordion-body">
                                          <img
                                             src="${pageContext.request.contextPath }/resources/img/norespond.png"
                                             width="40" height="40"> &nbsp;&nbsp;&nbsp;<strong>
                                             관리자가 아직 답변을 하지 않았습니다. </strong>
                                       </div>
                                    </c:when>
                                    <c:otherwise>
                                       <c:forEach items="${content.commentList }" var="commenttt">

                                          <%--<c:if test="${commenttt.manager_no != 0 }"> --%>
                                          <div class="col">
                                             <div class="accordion-body">
                                                <img
                                                   src="${pageContext.request.contextPath }/resources/img/answered.png"
                                                   width="40" height="40"> &nbsp;&nbsp;&nbsp;<strong>
                                                   ${commenttt.qna_comment_content } </strong>
                                             </div>
                                          </div>
                                          <%--</c:if> --%>
                                       </c:forEach>

                                    </c:otherwise>

                                 </c:choose>
                              </div>
                           </div>




                           <div class="col pt-4 pe-4">
                              <c:choose>
                                 <c:when
                                    test="${content.qnaVO.qna_freeboard_pw != null && empty sessionAdmin}">
                                    <a class="text-decoration-none text-dark"
                                       href="${pageContext.request.contextPath}/qna/password.do?qna_freeboard_no=${content.qnaVO.qna_freeboard_no }">
                                       <img
                                       src="${pageContext.request.contextPath }/resources/img/docu.png"
                                       width="30" height="30" align="right">&nbsp;&nbsp;
                                    </a>
                                 </c:when>
                                 <c:otherwise>
                                    <a class="text-decoration-none text-dark"
                                       href="${pageContext.request.contextPath}/qna/QnaContentPage.do?qna_freeboard_no=${content.qnaVO.qna_freeboard_no }">
                                       <img
                                       src="${pageContext.request.contextPath }/resources/img/docu.png"
                                       width="30" height="30" align="right">&nbsp;
                                    </a>
                                 </c:otherwise>
                              </c:choose>
                           </div>



                        </div>
                     </c:forEach>
                  </div>
               </div>





               <br>
               <div class="row">
                  <br>
                  <div class="col-5"></div>
                  <div class="col-5">
                     <nav aria-label="...">
                        <ul class="pagination">
                           <li class="page-item disabled"><a class="page-link"
                              href="#">이전</a></li>
                           <li class="page-item active" aria-current="page"><a
                              class="page-link" href="#">1</a></li>

                           <li class="page-item">
                           <li class="page-item disabled"><a class="page-link"
                              href="#">다음</a></li>
                        </ul>
                     </nav>
                  </div>
                  <div class="col-1"></div>
                  <div class="col-1"></div>
               </div>


               <div class="row">
                  <div class="col-2 d-flex ms-auto justify-content-end">
                     <c:if test="${!empty sessionUser }">
                        <a class="btn btn-secondary"
                           href="${pageContext.request.contextPath }/qna/QnaWritePage.do">글쓰기</a>
                     </c:if>
                  </div>
               </div>


               <br>


            </div>
         </div>
      </div>
   </div>

   <div style="width: 100%; margin: 0 auto;">
      <!-- 푸터 -->
      <jsp:include page="/WEB-INF/views/commons/footer.jsp" />
      <!-- 푸터 끝 -->

   </div>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
      crossorigin="anonymous"></script>
</body>
</html>