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
						Message_
					</span>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/member/myPageTop.jsp" />
		<div class="row">
			<div class="col fw-bold">
			
				<div class="row">
				
					<div class="col-2 text-center">
						<a href="${pageContext.request.contextPath }/member/messagePage.do?message_type=1" class="btn btn-outline-secondary"><i class="bi bi-pencil-square"></i> 쪽지 쓰기</a><br><br>
						<a href="${pageContext.request.contextPath }/member/messagePage.do?message_type=2" class="btn btn-outline-secondary"><i class="bi bi-envelope"></i> 받은 쪽지</a><br><br>
						<a href="${pageContext.request.contextPath }/member/messagePage.do?message_type=3" class="btn btn-outline-secondary"><i class="bi bi-envelope-fill"></i> 보낸 쪽지</a><br><br>
						
					</div>
					<div class="col">
						<c:choose>
							<c:when test="${message_type == 1 }">
								<i class="bi bi-person-check"></i> 받는 사람_
								
								<form action="${pageContext.request.contextPath }/member/insertSendMessage.do" method="get">
										<c:forEach items="${friends }" var="cfl" varStatus="status">
											<input type="radio" name="to_member_no" value="${cfl.memberVO.member_no }">${cfl.memberVO.member_nick }
										</c:forEach>
									<div class="mb-3">
										<textarea name = "message_content" class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
										<input type="hidden" value="1" name="message_type">
									</div>
									<div class="mb-3 position-end">
										<input type="submit" value="보내기">
										<!-- <a href="${pageContext.request.contextPath }/member/insertSendMessage.do?to_member_no=${cfl.memberVO.member_no }" type="submit" class="btn btn-outline-secondary">보내기</a> -->
									</div>
								</form>
							</c:when>
							<c:when test="${message_type == 2 }">
								<form action="./deleteMessageProcess.do" method="post">
							
								<i class="bi bi-envelope"></i> 받은쪽지
								
								<table class="table table-hover">
								 <thead>
								    <tr>
								      <th scope="col">#</th>
								      <th scope="col"><i class="bi bi-person"></i> 보낸 사람</th>
								      <th scope="col"><i class="bi bi-chat-square-text"></i> 쪽지 내용</th>
								      <th scope="col"><i class="bi bi-calendar"></i> 받은 날짜</th>
								      <th scope="col"><i class="bi bi-envelope-open"></i> 수신 확인</th>
								      <th scope="col"><i class="bi bi-calendar-check"></i> 확인 날짜</th>
								    </tr>
								  </thead>
								  <tbody>
								  	<c:forEach items="${inBoxList}" var="ddd" varStatus="status">
								  		<tr>
								  			<th scope="row">
								  				<input type="checkbox" name="sendmessage_no" value="${ddd.messageVO.sendmessage_no }">
								  			</th>
								  			<td>${ddd.memberVO.member_nick }</td>
								  			<td><a href="${pageContext.request.contextPath }/member/readMessage.do?sendmessage_no=${ddd.messageVO.sendmessage_no}">${ddd.messageVO.message_content }</a></td>
								  			<td><fmt:formatDate pattern="yyyy/MM/dd" value="${ddd.messageVO.message_senddate }" /></td>
								      		<td>${ddd.messageVO.message_readcheck }</td>
								      		<td><fmt:formatDate pattern="yyyy/MM/dd" value="${ddd.messageVO.message_readdate }" /></td>
								  		</tr>
									</c:forEach>
								
								  </tbody>
								</table>
								<input type="submit" value="지우기">
								</form>
								<%-- <c:forEach items="${inBoxList}" var="ddd">
								${ddd.messageVO.message_content } : ${ddd.memberVO.member_nick }<br>
								
								</c:forEach> --%>
								
							</c:when>
							<c:otherwise>
								<i class="bi bi-envelope-fill"></i> 보낸쪽지
								
									<table class="table table-hover">
									 <thead>
									    <tr>
									      <th scope="col">#</th>
									      <th scope="col"><i class="bi bi-person-fill"></i> 받는 사람</th>
									      <th scope="col"><i class="bi bi-chat-square-text-fill"></i> 쪽지 내용</th>
									      <th scope="col"><i class="bi bi-calendar-fill"></i> 보낸 날짜</th>
									      <th scope="col"><i class="bi bi-envelope-open-fill"></i> 수신 확인</th>
									      <th scope="col"><i class="bi bi-calendar-check-fill"></i> 확인 날짜</th>
									    </tr>
									  </thead>
									  <tbody>
									  	<c:forEach items="${sendMessageList}" var="sss" varStatus="status">
									  		<tr>
									  			<th scope="row">
									  				<input type="checkbox" value="${sss.messageVO.sendmessage_no }" name="sendmessage_no">
									  			</th>
									  			<td>${sss.memberVO.member_nick }</td>
									  			<td><a href="${pageContext.request.contextPath }/member/sendMsgRead.do?sendmessage_no=${sss.messageVO.sendmessage_no}">${sss.messageVO.message_content }</a></td>
									  			<td><fmt:formatDate pattern="yyyy/MM/dd" value="${sss.messageVO.message_senddate }" /></td>
									      		<td>${sss.messageVO.message_readcheck }</td>
									      		<td><fmt:formatDate pattern="yyyy/MM/dd" value="${sss.messageVO.message_readdate }" /></td>
									  		</tr>
									  		
									  		
									  		
										</c:forEach>
									
									  </tbody>
									</table>
									
								
								
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