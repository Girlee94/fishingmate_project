<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">


</head>
<body>
	
	
	<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	
	
	<div class="container-fluid mb-5">
		<div class="row border-bottom border-1 pb-2 mb-4">
			<div class="col text-center">
				<span id="updatefestivM">
				<img src="${pageContext.request.contextPath }/resources/img/typewriter.png" width="70" height="70">
					Friend Page_
				</span>
			</div>
		</div>
	
	
	<div class="row">
		<div class="col">
			<jsp:include page="/WEB-INF/views/member/myPageTop.jsp" />
			<div class="row">
				<div class="col p-3">
				
					<div class="row">
						<div class="col">
						
							<div class="row">
								<div class="col fw-bold">친구 리스트</div>
							</div>
							
							<c:forEach items="${ConfirmedFriendList.result }" var="cfl" varStatus="status">
								<div class="row">
									<div class="col">
										${cfl.youVO.member_nick }
									</div>
								</div>
								<div class="row">
									<div class="col">
										${cfl.meVO.member_nick }
									</div>
								</div>
							
							</c:forEach>
							
								
						</div>
					 	<div class="col">
					 		<div class="row">
					 			<div class="col fw-bold">보낸 친구 요청</div>
					 		</div>
					 		<c:forEach items="${meNo }" var="meNo">
					 			<div class="row">
					 				<div class="col">${meNo.memberVO.member_nick }</div>
					 				<div class="col">
					 					<c:if test="${meNo.memberFriendVO.friend_confirm != 'Y' }">
					 										 					
					 					<c:choose>
					 						<c:when test="${meNo.memberFriendVO.friend_confirm == 'D' }">
					 							수락 대기중
					 						</c:when>					 					
					 						<c:otherwise>
					 							수락 거절됨
					 						</c:otherwise>
					 					</c:choose>
					 					</c:if>
					 				</div>
					 			</div>
					 		</c:forEach>
					 	</div>
						<div class="col">
							<div class="row">
								<div class="col fw-bold">받은 친구 요청</div>
							</div>
							<c:forEach items="${youNo }" var="youNo">
								<div class="row">
									<div class="col">
										<c:if test="${youNo.memberFriendVO.friend_confirm == 'D' || youNo.memberFriendVO.friend_confirm == 'N'}">
											${youNo.memberVO.member_nick }
										</c:if>
									</div>
									<div class="col mb-2">
										<c:if test="${youNo.memberFriendVO.friend_confirm == 'D' }">
											<a class="btn btn-outline-secondary mb-1" href="${pageContext.request.contextPath }/member/updateConfirm.do?friend_no=${youNo.memberFriendVO.friend_no}">수락</a>
											<a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/updateRejection.do?friend_no=${youNo.memberFriendVO.friend_no}">거절</a>
										</c:if>
										<c:if test="${youNo.memberFriendVO.friend_confirm == 'N' }">
											<div class="btn btn-outline-danger">거절함</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					
					<div class="row">
						<div class="col fw-bold">
							<hr>
							<form action="${pageContext.request.contextPath }/member/setFrndGroup.do">
							친구 그룹 만들기 : <input type="text" name="friend_group_name">
								<input type="submit" value="그룹 생성">
							</form>
						</div>
						
					</div>
					<div class="row">
					<div class="col fw-bold">
							<hr>
					</div>
					</div>
					
					<div class="row">
						<div class="col fw-bold">친구 그룹</div>
						<div class="col fw-bold">친구 이름</div>
						<div class="col fw-bold">그룹 변경</div>
					</div>	
					<div class="row"> <!--그룹 친구 리스트 -->
						<div class="col">
							
							<div class="row border">
								<div class="col">기본그룹</div>
								<div class="col-8">
								<c:forEach items="${ConfirmedFriendList.basicResult }" var="gnl">
									<form action="${pageContext.request.contextPath }/member/changeGroupPage.do" method="get">
										<div class="row">
											
											<div class="col">
												${gnl.memberVO.member_nick }<br>
											
											</div>
											
											
											
											<div class="col">
												<select name="friend_group_no">
													<c:forEach items="${memberFriendGroupList }" var="ttt">
														<option value="${ttt.friend_group_no }">${ttt.friend_group_name }</option>
													</c:forEach>
												</select>																
											</div>
											
											<div class="col">
												<input type="hidden" name="friend_no" value="${gnl.memberFriendVO.friend_no }">
												<input type="submit" value="변경">
													
											</div>
															
											
										</div>
									</form>		
									</c:forEach>								
								</div>

							</div>
							
							
							<c:forEach items="${ConfirmedFriendList.groupResult }" var="gnl">
							<div class="row border">
								<div class="col">${gnl.group_name }</div>
								<div class="col">
									<a href="${pageContext.request.contextPath }/member/setGroupNamePage.do?friend_group_no=${gnl.friend_group_no }">
										수정
									</a>
								</div>
								<div class="col-8">
									
									
									<c:forEach items="${gnl.friendLists }" var="cfl">
									
									
									<form action="${pageContext.request.contextPath }/member/changeGroupPage.do" method="post">
										<div class="row">
											<div class="col">
												${cfl.memberVO.member_nick }
											</div>
											<div class="col">
												<select name="friend_group_no">
													<c:forEach items="${memberFriendGroupList }" var="ttt">
														<option value="${ttt.friend_group_no }">${ttt.friend_group_name }</option>
													</c:forEach>
												</select>																
											</div>
											<div class="col">
												<input type="hidden" name="friend_no" value="${cfl.memberFriendVO.friend_no }">
												<input type="submit" value="변경">						
											</div>
										</div>
									</form>										
									</c:forEach>
								</div>

							</div>
							</c:forEach>
						
						</div>
					</div>	
					
						 <c:forEach items="${groupNameList }" var="gnl">
						 	
						 </c:forEach>
							<div class="row">
								<div class="col">
									${gnl.groupVO.friend_group_name }
								</div>
							</div>
					
				</div>
				<div class="col">
					<div class="row mb-3">
						<div class="col d-flex justify-content-start">
							<form action="${pageContext.request.contextPath }/member/friendPage.do" method="get">
								<input class="mb-1" type="text" name="member_name">	
								<input type="submit" value="이름 검색" class="btn btn-outline-secondary">
							</form>
							<form class="ms-2" action="${pageContext.request.contextPath }/member/friendPage.do" method="get">
								<input class="mb-1" type="text" name="member_nick">
								<input type="submit" value="닉네임 검색" class="btn btn-outline-secondary">
							</form>
						</div>
					</div>
					<div class="row">
						
						<div class="col fw-bold">친구 검색 결과</div>
						<hr>
					</div>
					<c:choose>
						<c:when test="${!empty nameList }">
							<c:forEach items="${nameList }" var="nameList">
								<div class="row">
									<div class="col">
										<c:if test="${nameList.confirm != 'Y' && nameList.confirm != 'D' }">
											${nameList.memberVO.member_nick }
										</c:if>
									</div>
									<div class="col">
										<c:if test="${nameList.confirm != 'Y' && nameList.confirm != 'D' }">
											<a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/insertFriend.do?you_no=${nameList.memberVO.member_no }">친구신청</a>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${nickList }" var="nickList">
								<div class="row">
									<div class="col">
										<c:if test="${nickList.confirm != 'Y' && nickList.confirm != 'D' }">
											${nickList.memberVO.member_nick }		
										</c:if>
									</div>
									<div class="col">
										<c:if test="${nickList.confirm != 'Y' && nickList.confirm != 'D' }">
											<a class="btn btn-outline-secondary" href="${pageContext.request.contextPath }/member/insertFriend.do?you_no=${nickList.memberVO.member_no }">친구신청</a>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>	
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