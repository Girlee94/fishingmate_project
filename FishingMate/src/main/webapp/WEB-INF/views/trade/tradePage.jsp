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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/tradePage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">

<script src="https://www.gstatic.com/charts/loader.js"></script>

<script>

	google.charts.load('current', {'packages':['line','corechart']});
	google.charts.setOnLoadCallback(drawChart1);
	google.charts.setOnLoadCallback(drawChart2);
    
	var statistics_modal=null;
    
	function drawChart1(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
        
        
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);

				var data = new google.visualization.DataTable();
				
				data.addColumn('string', 'Day');
			    data.addColumn('number', 'cnt');
			    
			    for(x of obj){
			    	data.addRow([x.TR_DATE , x.TR_CNT]);
			    }
			    
		      var options = {
		    	        chart: {
		    	          title: '일별 중고 거래 등록 횟수',
		    	          subtitle: 'in millions of dollars (USD)'
		    	        },
		    	        width: 600,
		    	        height: 300
		    	      };			    
			    
		      var chart = new google.charts.Line(document.getElementById('graph1'));
		      chart.draw(data, google.charts.Line.convertOptions(options));	
		      //chart.setAttribute("style","color:red;");
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/getCountByDate.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		
		
		

		
		
	}

	
	
	function drawChart2(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
        
        
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);

				var data = new google.visualization.DataTable();
				
				data.addColumn('string', 'gender');
			    data.addColumn('number', 'cnt');
			    
			    for(x of obj){
			    	data.addRow([x.T_GENDER , x.T_CNT]);
			    }
			    
		      var options = {
		    	        chart: {
		    	          title: '일별 중고 거래 등록 횟수',
		    	          subtitle: 'in millions of dollars (USD)'
		    	        },
		    	        width: 600,
		    	        height: 300
		    	      };			    
			    
		      var chart = new google.visualization.PieChart(document.getElementById('graph2'));
		      chart.draw(data, google.charts.Line.convertOptions(options));	
		      //chart.setAttribute("style","color:red;");
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/getCountByGender.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		
		
		

		
		
	}
	
	function staticsModal(){
		statistics_modal.show();	
	}
	
	function statisticsModalHide() {
		statistics_modal.hide();
	}
	
function init() {
	
	
	statistics_modal= new bootstrap.Modal(document.getElementById('statisticsModal'));
}
	 
	 
</script>

