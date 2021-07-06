<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/execDaumPostcode.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/fishingShare.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/fishingGame.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateReadContentPage.css">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(drawChart);
	var sessionMemberNo = null;
	var fishLogNo = 0;
	var chattingNo = 0;
	var modalfish= null;
	
	//로그인한 회원의 회원번호 불러오기
	function getSessionMemberNo() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionMemberNo = obj.member_no;
				addMemberIntoJoinMemberList(sessionMemberNo);
				getMyCurrentLevelValue(sessionMemberNo);
				getObtainValue(sessionMemberNo);
				getFishingGameLog();
				FreeCharging();
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/member/getSessionMemberNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	//---------------------------- 낚시터 입장 관련 - 형준 -------------------------------
	//낚시터 입장 시 참여자 현황에 회원 추가 - 형준
	function addMemberIntoJoinMemberList(member_no) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				getJoinMemberList();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/addMemberIntoFishingGame.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no);	
	}
	
	//낚시터 입장한 회원 불러오기 - 형준
	function getJoinMemberList() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var joinMemberCount = document.getElementById("joinMemberCount");
				joinMemberCount.innerText = obj.joinMemberCount;
				
				var joinMember_list = document.getElementById("joinMember_list");
				joinMember_list.innerText = "";
				
				for (var memberList of obj.joinMemberList) {
					//fishingGameJoinMemberVO
					var joinMemberLiBox = document.createElement("li");
					var joinMemberLeftDiv = document.createElement("div");
					var joinMemberRightDiv = document.createElement("div");
					joinMemberLiBox.setAttribute("class", "list-group-item border-0");
					joinMemberLeftDiv.setAttribute("class", "col");
					joinMemberRightDiv.setAttribute("class", "col");
					
					
					joinMemberLiBox.innerText = memberList.member_nick;
					
					joinMember_list.appendChild(joinMemberLiBox);
					
				}
				
				joinMember_list.parentElement.scrollTop = joinMember_list.parentElement.scrollHeight;
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/fishingGame/getFishingGameJoinMembers.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	}
	
	//------------------------------ 낚시터 입장 관련 끝 ---------------------------------
	
	//---------------------------- 채팅 관련 - 형준 -------------------------------
	//채팅 쓰기 - 형준
	function writeChattingProcess() {
		
		var chatting_form = document.getElementById("chatting_form");
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				chatting_form.value="";
				getChattingList();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/writeChattingProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + sessionMemberNo + "&chatting_content=" + chatting_form.value);	
	}
	
	//채팅 불러오기
	function getChattingList() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var chatting_area = document.getElementById("chatting_area");
				if (chattingNo <= 0) {
					chatting_area.innerText = "";
				}
				
				for (var chattingList of obj.chattingList) {
					var chattingLiBox = document.createElement("li");
					chattingLiBox.setAttribute("class", "list-group-item border-0 text-start");
					chattingLiBox.setAttribute("value", chattingList.fishingGameChattingVO.chatting_no);
					chattingLiBox.innerText = chattingList.member_nick + " : " + chattingList.fishingGameChattingVO.chatting_content;
					
					chatting_area.appendChild(chattingLiBox);
				}
				
				chattingNo = chatting_area.lastElementChild.value;
				chatting_area.parentElement.scrollTop = chatting_area.parentElement.scrollHeight; 
				
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getChattingList.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("chatting_no=" + chattingNo);	
	}

	
	//------------------------------ 채팅 관련 끝 --------------------------------
	
	//----------------------------- 낚시 뽑기 관련 시작 -------------------------------
	//접속한 경험치 현황 불러오기 
	function getMyCurrentLevelValue(member_no) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				//var myCurrentPoint = document.getElementById("myCurrentPoint");
				var totalScore = document.getElementById("totalScore");
				
				
				myCurrentPoint.innerText = obj.member_levelvalue;
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getMyCurrentLevelValue.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no);	
	}
	
	//낚시하기 클릭 시 경험치 차감
	function startFishing() {
      var myCurrentPoint = document.getElementById("myCurrentPoint");
      if(myCurrentPoint.innerText <300){
         alert("경험치가 부족합니다");
         return;
      }else{
	      //AJAX 호출.....
	      var xmlhttp = new XMLHttpRequest();
	      //호출 후 값을 받았을때... 처리 로직....
	      xmlhttp.onreadystatechange = function(){
	         if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	            //var obj = JSON.parse(xmlhttp.responseText);
	            
	            getMyCurrentLevelValue(sessionMemberNo);
	            getObtainValue(sessionMemberNo);
	            getFishName();
	         }
	      };
	      
	      xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/startFishing.do", true);
	      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	      xmlhttp.send("member_no=" + sessionMemberNo);   
      }
   }
	
	//낚인 물고기 이름 불러오기
	function getFishName() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				if (obj.fishName == '꽝') {
					writeFishLog(0, 0, 0);
				}
				else if (obj.fishName == '철갑상어' || obj.fishName == '우럭') {
					modal(obj.fishName);
					startFishNormalization(obj.fishName);
					}
				else {
					startFishNormalization(obj.fishName);
				}
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/fishingGame/getRandomFishName.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//물고기 정규화
	function startFishNormalization(fishName) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				writeFishLog(obj.totalScore, obj.fishLength, obj.FishNo);
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/fishNormalization.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("fish_name=" + fishName);
	}
	
	//--------------------------------------------------------------------------------------------
	
	//획득한 경험치&사용한 경험치 조회 - 형준
	function getObtainValue() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
			
				var totalScore = document.getElementById("totalScore");
				totalScore.innerText = obj.obtainValue;
				
				var useScore = document.getElementById("useScore");
				useScore.innerText = obj.useValue;
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getMyObtainValue.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + sessionMemberNo);
	}
	
	//충전횟수 확인
	function FreeCharging() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
			
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var chargingCount = document.getElementById("chargingCount");
				chargingCount.innerText = 3 - obj;
				
			}
		};
			
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getFreeCharging.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + sessionMemberNo);	
	}
	
	//포인트 충전
	function pointCharging() {
		var chargingCount = document.getElementById("chargingCount");
		
		if (chargingCount.innerText == '0') {
			alert("오늘 충전횟수를 초과하셨습니다.");
			return;
		}
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
			
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				getMyCurrentLevelValue(sessionMemberNo);
				FreeCharging();
			}
		};
			
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/valueCharging.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + sessionMemberNo);	
	}
	//-------------------------------------------------------------------------------------------
	
	
	//물고기 로그 삽입
	function writeFishLog(totalScore, fishLength, FishNo) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				getMyCurrentLevelValue(sessionMemberNo);
				drawChart();
				getFishingGameLog();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/writeFishLog.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("fish_no=" + FishNo + "&log_fishlength=" + fishLength + "&log_value=" + totalScore);
	}
	
	//낚시 게임 개인 로그 불러오기
	function getIndividualValueLog(member_no) {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var use_score_list = document.getElementById("use_score_list");
				if (fishLogNo <= 0) {
					use_score_list.innerText = "";
				}
				
				for(var logList of obj){
					var caculateScore = logList.fishingGameLogVO.log_value - 300;
					
					var countScoreSpan = document.createElement("span");
					var countScoreSmall = document.createElement("small");
					countScoreSmall.setAttribute("class", "d-block");
					if (caculateScore > 0) {
						countScoreSpan.setAttribute("class", "text-danger fs-6");
					} else if (caculateScore == 0){
						countScoreSpan.setAttribute("class", "text-dark fs-6");
					} else {
						countScoreSpan.setAttribute("class", "text-primary fs-6");
					}
					
					countScoreSpan.innerText = "(" + caculateScore.toFixed(2) +")";
					
					if(logList.fishingGameLogVO.log_value > 800){
						var useScoreLi = document.createElement("li");
						
                        useScoreLi.setAttribute("class", "list-group-item border-0 text-warning fw-bold text-start");
                        useScoreLi.innerText = 
                        (logList.fishingGameLogVO.log_fishlength).toFixed(1) + "cm " + logList.fish_name + "을(를) 잡아 " + 
                        (logList.fishingGameLogVO.log_value).toFixed(2) + "점을 획득하였습니다.";
                        
                        countScoreSmall.appendChild(countScoreSpan);
                        useScoreLi.appendChild(countScoreSmall);
                        use_score_list.appendChild(useScoreLi);
					} else {
						var useScoreLi = document.createElement("li");
						useScoreLi.setAttribute("class", "list-group-item border-0 text-start");
						useScoreLi.innerText = 
							(logList.fishingGameLogVO.log_fishlength).toFixed(1) + "cm " + logList.fish_name + "을(를) 잡아 " + 
							(logList.fishingGameLogVO.log_value).toFixed(2) + "점을 획득하였습니다.";
						
						countScoreSmall.appendChild(countScoreSpan);
                        useScoreLi.appendChild(countScoreSmall);
						use_score_list.appendChild(useScoreLi);
					}
				}
				use_score_list.parentElement.scrollTop = use_score_list.parentElement.scrollHeight;
				
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getFishingGameLog.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=" + member_no + "&log_no=" + fishLogNo);
	}
	
	//낚시 게임 로그 불러오기
	function getFishingGameLog() {
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var game_log_list = document.getElementById("game_log_list");
				if (fishLogNo <= 0) {
					game_log_list.innerText = "";
				}
				
				//전체 로그 불러오기
				for(var logList of obj){
					if (logList.fishingGameLogVO.fish_no != 0) {
						if(logList.fish_name =="철갑상어" || logList.fish_name =="우럭") {
							var gameLogLiBox = document.createElement("li");
							gameLogLiBox.setAttribute("class", "list-group-item border-0 text-danger fw-bold text-start text-truncate");
							gameLogLiBox.setAttribute("value", logList.fishingGameLogVO.log_no);
							gameLogLiBox.innerText = 
								logList.member_nick + "님이 " + 
								(logList.fishingGameLogVO.log_fishlength).toFixed(1) + "cm " + 
								logList.fish_name + "을(를) 잡았습니다.";
							
							game_log_list.appendChild(gameLogLiBox);
						} else {
							var gameLogLiBox = document.createElement("li");
							gameLogLiBox.setAttribute("class", "list-group-item border-0 text-start text-truncate");
							gameLogLiBox.setAttribute("value", logList.fishingGameLogVO.log_no);
							gameLogLiBox.innerText = 
								logList.member_nick + "님이 " + 
								(logList.fishingGameLogVO.log_fishlength).toFixed(1) + "cm " + 
								logList.fish_name + "을(를) 잡았습니다.";
							
							game_log_list.appendChild(gameLogLiBox);
						}
						
						//개인 경험치 사용 로그 찍기
						 if (logList.fishingGameLogVO.member_no == sessionMemberNo) {
							 getIndividualValueLog(sessionMemberNo);
						}
					} else {
						var gameLogLiBox = document.createElement("li");
						gameLogLiBox.setAttribute("class", "list-group-item border-0 text-start");
						gameLogLiBox.setAttribute("value", logList.fishingGameLogVO.log_no);
						gameLogLiBox.innerText = 
							logList.member_nick + "님이 물고기를 낚는데 실패하였습니다.";
						
						game_log_list.appendChild(gameLogLiBox);
					}
				}
				
				fishLogNo = game_log_list.lastElementChild.value;
				game_log_list.parentElement.scrollTop = game_log_list.parentElement.scrollHeight;
				
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getFishingGameLog.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("member_no=0&log_no=" + fishLogNo);
	}
	
	//----------------------------- 낚시 뽑기 관련 끝 -------------------------------
	
	//----------------------------- 구글 차트 이용 잡힌 어종 현황 - 형준 --------------------------------
	
	//어종별 잡힌 비율 불러오기 - 형준
	function getFishCatchRatio() {
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var catch_ratio_area = document.getElementById("catch_ratio_area");
				catch_ratio_area.innerText = "";
				
				
				obj.fishCatchRatio.forEach((ratioList, index) => {
					var ratioColBox = document.createElement("div");
					ratioColBox.setAttribute("class", "col-4 p-0 text-center");
					
					var ratioSmallBox = document.createElement("small");
					var ratioSpanBox = document.createElement("span");
					
					if (index == 0) {
						ratioSpanBox.setAttribute("class", "fw-bold");
					}
					
					ratioSpanBox.innerText = ratioList.FISH_NAME + "  " + ratioList.CATCH_COUNT + "마리\n(" + ratioList.CATCH_RATIO + "%)";
					
					ratioSmallBox.appendChild(ratioSpanBox);
					ratioColBox.appendChild(ratioSmallBox);
					catch_ratio_area.appendChild(ratioColBox);
				});
				
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getFishCatchRatio.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	//차트 그리기
	function drawChart() {
        
      //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var data = new google.visualization.DataTable();
				var arr = new Array();
				var currentDate = new Date();
				
				var colorArr = ['#00ff00', '#99cc00', '#ffffcc', '#0099cc', '#cc99ff', '#ff9999',
					'#ff0000', '#ccffcc', '#cc3399', '#6600ff', '#336600', '#ff9966', '#3366cc',
					'#663300', '#663300', '#663300', '#999966'];
				
				obj.fishCatchCount2.forEach((countList, index) =>{
					arr[index] = [countList.FISH_NAME, countList.CATCH_COUNT, colorArr[countList.FISH_NO]];
				});
				
				data.addColumn('string', 'Fish');
				data.addColumn('number', '잡힌 마리수');
				data.addColumn({role: 'style'});
				data.addRows(arr);

		        var options = {
		          title: '잡힌 어종 현황(' + currentDate.getFullYear() + "/" + 
		        		  (currentDate.getMonth()+1 > 9 ? currentDate.getMonth()+1 : "0" + (currentDate.getMonth()+1)) + "/" + 
		        		  (currentDate.getDate() > 9 ? currentDate.getDate() : "0" + currentDate.getDate()) + ")",
		           fontName: 'Cute Font',fontSize: 15

		        };
		        
				
		        //파이 차트
		        //var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
		        
		        //컬럼 차트(Bar 차트)
		        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
				//chart.draw(view, options);
		        
		        chart.draw(data, options);
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getFishCatchCount.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
      }
	//top5 표시
	function getTop_List(){
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				var count = 1;
				var top_List = document.getElementById("top_List");
				top_List.innerText = "";
				for(var logList of obj){
					var topLogLiBox = document.createElement("li");
					topLogLiBox.setAttribute("class", "list-group-item border-0 text-start");
					topLogLiBox.innerText = count+"등 "+logList.memberVO.member_nick + "\n" + 
					logList.fishingGameTopLogVO.log_value + "점 ";
					count++;
					top_List.appendChild(topLogLiBox);
				}
		
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/fishingGame/getTopValue.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
		
	//모달 창
	function modal(name){
		var xmlhttp = new XMLHttpRequest();
		modalfish = new bootstrap.Modal(document.getElementById("modalfish"));
		var modalfishname = document.getElementById("modalfishname");
		modalfish.show();
		modalfishname.innerText = name+"를 낚았습니다";
	}
	
	
	//------------------------------ 구글 차트 이용 잡힌 어종 현황 끝 -----------------------------------
	
	//body onload시 기본 실행되는 스크립트
	function init() {
		getSessionMemberNo();
		getJoinMemberList();
		getChattingList();
		getTop_List();
		getFishCatchRatio();
		setInterval(getTop_List, 1000);
		setInterval(getJoinMemberList, 1000);
		setInterval(getChattingList, 1000);
		setInterval(getFishingGameLog, 1000);
		setInterval(getFishCatchRatio, 5000);
	}
</script>
<style type="text/css">
	#background_col div {
		background-color: white;
	}
</style>
</head>
<body onload="init()">
	<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	</div>
	
<div style="width: 100%; margin: 0 auto; background-color: #C0FFFF; background-image: url('/fishingmate/resources/img/fishinggame_background.jpg');">
	<div style="width: 1200px; margin: 0 auto;">
		<div class="container-fluid" id="main_content">
			<div class="row m-0">
				<div class="col" id="background_col">
					<div class="row mt-5 rounded">
						<div class="col text-center py-3" style="background-color: #FFC6C3;">
							<span id="fishinggame_title" class="fw-bold">
								낚시터
							</span>
						</div>
					</div>
					<div class="row mt-3 mb-2 rounded" style="background-color: rgba(0, 0, 0, 0);">
						<div class="col border border-1 p-0">
							<div class="fw-bold fs-4 text-center border border-1 mx-0 mt-0 py-1" style="background-color: #FFC6C3;">
								<span class="fw-bold">어종 현황</span>
							</div>
							<div class="row m-0 mt-2">
								<div class="col me-1">
									<div id="columnchart_values" style="height: 300px;"></div>
										<div class="row mb-2" id="catch_ratio_area">
									</div>
								</div>
							</div>
						</div>
						<div class="col border border-1 p-0 ms-1">
							<div class="row fw-bold fs-4 text-center border border-1 mx-0 mt-0 py-1" style="background-color: #FFC6C3;">
								<div class="col me-1" style="background-color: #FFC6C3;">
									<span class="fw-bold">TOP</span>
								</div>
								<div class="col" style="background-color: #FFC6C3;">
									<span class="fw-bold">접속 현황</span>
								</div>
							</div>
							<div class="row m-0 mt-2">
								<div class="col border border-1 mb-2 ms-2 me-1 p-0 text-truncate">
									<div class="d-block mb-1" style="overflow-x: hidden; height: 354px;">
										<ul id="top_List" class="list-group"></ul>
									</div>
								</div>
								<div class="col mb-2 ms-1 me-2 p-0 border border-1">
									<div class="d-block mb-1 border-bottom border-1" style="overflow-x: hidden; height: 311px;">
										<ul id="joinMember_list" class="list-group"></ul>
									</div> 
									<div class="row px-1 mx-1">
										<div class="col-2 me-2 p-0 text-center mt-2">
											<i class="bi bi-people"></i>
											<span id="joinMemberCount"></span>
										</div>
										<div class="col d-grid me-0 p-0 ps-3">
											<a class="btn btn-outline-danger" href="${pageContext.request.contextPath }/fishingGame/deleteMemberProcess.do">나가기</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-4 rounded" style="background-color: rgba(0, 0, 0, 0);">
						<div class="col border border-1 p-0 me-1">
							<div class="row m-0">
								<div class="fw-bold fs-4 text-center border border-1 mx-0 mt-0 py-1" style="background-color: #FFC6C3;">
									<span class="fw-bold">낚시터 현황</span>
								</div>
								<div id="game_log_list_div" class="col-12 border border-1 overflow-auto" style="height:400px;">
									<ul id="game_log_list" class="list-group"></ul>
								</div>
								<div class="col p-0 mx-1 mt-1 d-grid">
									<button class="btn btn-primary fs-5" onclick="pointCharging()">
										포인트 충전(<span id="chargingCount"></span>)
									</button>
								</div>
								<div class="col p-0 mx-1 mt-1 d-grid">
									<button class="btn btn-primary fs-5" onclick="startFishing()">낚시하기<small>(-300)</small></button>
								</div>
							</div>
							<div class="row m-auto mt-2">
								<div class="border-top border-bottom border-1" style="overflow-x:hidden; height:250px;">
									<ul id="use_score_list" class="list-group"></ul>
								</div>
							</div>
							<div class="row border border-1 m-1 mt-2">
								<div class="col text-center p-1 border-end border-1">
									총 경험치
								</div>
								<div class="col text-center p-1">
									<span id="myCurrentPoint"></span>
								</div>
							</div>
							<div class="row border border-1 m-1 mt-2">
								<div class="col text-center p-1 border-end border-1">
									얻은 경험치
								</div>
								<div class="col text-center p-1">
									<span id="totalScore"></span>
								</div>
							</div>
							<div class="row border border-1 m-1 mt-2">
								<div class="col text-center p-1 border-end border-1">
									사용한 경험치
								</div>
								<div class="col text-center p-1">
									<span id="useScore"></span>
								</div>
							</div>
						</div>
						<div class="col border border-1 p-0">
							<div class="d-flex flex-column m-0">
								<div class="fw-bold fs-4 text-center border border-1 mx-0 mt-0 py-1" style="background-color: #FFC6C3;">
									<span class="my-1">채팅</span>
								</div>
								<div style="height: 798px; overflow-x:hidden;" class="border-bottom border-1 mb-1">
									<ul id="chatting_area" class="list-group"></ul>
								</div>
								<div class="row mt-1 mb-2 mx-1 px-1">
									<div class="col m-0 ps-0 d-grid">
										<input id="chatting_form" class="form-control" type="text" onkeyup="if(window.event.keyCode==13){writeChattingProcess()}" placeholder="채팅을 입력하세요" aria-label="default input example">
									</div>
									<div class="col-2 d-grid m-0 p-0">
										<button class="btn btn-primary fs-5" onclick="writeChattingProcess()">전송</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 모달창 -->
	<div class="modal" id="modalfish" tabindex="-1">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
      			  	<h5 class="modal-title">낚시터</h5>
      			  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
     			 </div>
     			 <div class="modal-body">
       				 <p id="modalfishname"></p>
      			</div>
     			 <div class="modal-footer">
      				  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
     			 </div>
    		</div>
  		</div>
	</div>
	
	<!-- 리모컨 -->
<!-- 	<div id="quick_menu" class="list-group"> -->
<%-- 		<a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/fishingGame/fishingGame.do"> --%>
<%-- 		<img class="img-concert" src="${pageContext.request.contextPath }/resources/img/fish_3.png"/>&nbsp;낚시터</a> --%>
<%-- 		<a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/fishingshare/fishingshare.do"> --%>
<%-- 		<img class="img-concert" src="${pageContext.request.contextPath }/resources/img/trend.png"/>&nbsp;주식시장</a> --%>
<%-- 		<a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/dice/dicePage.do"> --%>
<%-- 		<img class="img-concert" src="${pageContext.request.contextPath }/resources/img/dice.png"/>&nbsp;DICE</a> --%>
<%-- 		<a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/infofreeboard/lotto45.do"> --%>
<%-- 		<img class="img-concert" src="${pageContext.request.contextPath }/resources/img/lottery.png"/>&nbsp;lotto45</a> --%>
<%-- 		<a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/infofreeboard/battinglotto45.do"> --%>
<%-- 		<img class="img-concert" src="${pageContext.request.contextPath }/resources/img/lottery.png"/>&nbsp;battinglotto45</a> --%>
<!-- 	</div> -->
	<jsp:include page="/WEB-INF/views/commons/gameRemote.jsp" />
	
	<!-- 푸터 --> 
	<jsp:include page="/WEB-INF/views/commons/footer.jsp" />
	<!-- 푸터 끝 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
</body>
</html>