<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css"> 
	<div class="row border-bottom borer-1 pb-2 mb-3">
		<div class="col d-grid">
	      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/wishlist.do?member_no=${sessionUser.member_no}"><i class="bi bi-bookmark-heart-fill"></i> 위시리스트(찜)</a>
	   </div>
	   <div class="col d-grid">
	      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/mateWishListPage.do"><i class="bi bi-emoji-heart-eyes"></i> 위시리스트(메이트)</a>
	   </div>
	   <div class="col d-grid">
	      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/friendPage.do"><i class="bi bi-people-fill"></i> 친구페이지(찾기/추가/리스트)</a>
	   </div>
	   <div class="col d-grid">
	      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/messagePage.do"><i class="bi bi-envelope-fill"></i> 메세지(쪽지보내기/확인)</a>
	   </div>
	</div>