</head>
<body onload="init();">
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
							<span class="fs-2 fw-bold">중고거래</span>
							
						</div>
				</div>	
							
				<div class="row mt-3 mb-2">
				    <div class="col-1"></div>
					<div class="col-1 pe-0 align-self-center">
						<a href="${pageContext.request.contextPath}/trade/tradePage.do" style="text-decoration:none"><span style="color: gray;"><i class="bi bi-house-door-fill"></i>&nbsp;홈 </span></a>
					    <span style="color: gray;">&nbsp;&nbsp;></span>
					</div>
					<div class="col-2">
					   <select class="form-select" aria-label="Default select example" name="item_category_no">
						 <option>전체보기</option>
							<c:forEach items="${itemCategoryList}" var="itemCategoryList">
								<option value="${itemCategoryList.item_category_no}">${itemCategoryList.item_category_name}</option>
							</c:forEach>  
					   </select>
					</div>
					<div class="col-6">
					   <input class="form-control" type="text">					   
					</div>
					<div class="col-1"><span style="font-size:25px;"><i class="bi bi-search"></i></span></div>
					
				</div>
				<div class="row mt-1 mb-3">
				   
				    <div class="col text-end pe-4 ps-0" onclick="staticsModal()"> <i class="bi bi-graph-up" style="font-weight:bold;"></i>&nbsp; <span style="color:gray;">통계</span></div>
				</div>
				<!--  
				<div class="row mt-3 mb-3">
				   <div class="col-1"></div>
					<div class="col"> 
						<div class="dropdown">
							<button class="btn btn-secondary dropdown-toggle" type="button"
								id="dropdownMenuButton1" data-bs-toggle="dropdown"
								aria-expanded="false">검색기준</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="#">상품명</a></li>
								<li><a class="dropdown-item" href="#">작성자</a></li>
							</ul>
							
						</div>
					</div>
				</div> -->
				
								<!--중고거래 카드뉴스  -->
				<div class="row" id="trade_card_list">
				    <div class="col-1"></div>
				      <div class="col">
				       <div class="row">
						<c:forEach items="${tradeList }" var="tradeList" >
							<div class="col-4 mb-3">
							<a href="${pageContext.request.contextPath}/trade/readProductPage.do?trade_freeboard_no=${tradeList.tradeVO.trade_freeboard_no}" style="text-decoration:none;color:black; ">
							<div class="card">
								<img src="/upload_files/${tradeList.tradeImageVO[0].image_location}" class="card-img-top" onerror="this.src='${pageContext.request.contextPath}/resources/img/noimage.gif'">
								 <div class="card-body p-2">
								   <div class="row mt-3 ps-1" ><p style="font-size:13px; color:gray;" class="card-text">${tradeList.itemCategoryVO.item_category_name }</p></div>
								   <div class="row ps-1 mb-3" ><p style="font-size:25px;" class="card-text text-truncate">${tradeList.tradeVO.trade_freeboard_title }</p></div>
								   <div class="row ps-1 mb-1"><p class="card-text" style="font-size:20px;"><img src="${pageContext.request.contextPath}/resources/img/money_won.png" style="width:18px;height:18px;">&nbsp;${tradeList.tradeVO.trade_freeboard_itemprice }원</p></div>
								   <div class="row ps-1 mb-2 ">
								        <div class="col mb-2 text-truncate"><i class="bi bi-person-fill"></i>&nbsp;${tradeList.memberVO.member_nick }</div>
								         <c:if test="${tradeList.tradeStatus == '판매완료' }">
									          <div class="col-4 mb-2 p-0 pe-4 text-end" style="color:red; font-weight:bold;">${tradeList.tradeStatus}</div>
									      </c:if>
									      <c:if test="${tradeList.tradeStatus == '판매중' }">
									          <div class="col-4 mb-2 p-0 pe-4 text-end" style=" font-weight:bold;">${tradeList.tradeStatus}</div>
									      </c:if> 
									    <p class="card-text border-bottom"> </p>
								   </div>
								  <div class="row mt-2" style="font-size:12px;">
								       <div class="col ps-3"><i class="bi bi-emoji-smile"></i>&nbsp;조회&nbsp;<b>${tradeList.tradeVO.trade_freeboard_readcount }</b>회&nbsp;&nbsp;  
												 	   <i class="bi bi-emoji-heart-eyes"></i>&nbsp;찜&nbsp;<b>${tradeList.tradeVO.trade_freeboard_wishcount }</b></div>
									   <div class="col-4 ps-3"> <fmt:formatDate value="${tradeList.tradeVO.trade_freeboard_writedate }" pattern="yy-MM-dd"/></div>
								   </div>							   
								</div>
							</div>
							</a>
							</div>
						</c:forEach>
					  </div>	
					</div>						
			   </div>
			<div class="row mt-3 mb-3">
			    <div class="col">&nbsp;</div>
				<div class="col" >
					<nav aria-label="Page navigation example">
                          <ul class="pagination">
                            <li class="page-item">
                              <a class="page-link" href="#" aria-label="Previous" style="color: black; text-decoration: none;">
                                <span aria-hidden="true">&laquo;</span>
                                    </a>
                                     </li>
                                     &nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#" style="color: black; text-decoration: none;">1</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#" style="color: black; text-decoration: none;">2</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#" style="color: black; text-decoration: none;">3</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#" style="color: black; text-decoration: none;">4</a></li>&nbsp;&nbsp;
                                     <li class="page-item"><a class="page-link" href="#" style="color: black; text-decoration: none;">5</a></li>&nbsp;&nbsp;
                                     <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next" style="color: black; text-decoration: none;">
                                <span aria-hidden="true">&raquo;</span>
                              </a>
                            </li>
                          </ul>
                        </nav>
				</div>  
				<div class="col-2 d-flex ms-auto justify-content-end align-self-center" >
				<c:if test="${! empty sessionUser  }">
				  <a href="${pageContext.request.contextPath}/trade/productRegistration.do" style="text-decoration:none;color:black; font-size:20px; " class="btn btn-writeBtn"><i class="bi bi-pencil-square"></i>&nbsp;글쓰기</a>
				</c:if>
				</div>
			</div>

		</div>

	</div>

</div>

</div>
<!--========================================= Modal 시작 ================================================-->
<!--통계  -->
<div class="modal fade" id="statisticsModal" tabindex="-1" aria-labelledby="statisticsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statisticsModalLabel">Statistics</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
					
				<div class="row">
					<div class = "col" id="graph1"></div>
				</div>
				<div class="row">
					<div class = "col" id="graph2"></div>
				</div>
				
				
				
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="statisticsModalHide()">뒤로가기</button>
      </div>
    </div>
  </div>
</div>

 
<!--========================================= Modal 끝 ================================================-->
	<div style="width: 100%; margin: 0 auto;">
		<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
		<!-- 푸터 끝 -->
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>