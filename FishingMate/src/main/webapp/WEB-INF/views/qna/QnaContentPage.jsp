<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/header.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">

<script type="text/javascript">

   var sessionMemberNo= null;
   var qna_freeboard_no =${QnaVO.QnaVO.qna_freeboard_no};
   
   function getSessionMemberNo() {
      
      var xmlhttp = new XMLHttpRequest();
      
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readystate==4 && xmlhttp.status == 200){
            var obj = JSON.parse(xmlhttp.responseText);
            
            sessionMemberNo = obj.memberNo;
         }
      };
      xmlhttp.open("get","${pageContext.request.contextPath}/member/getSessionMemberNo.do", true);
      xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlhttp.send();
   }

   function qnaWriteComment(){
      if(sessionMemberNo == null){
         alert("로그인하세요");
         return;
      }
      var qna_comment_content = document.getElementById("qna_comment_content").value;
   
   var xmlhttp = new XMLHttpRequest();
   
   xmlhttp.onreadystatechange = function() {
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
         
         refreshQnaCommentData();
      }
   };
   
   xmlhttp.open("post", "${pageContext.request.contextPath}/qna/writeComment.do",true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("qna_freeboard_no=" +qna_freeboard_no + "&qna_comment_content=" +qna_comment_content);
   
   }

   function refreshQnaCommentData() {
      
      var qna_comment_count = document.getElementById("commentCount");
      var qna_comment_comment = document.getElementById("qna_comment_comment");
      
      if(sessionMemberNo != null){
         qna_comment_content.value="";
      }
      
      var xmlhttp = new XMLHttpRequest();
      //처리 로직
      xmlhttp.onreadystatechange = function(){
         if(xmlhttp.readyState==4 && xmlhttp.status==200){
            var obj =JSON.parse(xmlhttp.responseText);
            
            qna_comment_count.innerText ="댓글("+obj.commentCount+")"
            var qna_comment_list = document.getElementById("qna_comment_list");
            qna_comment_list.innerText =""
            
            var qna_comment_list_first =document.getElementById("comment_list_first")
            var qna_commentLi = qna_comment_list_first.cloneNode(true);
            qna_commentLi.removeAttribute("class");
            qna_commentLi.setAttribute("class","list-group-item");
            qna_comment_list.appendChild(qna_commentLi);
            
         for(var commentList of obj.qnaCommentList) {
            
            var qna_commentLi = document.createElement("li");
            qna_commentLi.setAttribute("class", "list-group-item");
            
            var commentRowBox = document.createElement("div");
            commentRowBox.setAttribute("class", "row");
            
            //댓글 작성자
            var commentMemberColBox = document.createElement("div");
            var commentMemberSpanBox = document.createElement("span");
            var commentDataSmallBox = document.createElement("small");
            commentMemberColBox.setAttribute("class", "col-8 pe-2 border-end border-1");
            commentMemberSpanBox.innerText = commentList.memberVO.member_nick+"\n";
            var commentWriteDate = new Date(commentList.QnaCommentVO.qna_comment_writedate);
            commentDateSmallBox.innerText="("(commentWriteDate.getFullYear()).toString().substr(2,4)+"."+(commentWriteDate.getMonth()+1 >9 ? commentWriteDate.getMonth()+1:"0"+(commentWriteDate.getMonth()+1))+"."+commentWriteDate.getDate()+""
            +")";
            
            commentMemberSpanBox.appendChild(commentDateSmallBox);
            commentMemberColBox.appendChild(commentMemberSpanBox);
            commentRowBox.appendChild(commentMemberColBox);
            
            //댓글 내용 부분
            var commentContextColBox = document.createElement("div");
            var commentContextSpanBox = document.createElement("span");
            commentContentColBox.setAttribute("class", "col-8 pe-2 border-end border-1");
            commentContentSpanBox.innerText = commentList.QnaCommentVO.qna_comment_content;
            commentContentColBox.appendChild(commentContentSpanBox);
            commentRowBox.appendChild(commentContentColBox);
            qna_commentLi.appendChild(commentRowBox);
            qna_comment_list.appendChild(qna_commentLi);
            
            //댓글 삭제 버튼 만들기
            var commentDeleteColBox = document.createElement("div");
            commentDeleteColBox.setAttribute("class, col-1 text center position-relative");
            if(sessionMemberNo == commentList.QnaCommentVO.member_no){
               //버튼 만들기
               var commentDeleteButton = document.createElement("button");
               commentDeleteButton.setAttribute("class", "btn-btn-outline-danger btn-sm position-absolute start-50 top-50 translate-middle");
               commentDeleteButton.setAttribute("onclick", "qnaDeleteComment("+commentList.QnaCommentVO.qna_comment_no+")");
               commentDeleteButton.innerText="Delete";
               commentDeleteColBox.appendChild(commentDeleteButton);
            }
            commentRowBox.appendChild(commentDeleteColBox);
            
            qna_commentLi.appendChild(commentRowBox);
            qna_comment_list.appendChild(qna_commentLi);
            
            //댓글 수정 버튼 만들기
            var commentUpdateColBox = document.createElement("div");
            commentUpdateColBox.setAttribute("class", "col-1 text-center position-relative");
            if(sessionMemberNo == commentList.QnaCommentVO.member_no){
               //버튼 만들기
               commentUpdateButton.setAttribute("class", "btn btn-outline-primary btn-sm position-absolute start-50 top-50 translate-middle");
               commentUpdateButton.setAttribute("onclick", "qnaUpdateComment(" +commentList.QnaCommentVO.qna_comment_no + ", this)");
               commentUpdateButton.innerText = "update";
               commentUpdateColBox.appendChild(commentUpdateButton);
            }
            commentRowBox.appendChild(commentUpdateColBox);
            
         }   
         }
      };
      xmlhttp.open("get", "${pageContext.request.contextPath}/qna/getQnaCommentData.do?qna_freeboard_no="+qna_freeboard_no, true);
      xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlhttp.send();
   
   }
   
   //댓글 삭제
   function qnaDeleteComment(qna_comment_no){
      //Ajax 호출
      var xmlhttp = new XMLHttpRequest();
      
      //처리 로직
      
      xmlhttp.onreadystatechange = function() {
         if(xmlhttp.readystate==4 && xmlhttp.status == 200){
            
            refreshQnaCommentData();
         }
      };
      xmlhttp.open("post", "${pageContext.request.contextPath}/qna/qnaDeleteComment.do", true);
      xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlhttp.send("qna_comment_no="+qna_comment_no);
      
   }
   
   function qnaupdateCommentProcess(qna_comment_no){
      var qna_comment_updateContent=document.getElementById("qna_comment_updateContent").value;
      var xmlhttp = new XMLHttpRequest();
      
      xmlhttp.onreadystatechange = function() {
         if(xmlhttp.readystate==4 && xmlhttp.status==200){
            
            refreshQnaCommentData();
         }
      };
      xmlhttp.open("post","{pageContext.request.contextPath}/qna/qnaupdateCommentProcess.do", true);
      xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlhttp.send("qna_comment_no=" +qna_comment_no + "&qna_comment_content=" + qna_comment_updateContent);
      
      
   }
   
   //댓글 수정 입력란 불러오기
   function qnaupdateComment(qna_comment_no, commentRowBox) {
      //Ajax 호출....
      var xmlhttp = new XMLHttpRequest();
      
      var parentLiBox = commentRowBox.parentElement.parentElement.parentElement;
      
      //호출 후 값을 받았을때... 처리 로직
      xmlhttp.onreadystatechange = function() {
         if(xmlhttp.readystata==4 && xmlhttp.status == 200) {
            var obj = JSON.parse(xmlhttp.responseText);
               // java와 Javascript 간 언어 변환기
            var comment_list_update_frm = document.getElementById("comment_list_update_frm");
               var comment_update_box = comment_list_update_frm.cloneNode(true);
               
               commet_update_box.removeAttribute("class");
               commet_update_box.setAttribute("class", "list-group-item");
               commet_update_box.firstElementChild.children[1].children[0].innerText = obj.QnaCommentVO.qna_comment
            commet_update_box.firstElementChild.children[2].children[0].setAttribute("onclick", "qnaupdateCommentProcess("+obj.QnaCOmmentVO.qna_comment_no + ")");
               parentLiBox.after(commet_update_box);
               
         }
      };
      
      xmlhttp.open("get", "${pageContext.request.contextPath}/qna/getqnaOneCommentData.do?qna_comment_no" + qna_comment_no, true)
      xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlhttp.send();
   }
   
   function init(){
      getSessionMemberNo();
      refreshQnaCommentData();
   }
   

   
   
   
   
   
   </script>

