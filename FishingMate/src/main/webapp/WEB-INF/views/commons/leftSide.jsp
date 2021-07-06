<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
		<span class="fw-bold fs-3 mb-2">
			커뮤니티
		</span>
		<ul id="rrr" class="mt-3 ps-0">
			<c:if test="${num == 1}">
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">INFO</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/main/boast.do">SHOWOff</a></li>
				<li><a href="${pageContext.request.contextPath }/mate/matePage.do">MATE</a></li>
				<li><a href="${pageContext.request.contextPath }/review/reviewPage.do">FREE</a></li>
				<li><a href="${pageContext.request.contextPath }/trade/tradePage.do">중고거래</a></li>
			</c:if>
			<c:if test="${num == 2}">
				<li><a href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">INFO</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/main/boast.do">SHOWOff</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/mate/matePage.do">MATE</a></li>
				<li><a href="${pageContext.request.contextPath }/review/reviewPage.do">FREE</a></li>
				<li><a href="${pageContext.request.contextPath }/trade/tradePage.do">중고거래</a></li>
			</c:if>
			<c:if test="${num == 3}">
				<li><a href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">INFO</a></li>
				<li><a href="${pageContext.request.contextPath }/main/boast.do">SHOWOff</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/mate/matePage.do">MATE</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/review/reviewPage.do">FREE</a></li>
				<li><a href="${pageContext.request.contextPath }/trade/tradePage.do">중고거래</a></li>
			</c:if>
			<c:if test="${num == 4}">
				<li><a href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">INFO</a></li>
				<li><a href="${pageContext.request.contextPath }/main/boast.do">SHOWOff</a></li>
				<li><a href="${pageContext.request.contextPath }/mate/matePage.do">MATE</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/review/reviewPage.do">FREE</a>
				</li>
				<li><a href="${pageContext.request.contextPath }/trade/tradePage.do">중고거래</a></li>
			</c:if>
			<c:if test="${num == 5}">
				<li><a href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">INFO</a></li>
				<li><a href="${pageContext.request.contextPath }/main/boast.do">SHOWOff</a></li>
				<li><a href="${pageContext.request.contextPath }/mate/matePage.do">MATE</a></li>
				<li><a href="${pageContext.request.contextPath }/review/reviewPage.do">FREE</a></li>
				<li>
					<a id="selected_freeboard" class="hr-sect" href="${pageContext.request.contextPath }/trade/tradePage.do">중고거래</a>
				</li>
			</c:if>
		</ul>
</header>
