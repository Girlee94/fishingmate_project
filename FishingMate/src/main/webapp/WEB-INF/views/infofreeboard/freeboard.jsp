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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/reviewPage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">


</head>
<style type="text/css">
a {
   text-decoration: none
}

a:link {
   color: black;
}

a:visited {
   color: black;
}

a:hover {
   color: black;
}

a:active {
   color: black;
   
}

#info_list img{
   width: 192px;
   height: 148px;
   cursor: pointer;
}

#icon_img img{
 width:20px;
 height:20px;
}
</style>
<body>
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
							<span class="fs-2 fw-bold">정보 게시판</span>
						</div>
					</div>
              <!-- 검색 -->
               <form action="./freeboard.do" method="get">
                  <div class="row mt-3 pb-3">  
                     <div class="col-1"></div>               
                     <div class="col">
                        <select name="search_type" class="form-control">
                           <option value="title">제목</option>
                           <option value="content">내용</option>
                           <option value="nick">작성자</option>
                        </select>
                     </div>
                     <div class="col-8">
                        <input name="search_word" type="text" class="form-control">
                     </div>
                     <div class="col d-grid">
                        <!--
						일단 UI 꾸미려고 주석처리함
						<input type="submit" value="검색" class="btn btn-primary">
						  -->
                        <span style="font-size:25px;"><i class="bi bi-search"></i></span>
                     </div>
                  </div>
               </form>
               <!-- 검색기능 끝 --> 
			<div class="row" id="info_list">
				 <div class="row">
					<div class="col-1"></div>
					<div class="col">
						<div class="pb-0" id="total">▷ 총 ${contentCount }개의 글이 있습니다.</div>
					</div>
				  </div>
                  
                  <div class="row">
							<div class="col-1"></div>
							      <div class="col pt-0">
							      	<c:forEach items="${infofreeboardList}" var="data">
							         <div class="row border-bottom border-1 mt-0">   
							            <div class="col-4  mb-3 pb-2"> 
							            <br>
							              <a href="${pageContext.request.contextPath }/infofreeboard/readinfofreeboard.do?info_freeboard_no=${data.infoFreeboardVO.info_freeboard_no}"><img src="/upload_files/${data.infoimageVO[0].image_location}" class="card-img-top" onerror="this.src='${pageContext.request.contextPath}/resources/img/sangnamja.png'"></a>   	
							            </div>
							            
							            <div class="col text-truncate" id="icon_img">
							              <span>			                 
				                           	<a href="${pageContext.request.contextPath }/infofreeboard/readinfofreeboard.do?info_freeboard_no=${data.infoFreeboardVO.info_freeboard_no}">
				                             <span>
				                              <strong>
				                                <c:if test="${data.selectCategoryName =='낚시방법' }"> 
				                                 <span style="font-size:1.2em; color:#b95A87; border-right:1px solid gray;" id="category_color"><br>${data.selectCategoryName }&nbsp;</span>
				                                </c:if>
				                                <c:if test="${data.selectCategoryName =='낚시용품' }"> 
				                                 <span style="font-size:1.2em; color:#39950C; border-right:1px solid gray;" id="category_color"><br>${data.selectCategoryName }&nbsp;</span>
				                                </c:if> 
				                                <c:if test="${data.selectCategoryName =='축제후기' }"> 
				                                 <span style="font-size:1.2em; color:#E35101; border-right:1px solid gray;" id="category_color"><br>${data.selectCategoryName }&nbsp;</span>
				                                </c:if> 
				                                <c:if test="${data.selectCategoryName =='낚시터' }"> 
				                                 <span style="font-size:1.2em; color:#D39500; border-right:1px solid gray;" id="category_color"><br>${data.selectCategoryName }&nbsp;</span>
				                                </c:if>  
				                                 <span style="font-size:1.2em; color:black; margin-left:20px;"><!-- 제목 -->${data.infoFreeboardVO.info_freeboard_title }<br></span>
				                              </strong>
				                              
				                              <img src="/fishingmate/resources/img/content_mh.png" >
				                              <span style="font-size:1.2em; color:black">${data.infoFreeboardVO.info_freeboard_content }<br><br></span>
				                             </span>
				                          	    <!--  작성자 -->
				                          	   <img src="/fishingmate/resources/img/name_mh.png" >		                          	 	
							                   <span style="font-size:0.8em; color:black">${data.memberVO.member_nick }<br></span>
							                    <!-- 날짜 --> 
							                    <img src="/fishingmate/resources/img/calendar_mh2.png" >
							                    <small style="font-size:0.8em; color:black"><fmt:formatDate value="${data.infoFreeboardVO.info_freeboard_writedate }" pattern="yy.MM.dd" /></small>							                     
							                 </a>    
							               </span>
							            </div>
							           
							         </div>
							         </c:forEach>
							      </div>
							   </div>
							   
                  <!--  -->
               
                  <div class="row mt-3 mb-3">
                     <div class="col-4">&nbsp;</div>
                     <div class="col">
                        <nav aria-label="Page navigation example">
                          <ul class="pagination">
                            <li class="page-item">
                              <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                    </a>
                                     </li>
                                     &nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#">1</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#">2</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#">3</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#">4</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#">5</a></li>&nbsp;&nbsp;
                                     <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                              </a>
                            </li>
                          </ul>
                        </nav>
                     </div>
                    <div class="col-2 d-flex ms-auto justify-content-end align-self-center" >
								<c:if test="${! empty sessionUser  }">
								  <a href="${pageContext.request.contextPath}/infofreeboard/writeinfofreeboard.do" style="text-decoration:none;color:black; font-size:20px; " class="btn btn-writeBtn"><i class="bi bi-pencil-square"></i>&nbsp;글쓰기</a>
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