</head>
<body onload="init()">
    <div style="width: 1200px; margin: 0 auto; ">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="container-fluid my-5">
		<div class="row">
			<div class="col">
			    <div class="row my-4">
						<div class="col-7 border-bottom border-2">
							<p class="h2 pb-2 ps-2 mt-2">${QnaVO.QnaVO.qna_freeboard_title}</p>
						</div>
						<div class="col border-bottom border-2 position-relative">
							<span class="position-absolute top-50 end-0 translate-middle-y">
							<small>
								<i class="bi bi-person-fill"></i>&nbsp;<b>${QnaVO.MemberVO.member_nick} &nbsp;&nbsp;
								<i class="bi bi-eye-fill"></i>&nbsp;${QnaVO.QnaVO.qna_freeboard_readcount}&nbsp;&nbsp;
								<i class="bi bi-calendar-check"></i>&nbsp;<fmt:formatDate value="${QnaVO.QnaVO.qna_freeboard_writedate }" pattern="yyyy.MM.dd" />
							</small>
							</span>
						</div>
			    </div>
				<div class="row">
				   <div class="col p-3 border border-1 me-1 ">
				     <div class="row text-center">
				       <c:forEach items="${QnaVO.qnaImageVOList }" var="qnaImageVO">
                        <img src="/upload_files/${qnaImageVO.image_location }">
                        <br>
                       </c:forEach> 
				  	</div>
				  	<div class="row mt-3">
				    <!-- 내용 -->  
					   <div class="col p-3 ps-4" style="height: 200px;">	  		    
							${QnaVO.QnaVO.qna_freeboard_content  }
					   </div>
				    </div>		
					</div>
				   			  
				</div>
				
				  
				<div class="row mt-4"> 
				   <div class="col-1 align-self-center"><span id="info_comment_count"></span></div>
				   <div class="col text-end">
				      <c:if test="${sessionUser != null && sessionUser.member_no == QnaVO.QnaVO.member_no }">
			            <a href="${pageContext.request.contextPath }/qna/updateContentPage.do?qna_freeboard_no=${QnaVO.QnaVO.qna_freeboard_no}"><i style="font-size: 25px; color: blue;" class="bi bi-pencil-square"></i></a>&nbsp;&nbsp;<!-- 수정 -->
			            <a href="${pageContext.request.contextPath }/qna/deleteContentProcess.do?qna_freeboard_no=${QnaVO.QnaVO.qna_freeboard_no}"><i style="font-size: 25px; color: darkred;"class="bi bi-trash"></i></a>&nbsp;<!-- 삭제 -->
			         </c:if>
         
				   </div>
				</div>	
				<!--댓글  -->							
               <!-- 댓글 권한 -->      
   <div class="row">
   <div class="col">
   <div id="review_card_list">
      <form action="${pageContext.request.contextPath }/qna/writeComment.do" method="post">
         <div class="col">
            <th>댓글 작성</th>
         </div>
            <c:choose>      
               <c:when test="${(!empty sessionUser && sessionUser.member_no != QnaVO.MemberVO.member_no) || !empty sessionAdmin }">
                                             <!-- 매니저 번호 2로 통일 -->
                  <div class="row mb-1">
                     <div class="col-3"></div>
                     <div class="col"></div>         
                  </div>

                  <div class="row mb-3">
                     <div class="col ps-0">
                        <textarea name="qna_comment_content" class="form-control" rows="3"></textarea>
                        <input type="hidden" name="qna_freeboard_no" value="${QnaVO.QnaVO.qna_freeboard_no }">
                        <%--<input type="hidden" name="member_no" value="${sessionUser.member_no }"> --%>
                     </div>
                     <div class="col-3 d-grid">
                        <button class="btn btn-primary text-center" type="submit">댓글쓰기</button>
                     </div>
                  </div>
               </c:when>
               <c:otherwise>
                  <div class="row mb-3">
                     <div class="col ps-0">
                        <textarea  name="comment_content" class="form-control" rows="3" placeholder="접근 권한이 없습니다" disabled></textarea>
                     </div>
                     <div class="col-3 d-grid">
                        <button class="btn btn-primary text-center disabled">작성불가</button>
                     </div>
                  </div>
               </c:otherwise>

            </c:choose>
         </form>
               
