<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
		<span class="fw-bold fs-3 mb-2">
			Event
		</span>
		<ul id="eventPPP" class="mt-3 ps-0">
			<c:if test="${num == 1}">
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath}/event/eventPage.do?searchNo=1">전체 이벤트</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=2">진행중 이벤트</a></li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=3">예정된 이벤트</a></li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=4">종료된 이벤트</a></li>
			</c:if>
			<c:if test="${num == 2}">
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=1">전체 이벤트</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=2">진행중 이벤트</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=3">예정된 이벤트</a></li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=4">종료된 이벤트</a></li>
			</c:if>
			<c:if test="${num == 3}">
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=1">전체 이벤트</a></li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=2">진행중 이벤트</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=3">예정된 이벤트</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=4">종료된 이벤트</a></li>
			</c:if>
			<c:if test="${num == 4}">
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=1">전체 이벤트</a></li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=2">진행중 이벤트</a></li>
				<li><a href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=3">예정된 이벤트</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/event/eventPage.do?searchNo=4">종료된 이벤트</a>
				</li>
			</c:if>
		</ul>
</header>