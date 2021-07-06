<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>

		<!-- 최상단 네비 -->
		<div class="row">
			<nav id="adindex_navbar" class="navbar">
				<div class="col-2"></div>
				<div class="col">
					<nav class="nav">
						<a id="text_link" class="nav-link active" aria-current="page" href="#">Active</a>
						<a class="nav-link" href="#">Link</a>
						<a class="nav-link" href="#">Link</a>
						<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
					</nav>
				</div>
				<div class="col">
					<nav class="nav float-end">
						<c:choose>
							<c:when test="${!empty sessionAdmin }">
								<a class="nav-link active text-decoration-none" aria-current="page" href="#">${sessionAdmin.manager_nick }</a>
								<a class="nav-link" href="${pageContext.request.contextPath}/manager/logoutProcess.do">LOGOUT</a>
							</c:when>
							<c:otherwise>
								<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/manager/managerLoginPage.do">LOGIN</a>
								<a class="nav-link" href="${pageContext.request.contextPath}/manager/joinManagerPage.do">REGISTER</a>
							</c:otherwise>
						</c:choose>
						
						<a class="nav-link" href="#">Link</a>
						<%-- <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a> --%>
						<form class="d-flex">
							<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
							<button class="btn btn-outline-secondary border border-light" type="submit">Search</button>
						</form>
					</nav>
				</div>
				<div class="col-2"></div>
			</nav>
		</div> 
		<!-- ? -->
		<div class="row my-5">
			<div class="col"></div>
			<div class=" col-8 text-center">
				<span id="fishing">
					<a class="text-decoration-none text-dark" href="${pageContext.request.contextPath }/manager/managerIndexPage.do">
						<img src="${pageContext.request.contextPath }/resources/img/favpng_fishing-clip-art.png" width="100" height="100">&nbsp;Fishing Mate 
					</a>
				</span>
			</div>
			<div class="col"></div>
		</div>
		<hr class="mb-2">
		<div class="row mb-0">
			<div class="col"></div>
			<div class="col-8">
				<nav class="navbar mb-0">
					<div class="row">
						<div class="col">
							<button type="button" class="btn btn-secondary" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-content="Bottom popover">
								Popover
							</button>
						</div>
						<div class="col">
							<div class="dropdown">
								<a class="btn btn-outline-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
									리스트들
								</a>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<li><a class="dropdown-item" href="${pageContext.request.contextPath }/manager/managerEventList.do">Admin Event List</a></li>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath }">B</a></li>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath }">C</a></li>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath }">D</a></li>
								</ul>
							</div>
						</div>
					</div>
				</nav>
			</div>
			<div class="col"></div>
		</div>
		<hr class="m-0 p-0">
	</header>