<!-- 여기에 댓글들 넣기 -->

         <div class="row mb-2 mt-4">
            <div class="col">
               <h5 class="text-start">댓글(${commentCount })</h5>
            </div>
         </div>
         
         
   <c:forEach items="${qnaCommentList }" var="list">
      <div class="row mb-1 pb-2 border-bottom border-2">   
      <div class="col">
            <c:if test="${!empty sessionAdmin}">
               <div id="manager_comment_content" class="col-4 me-2 align-middle">
                  <span> ${list.ManagerVO.manager_nick } <br> 
                     ${list.QnaCommentVO.qna_comment_content}  <br>
                        <small><fmt:formatDate pattern="yy.MM.dd" value="${ list.QnaCommentVO.qna_comment_writedate}"/>
                        </small>   
                  </span>
               </div>      
               
                  <div class="col mt-2 ps-3">
                  <form class="form-Line"
                     action="${pageContext.request.contextPath }/qna/deleteCommentProcess.do"
                     method="post">
                  <input type="hidden"
                     value="${list.ManagerVO.manager_no }" name="manager_no">
                  <input type="hidden"
                     value="${list.QnaCommentVO.qna_comment_no }"
                     name="qna_comment_no"> 
                  <input type="hidden"
                     value="${list.QnaCommentVO.qna_freeboard_no }"
                     name="qna_freeboard_no">
                  <button class="col-1 pt-0 btn btn-outline-primary" style="float:right;" type="submit">삭제</button>
               </form>

               
               
                  <form class="form-Line"
                     action="${pageContext.request.contextPath }/qna/modifyCommentPage.do"
                     method="post">
                     <input type="hidden" value="${list.ManagerVO.manager_no }"
                        name="manager_no"> 
                     <input type="hidden"
                        value="${list.QnaCommentVO.qna_comment_no }"
                        name="qna_comment_no"> 
                     <input type="hidden"
                        value="${list.QnaCommentVO.qna_freeboard_no }"
                        name="qna_freeboard_no">
                     <button class="col-1  pb-0 btn btn-outline-danger" style="float:right;" type="submit">수정</button>
                  </form>   
               </div>
            </c:if>
         
         
         
         
         
            <c:if test="${!empty sessionUser && sessionUser.member_no eq list.MemberVO.member_no }">
               <div id="member_comment_content" class="row py-2">
                  <div class="col-2 me-2 align-middle">
                     <span> ${list.MemberVO.member_nick } <br> 
                           <small><fmt:formatDate pattern="yy.MM.dd" value="${ list.QnaCommentVO.qna_comment_writedate}"/>
                           </small>
                     </span>
                  </div>
                  
                  <div class="col mt-2 ps-3">
                     ${list.QnaCommentVO.qna_comment_content}
                  </div>
                  <div class="col-3 d-grid">
                     <div class="row">
                        <form class="col d-grid mx-0"
                           action="${pageContext.request.contextPath }/qna/modifyCommentPage.do"
                           method="post">
                           <input type="hidden" value="${list.MemberVO.member_no }"
                              name="member_no"> 
                           <input type="hidden"
                              value="${list.QnaCommentVO.qna_comment_no }"
                              name="qna_comment_no"> 
                           <input type="hidden"
                              value="${list.QnaCommentVO.qna_freeboard_no }"
                              name="qna_freeboard_no">
                           <button id="modify_member_btn" class="btn btn-outline-primary" type="submit">수정</button>
                        </form>
                        <form class="col d-grid mx-0"
                           action="${pageContext.request.contextPath }/qna/deleteCommentProcess.do"
                           method="post">
                           <input type="hidden"
                              value="${list.MemberVO.member_no }" name="member_no">
                           <input type="hidden"
                              value="${list.QnaCommentVO.qna_comment_no }"
                              name="qna_comment_no"> 
                           <input type="hidden"
                              value="${list.QnaCommentVO.qna_freeboard_no }"
                              name="qna_freeboard_no">
                           <button  class="btn btn-outline-danger" type="submit">삭제</button>
                        </form>
                     </div>
                  </div>
                  </div>
            </c:if>
            </div>
         </div>
      </c:forEach>


            </div>
            </div></div>
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