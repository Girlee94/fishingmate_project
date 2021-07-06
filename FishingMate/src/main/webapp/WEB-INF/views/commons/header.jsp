<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
		<!-- 최상단 네비 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col pe-0">
					<nav class="nav float-end" id="top_nav">
						<c:choose>
							<c:when test="${!empty sessionUser }">
									<a class="nav-link active text-decoration-none" aria-current="page" href="#">${sessionUser.member_nick }</a>
									<a class="nav-link" href="${pageContext.request.contextPath}/member/logoutProcess.do">LOGOUT</a>
									<a class="nav-link" href="${pageContext.request.contextPath }/member/myPage.do?member_no=${sessionUser.member_no}">My Page</a>
							</c:when>
							<c:when test="${!empty sessionAdmin }">
									<a class="nav-link active text-decoration-none" aria-current="page" href="#">${sessionAdmin.manager_nick }</a>
									<a class="nav-link" href="${pageContext.request.contextPath}/member/logoutProcess.do">LOGOUT</a>
							</c:when>
							<c:otherwise>
									<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/member/loginPage.do">LOGIN</a>
									<a class="nav-link" aria-current="page" href="${pageContext.request.contextPath }/manager/managerLoginPage.do">MANAGER</a>
									<a class="nav-link" href="${pageContext.request.contextPath}/member/joinMemberPage.do">JOIN</a>
							</c:otherwise>
						</c:choose>
					</nav>
				</div>
			</div>
			<div class="row">
				<nav id="index_navbar" class="navbar">
					<div class="col">
						<div class="row">
							<div class="col me-5">   
								<img id="header_logo" onclick="moveHome()" class="w-100" src="${pageContext.request.contextPath }/resources/img/logo2.png">
							</div>
							<div class="col-9 ms-2 pe-0">
								<nav class="nav float-end mt-2">
									<ul class="ps-0 d-grid" style="list-style: none;">
										<li onmouseover="visibleMenu(this)" onmouseleave="inVisibleMenu(this)">
											<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
												GAMES
											</a>
									 		<div class="bg-white" style="display:none;">
												<a class="dropdown-item" href="${pageContext.request.contextPath }/fishingGame/fishingGame.do">낚시터</a>
												<a class="dropdown-item" href="${pageContext.request.contextPath }/fishingshare/fishingshare.do">주식시장</a>
												<a class="dropdown-item" href="${pageContext.request.contextPath }/dice/dicePage.do">DICE</a>
												<a class="dropdown-item" href="${pageContext.request.contextPath }/infofreeboard/lotto45.do">lotto45</a>
												<a class="dropdown-item" href="${pageContext.request.contextPath }/infofreeboard/battinglotto45.do">battinglotto45</a>
											</div>
										</li>
									</ul>
									<ul class="ps-0 d-grid" style="list-style: none;">
										<li onmouseover="visibleMenu(this)" onmouseleave="inVisibleMenu(this)">
											<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
												커뮤니티
											</a>
											<div class="bg-white" style="display:none;">
												<a class="dropdown-item d-grid" href="${pageContext.request.contextPath }/infofreeboard/infofreeboard.do">INFO</a>
												<a class="dropdown-item d-grid" href="${pageContext.request.contextPath }/main/boast.do">SHOWOFF</a>
												<a class="dropdown-item d-grid" href="${pageContext.request.contextPath }/mate/matePage.do">MATE</a>
												<a class="dropdown-item d-grid" href="${pageContext.request.contextPath }/review/reviewPage.do">FREE</a>
												<a class="dropdown-item d-grid" href="${pageContext.request.contextPath }/trade/tradePage.do">중고거래</a>
											</div>
										</li>
									</ul>
									<a class="nav-link" href="${pageContext.request.contextPath }/qna/QnaListPage.do" onmouseover="highlightButton(this)" onmouseleave="unHighlightButton(this)">Q&A</a>
									<a class="nav-link" href="${pageContext.request.contextPath }/event/eventPage.do" onmouseover="highlightButton(this)" onmouseleave="unHighlightButton(this)">Fishing Festival</a>
									
								</nav>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</div>
	</header>