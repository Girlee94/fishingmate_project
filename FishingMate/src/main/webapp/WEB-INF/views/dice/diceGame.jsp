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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css"> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/reviewPage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/dice.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/fishingShare.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
</head>

<script type="text/javascript">
	var sessionMemberNo = null;
	var moveDiceHandler = null;

	//로그인한 회원의 회원번호 불러오기
	function getSessionMemberNo() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
	
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
			
				sessionMemberNo = obj.member_no;
			
			}
		};
	
		xmlhttp.open("get","${pageContext.request.contextPath}/member/getSessionMemberNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	// 쌓인 잭팟 머니, 내 경험치 자동 호출
	function diceMoney(plmaMoney) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
	
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				
				document.getElementById("currentJackpotMoney").innerText = obj.currentJackpotMoney;
				document.getElementById("myLevelValue").innerText = obj.myLevelValue;	
				
				var plmaSpan = document.createElement("span");
				
				if (plmaMoney > 0) {
					plmaSpan.setAttribute("class", "text-danger");
				} else if (plmaMoney < 0) {
					plmaSpan.setAttribute("class", "text-info");
				} else {
					plmaSpan.setAttribute("class", "text-light");
				}
				
				plmaSpan.innerText = "(" + plmaMoney + ")";
				document.getElementById("myLevelValue").appendChild(plmaSpan);
				
				
			}
		};
	
		xmlhttp.open("get","${pageContext.request.contextPath}/dice/diceGame.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	

			function dice() {
				
				
				if(sessionMemberNo == null){
					alert("로그인을 하셔야 주사위를 굴릴수 있습니다.");
					return;
				}
				
				if(document.getElementById("bet2").value == "" && document.getElementById("bet3").value == "" && document.getElementById("bet23").value == "" && document.getElementById("bet1").value == ""){
					alert("배팅 경험치가 존재 하지 않습니다.");
					return;
				}
				

				/* 에이작스로 바로 가능하지만 오류 뜰수도 있음
				var a = Math.random() * 6;

				var b = Math.random() * 6;

				

				a = Math.ceil(a);

				b = Math.ceil(b);
				 */

				//AJAX 호출.....
				var xmlhttp = new XMLHttpRequest();

				//호출 후 값을 받았을때... 처리 로직....
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						var obj = JSON.parse(xmlhttp.responseText);
						
						
						if(obj.result == 'fail'){
							alert(obj.reason + " , 현재 남은 내 경험치 : " + obj.myLevelValue);
							
							return;
						}
					
						
						if(moveDiceHandler != null){
							clearInterval(moveDiceHandler);
							moveDiceHandler = null;
						}
						
						moveDiceHandler = setInterval(moveDice , 50);
						setTimeout(realDice , 1000 , obj);
						
						/*
						document.getElementById("dice1Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice1 + ".png";
						document.getElementById("dice2Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice2 + ".png";
						document.getElementById("dice3Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice3 + ".png";
						document.getElementById("dice4Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice4 + ".png";
						document.getElementById("dice5Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice5 + ".png";
						*/
						
						

					}
				};

				
				var bet2Value = document.getElementById("bet2").value;
				var bet3Value = document.getElementById("bet3").value;
				var bet23Value = document.getElementById("bet23").value;
				var bet1Value = document.getElementById("bet1").value;
		
				
				bet2Value = bet2Value.replaceAll(",", "");
				bet3Value = bet3Value.replaceAll(",", "");
				bet23Value = bet23Value.replaceAll(",", "");
				bet1Value = bet1Value.replaceAll(",", "");


				
				xmlhttp.open("post", "${pageContext.request.contextPath}/dice/throwDice.do", true);
				xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xmlhttp.send("bet2=" + bet2Value + "&bet3=" + bet3Value + "&bet23=" + bet23Value + "&bet1=" + bet1Value);
				
				
				

			}			
			
			function realDice(obj){
				
				if(moveDiceHandler != null){
					clearInterval(moveDiceHandler);
					moveDiceHandler = null;
				}
				
				
				document.getElementById("dice1Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice1 + ".png";
				document.getElementById("dice2Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice2 + ".png";
				document.getElementById("dice3Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice3 + ".png";
				document.getElementById("dice4Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice4 + ".png";
				document.getElementById("dice5Img").src = "${pageContext.request.contextPath }/resources/img/dice" + obj.dice5 + ".png";

				
				diceMoney(obj.plma);
				
				console.log("=================================");
				console.log("[2의 배수]" + obj.bet2 + ")");
				console.log("[3의 배수]" + obj.bet3 + ")");
				console.log("[2,3의 배수 제외]" + obj.bet23 + ")");
				console.log("[주사위1]" + obj.bet1 + ")");
				
				console.log("[내가 건돈 총합]" + obj.totalBetMoney);
				console.log("[상금 머니]" + obj.winMoney);
				console.log("[내가 딴 머니]" + obj.plma);
				console.log("stopped");
				
				if(obj.Great == true){
					alert("잭팟!!!!!!!!!");
				}
				
				
			}
			
			
			function moveDice(){
				
				
				var x = parseInt(Math.random()*6 + 1);
				document.getElementById("dice1Img").src = "${pageContext.request.contextPath }/resources/img/dice" + x + ".png";
				var x = parseInt(Math.random()*6 + 1);
				document.getElementById("dice2Img").src = "${pageContext.request.contextPath }/resources/img/dice" + x + ".png";
				var x = parseInt(Math.random()*6 + 1);
				document.getElementById("dice3Img").src = "${pageContext.request.contextPath }/resources/img/dice" + x + ".png";
				var x = parseInt(Math.random()*6 + 1);
				document.getElementById("dice4Img").src = "${pageContext.request.contextPath }/resources/img/dice" + x + ".png";
				var x = parseInt(Math.random()*6 + 1);
				document.getElementById("dice5Img").src = "${pageContext.request.contextPath }/resources/img/dice" + x + ".png";
			}
			
		
			
			//배팅 머니에 콤마
			 function inputNumberFormat(obj) {
			     obj.value = comma(uncomma(obj.value));
			 }
			 
			 function comma(str) {
			     str = String(str);
			     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			 }
			 
			 function uncomma(str) {
			     str = String(str);
			     return str.replace(/[^\d]+/g, '');
			 }
			
			
			
			function init(){
				getSessionMemberNo();
				diceMoney(0);
								
			}
			
		</script>
<body onload="init()">
		<div style="width: 1200px; margin: 0 auto;">
		<!-- 헤더 -->
			<jsp:include page="/WEB-INF/views/commons/header.jsp" />
		<!-- 헤더 끝 -->
		</div>
		
		<div style="width: 100%; margin: 0 auto; background-color: black;">
		<div id="text" style="width: 1200px; margin: 0 auto; background-color: black;" >		
		<div class="container-fluid">
			<div class="row">
				<div class="col"></div>
				<div class="col-7 pt-5 text-center" id="aaa">
					<img src="${pageContext.request.contextPath }/resources/img/dice_title.png"><br>
					<br>
					<div>
					총 쌓인 경험치 &nbsp;&nbsp; <span id="currentJackpotMoney">0</span><br>
					내 경험치 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="myLevelValue">0</span>
									
					</div>
					<br>
	
					<div class="row">
						<div class="col"></div>
						<div class="col-8 pt-10"> 
							<img id="dice1Img" src="${pageContext.request.contextPath }/resources/img/dice1.png">
							<img id="dice2Img" src="${pageContext.request.contextPath }/resources/img/dice2.png">
							<img id="dice3Img" src="${pageContext.request.contextPath }/resources/img/dice3.png">
							<img id="dice4Img" src="${pageContext.request.contextPath }/resources/img/dice4.png">
							<img id="dice5Img" src="${pageContext.request.contextPath }/resources/img/dice5.png"><br> <br>
						</div>
						<div class="col"></div>
					</div>
					
					<br>
					<br>
					<br>
					<br>
					
				
					
					<!-- 2의 배수 = 1.6배<br>
					3의 배수 = 2.4배<br>
					2와3의 배수 제외 = 2배<br>
					배팅금액 * 주사위1의 갯수<br>				
					잭팟(1,1,1,1,1) = 배팅 상관없이 쌓인 금액 모두지급<br> -->
					<div class="row">
					<div class="col"></div>
					<div class="col-8 mt-5">
						<table class="dicetable w-100">
		    			<thead>
			   				
		    			</thead>
		    			<tbody>
						    <tr>
						        <td>배팅 종류</th>
						        <td>배팅 배당</th>
						        
						    </tr>
						    <tr>
						        <td>2의 배수</th>
						        <td>2배</th>
						        
						    </tr>
						    <tr>
						        <td>3의 배수</th>
						        <td>2.5배</th>					        
						    </tr>
						    <tr>
						        <td>2와 3의 배수 모두 제외</th>
						        <td>2.5배</th>
						        
						    </tr>
						    <tr>
						        <td>주사위 1</th>
						        <td>배팅금액 * 주사위1 갯수</th>
						        
						    </tr>
						    </tbody>
						</table>
					</div>
					<div class="col"></div>
					</div>			
					<br>
					<!-- <div class="row">
					<div class="col"></div>
					<div class="col-3 mx-auto">
						<button class="btn btn-primary" onclick="dice()">굴려라~~</button>
					</div>
					<div class="col"></div>
					</div> -->
					<br>
				
				<%--
						<input type="radio" name="batting_category_no">2의 배수
						<input type="text" placeholder="배팅금액"><br>
						<input type="radio" name="batting_category_no">3의 배수
						<input type="text" placeholder="배팅금액"><br>					
						<input type="radio" name="batting_category_no">2와3의 배수 제외
						<input type="text" placeholder="배팅금액"><br>
						<input type="checkbox" name="dice_allone">올1
						<input type="text" placeholder="배팅금액"><br>
				 --%>
						<!-- 2의 배수 : <input id="bet2" type="text" placeholder="배팅금액"><br>
						3의 배수 :	<input id="bet3" type="text" placeholder="배팅금액"><br>
						2와3의 배수 제외 :<input id="bet23" type="text" placeholder="배팅금액"><br>
						주사위1 갯수<input id="bet1" type="text" placeholder="배팅금액"><br>
						<br>
						<br>
						<br>
						<br> -->
					
				</div>
				<div class="col"></div>
			</div>
		</div>
	</div>
	</div>
	<!-- 퀵메뉴 시작 오른쪽 -->
      <div id="quick_menu2" class="list-group">
          2의 배수  <input id="bet2" type="text" onkeyup="inputNumberFormat(this)" placeholder="배팅 &nbsp;경험치"><br>
		  3의 배수 	<input id="bet3" type="text" onkeyup="inputNumberFormat(this)" placeholder="배팅 &nbsp;경험치"><br>
		  2와3의 배수 제외 <input id="bet23" type="text" onkeyup="inputNumberFormat(this)" placeholder="배팅 &nbsp;경험치"><br>
		    주사위1<input id="bet1" type="text" onkeyup="inputNumberFormat(this)" placeholder="배팅 &nbsp;경험치"><br>
		  <button class="btn btn-success" onclick="dice()"><img src="${pageContext.request.contextPath }/resources/img/dicethrow.png"/></button>
      </div>
    <!-- 퀵메뉴 끝 -->
    
    <!-- 퀵메뉴 시작 왼쪽 -->
<!--        <div id="quick_menu" class="list-group"> -->
<%--           <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/fishingGame/fishingGame.do"> --%>
<%--           <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/fish_3.png"/>&nbsp;낚시터</a> --%>
<%--           <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/fishingshare/fishingshare.do"> --%>
<%--           <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/trend.png"/>&nbsp;주식시장</a> --%>
<%--           <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/dice/dicePage.do"> --%>
<%--           <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/dice.png"/>&nbsp;DICE</a> --%>
<%--           <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/infofreeboard/lotto45.do"> --%>
<%--           <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/lottery.png"/>&nbsp;lotto45</a> --%>
<!--         </div> -->
     <!-- 퀵메뉴 끝 -->
<jsp:include page="/WEB-INF/views/commons/gameRemote.jsp" />


	<div style="width: 100%; margin: 0 auto;">
	<!-- 푸터 -->
		<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>