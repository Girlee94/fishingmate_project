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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mateReadContentPage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/fishingShare.css">
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load("current", {packages:["line"]});
google.charts.setOnLoadCallback(drawChart);
var sessionMemberNo = null;
var aaa = 0;
var bbb = 1;
var ccc= 3;
var isGetAll = true;
var arrTest = [];
var i = 0;
var fishLogNo = 0;
var data = null;

//로그인한 회원의 회원번호 불러오기 - 명화
function getSessionMemberNo() {
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         
         sessionMemberNo = obj.member_no;
         getlevelvaule(sessionMemberNo);
         selectFish(sessionMemberNo);
         /* saleCheck(sessionMemberNo); */
      }
   };
   
   xmlhttp.open("get","${pageContext.request.contextPath}/member/getSessionMemberNo.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

var test = 1;

//차트 그리기 - 명화
function drawChart() {
   
  //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var bbb = "가나다";
         
         
         /* if(data == null){
            data = new google.visualization.DataTable();
            data.addColumn('number', 'Day');
            for(var fishName of obj.bbb[0]){
               data.addColumn('number', fishName.fish_name);
            }
         } */
         
         
          if(data == null){
            //data = new google.visualization.DataTable();
            
            arrTest.push(['time' , '붕어','잉어','메기','가물치','배스','동자개','쏘가리','피라미','철갑상어','송어','돔','우럭','고등어','농어','볼락','숭어','꽁치']);
            
            for(x of obj.bbb){
               arrTest.push(x);   
            }
            
            data = google.visualization.arrayToDataTable(arrTest);
            isGetAll = false;
            
         }else{
            data.addRow(obj.bbb[0]);
         } 
         
         var currentDate = new Date();
      
         
           var options = {
             title: '',
           };

           var chart = new google.charts.Line(document.getElementById('donutchart'));
           
           chart.draw(data, google.charts.Line.convertOptions(options));
           
           
      }
      
      i++;
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/getShareCatchRatio.do", true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("aaaa=" + i + "&isGetAll=" + isGetAll);
  }
 // 물고기 종류 불러오기 - 명화
function fishselects(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var fishselect = document.getElementById("fishselect");
         for (var fishList of obj){
            var fishoption = document.createElement("option");
            fishoption.setAttribute("value",fishList.fish_no);
            fishoption.innerText = fishList.fish_name;
            fishselect.appendChild(fishoption);
         }
      }
   };
   
   xmlhttp.open("get","${pageContext.request.contextPath}/fishingShare/FishCategoryList.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}
 //물고기 구매하기 수량 체크 - 명화
function buyCheck(){
      var fishcount = document.getElementById("fishcount");
      var buyPrice = document.getElementById("buyPrice");
      var mylevel = document.getElementById("mylevel");
      if(fishcount.value==0){
         alert("수량을 확인해주세요");
         fishcount.value="";
         return;
      }
      if(Number(buyPrice.value)>Number(mylevel.innerHTML)){
         alert("경험치가 부족합니다");   
         fishcount.value="";
         return;
         }
      buy();
      }
 //물고기 구매하기 - 명화
function buy(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         //var obj = JSON.parse(xmlhttp.responseText);
         var fishcount = document.getElementById("fishcount");
         var fishselect = document.getElementById("fishselect");
         var buyPrice = document.getElementById("buyPrice");
            fishcount.value="";
            getlevelvaule();
            selectFish();
            shareLogList();
         }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/insertByeFishShare.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + sessionMemberNo + "&fish_no="+fishselect.options[fishselect.selectedIndex].value
               +"&fishshare_storage_quantity="+fishcount.value+"&fishshare_storage_value="+buyPrice.value);
}//물고기 판매하기 - 명화
function sale(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         //var obj = JSON.parse(xmlhttp.responseText);
         var fishcount = document.getElementById("fishcount");
         var fishselect = document.getElementById("fishselect");
         var buyPrice = document.getElementById("buyPrice");
         
         fishcount.value="";
         getlevelvaule();
         selectFish();
         shareLogList();
         }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/saleFishShare.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + sessionMemberNo + "&fish_no="+fishselect.options[fishselect.selectedIndex].value
               +"&fishshare_storage_quantity="+fishcount.value+"&fishshare_storage_value="+buyPrice.value);
} //물고기 가격 불러오기 - 명화
function getFishprices(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var buyPrice = document.getElementById("buyPrice");
         var fishselect = document.getElementById("fishselect");
         var fishcount = document.getElementById("fishcount");

         bbb =  fishcount.value;
         buyPrice.value=obj*bbb;
         
         }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/getFishprice.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("fish_no=" + fishselect.options[fishselect.selectedIndex].value);
}// 경험치 보유 현황 - 명화
function getlevelvaule(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var mylevel = document.getElementById("mylevel");

         mylevel.innerText=obj.member_levelvalue;
         
         }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/getMyLevelValue.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + sessionMemberNo);
}// 물고기 보유 현황 - 명화
function selectFish(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var sharelist = document.getElementById("sharelist");
         var contentaa = "\u00A0";
         
         sharelist.innerText = "";
         
         for(var fishList of obj){
            var fishLi = document.createElement("li");
            fishLi.setAttribute("class", "list-group-item border-0 text-center");
            fishLi.innerText = fishList.Fishname+""+contentaa+""+contentaa+""+contentaa+""+fishList.fishShareCountVO.fishshare_storage_quantity+""+contentaa+""+"마리";
            sharelist.appendChild(fishLi);
         }
         
         }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/selectFishShare.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + sessionMemberNo);
}//물고기 보유 확인 - 명화
function saleCheck(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var fishselect = document.getElementById("fishselect");
         var fishcount = document.getElementById("fishcount");
         
            if(fishcount.value==0){
               alert("수량을 확인해주세요");
            }else if(obj>fishcount.value){
               sale();
            }else if(obj==fishcount.value){
               deletesale(); 
            }else if(obj==0){
               alert("물고기가 부족합니다");
            }
            else{
               alert("물고기가 부족합니다");
            }
         }
         
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/checkFish.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + sessionMemberNo + "&fish_no="+fishselect.options[fishselect.selectedIndex].value);

}
//물고기 판매하기 - 명화
function deletesale(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         //var obj = JSON.parse(xmlhttp.responseText);
         var fishcount = document.getElementById("fishcount");
         var fishselect = document.getElementById("fishselect");
         var buyPrice = document.getElementById("buyPrice");
         
         fishcount.value="";
         getlevelvaule();
         selectFish();
         shareLogList();
         }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/deleteSale.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=" + sessionMemberNo + "&fish_no="+fishselect.options[fishselect.selectedIndex].value
               +"&fishshare_storage_quantity="+fishcount.value+"&fishshare_storage_value="+buyPrice.value);
}
//주식 로그 - 명화
function shareLogList(){
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         var contentaa = "\u00A0";
         var log_list = document.getElementById("log_list");
         if(fishLogNo <= 0){
            log_list.innerText = "";
         }
         for(var shareLogList of obj){
            var shareLogBox = document.createElement("li");
            shareLogBox.setAttribute("class", "list-group-item border-0 text-start");
            shareLogBox.setAttribute("value", shareLogList.fishingGameLogVO.log_no);
            if(shareLogList.fishingGameLogVO.fishshare_category_no==1){
               shareLogBox.setAttribute("style","color : red;");
               shareLogBox.innerText=
               shareLogList.member_nick + "님이"+contentaa+""+ shareLogList.fish_name +"를 "+contentaa+""+shareLogList.fishingGameLogVO.fishshare_quantity+"마리 구매하셨습니다";
               }
            else{
               shareLogBox.setAttribute("style","color : blue;");
               shareLogBox.innerText=
               shareLogList.member_nick + "님이" +contentaa+""+ shareLogList.fish_name +"를 "+contentaa+""+ shareLogList.fishingGameLogVO.fishshare_quantity+"마리 판매하셨습니다";
               }
               
            log_list.appendChild(shareLogBox);
            log_list.parentElement.scrollTop = log_list.parentElement.scrollHeight;
         }
      }
};
   
   xmlhttp.open("post","${pageContext.request.contextPath}/fishingShare/getFishShareLogList.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send("member_no=0&log_no=" + fishLogNo);
}
function init() {
   getSessionMemberNo();
   fishselects();
   shareLogList();
   setInterval(getFishprices, 1000);
   setInterval(shareLogList, 3000);
   setInterval(drawChart, 10000);
}

</script>
<style type="text/css">
::-webkit-scrollbar{width: 16px;}
::-webkit-scrollbar-track {background-color:#f1f1f1;}
::-webkit-scrollbar-thumb {background-color:#A7C5EB;border-radius: 10px;}
::-webkit-scrollbar-thumb:hover {background: #A7C5EB;}
::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
width:16px;height:16px;background:#A7C5EB;}
.img-concert {
        width: 30px;
        height: 30px;
      }
</style>
</head>
<body onload="init()">

<div style="width: 1200px; margin: 0 auto;">
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/commons/header.jsp" />
<!-- 헤더 끝 -->
   <div class="container-fluid">
      <div class="row">
         <div class="col">
            <div class="row">
            <img src="/fishingmate/resources/img/logo_mh2.png" width="50" height="220">
            </div>
            <div class="row mt-3 mb-1">
               <div class="col-7 border border-1 ms-1">
                  <div class="row">
                     <strong class="badge bg-warning text-dark fs-5"><img class="img-concert" src="${pageContext.request.contextPath }/resources/img/trend_mh.png"/>&nbsp;주식차트</strong>
                  </div>
                  <div class="row p-3">
                     <div class="col">
                        <div id="donutchart" style="height: 340px;"></div>
                     </div>
                  </div>
               </div>
               <div class="col border border-1 ms-1">
                  <div class="row">
                     <span class="badge bg-warning text-dark fs-5"><img class="img-concert" src="${pageContext.request.contextPath }/resources/img/bag_mh.png"/>주식보유현황</span>
                  </div>
                  <div class="row p-3">
                     <div class="col border border-1 overflow-auto" style="height:270px;">
                        <ul id="sharelist" class="list-group" style="background-color:#A7C5EB;"></ul>
                     </div>
                  </div>
                  <div class="row mt-4">
                     <div class="col-6 border-top border-1" style="text-align:center;">
                        <span>현재 경험치<br></span>
                        &nbsp;<span id="mylevel"></span><img src="${pageContext.request.contextPath }/resources/img/dollar_mh.png" width="20" height="20"/>
                     </div>
                     <div class="col-6 border-top border-1" style="text-align:center;">
                        <span >전체 경험치<br></span>
                        <span>&nbsp;35354<img src="${pageContext.request.contextPath }/resources/img/dollar_mh.png" width="20" height="20"/></span>
                     </div>
                  </div>
               </div>
            </div>
            <div class="row mb-2">
               <div class="col-7 border border-1 ms-1">
                  <div class="row">
                  <span class="badge bg-warning text-dark fs-5"><img class="img-concert" src="${pageContext.request.contextPath }/resources/img/report_mh.png"/>주식거래현황</span>
                  </div>
                  <div class="row p-3">
                     <div id="log_list_div" class="col border border-1 overflow-auto" style="height:180px;">
                        <ul id="log_list" class="list-group"></ul>
                     </div>
                  </div>
               </div>
               <div class="col wrap border border-1 ms-1">
                  <div class="row">
                     <span class="badge bg-warning text-dark fs-5"><img class="img-concert " src="${pageContext.request.contextPath }/resources/img/trade-mh.png"/>주식거래소</span>
                  </div>
                  <div class="row">
                     <div class="col mt-5">
                        <div class="row">
                           <div class="col-1">
                           </div>
                           <div class="col-4">
                              <select id="fishselect" class="form-select" aria-label="Default select example" style="width:110px;"></select>
                           </div>
                           <div class="col-2">
                              <input type="text" class="form-control" style="width:60px;" placeholder="수량" id=fishcount>
                           </div>
                           <div class="col-3">
                              <input type="text" style="background-color:white;" class="form-control" id="buyPrice" readonly>
                           </div>
                           <div class="col">
                           </div>
                        </div>
                        <div class="row mt-4 border-top border-1">
                           <div class="col-6">
                           </div>
                           <div class="col-5 mt-4">
                              <button type="button" class="border-0" style="background : none;" onclick="buyCheck()">
                              <img src="/fishingmate/resources/img/buy_mh.png" width="50" height="50">
                              </button>
                              <button type="button" class="border-0" style="background : none;" onclick="saleCheck()">
                              <img src="/fishingmate/resources/img/sale_mh2.png" width="50" height="50">
                              </button>
                           </div>
                           <div class="col"></div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            </div>
         </div>
      </div>
   </div>
   
   <!-- 퀵메뉴 시작 -->
<!--    <div id="quick_menu" class="list-group"> -->
<%--         <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/fishingGame/fishingGame.do"> --%>
<%--         <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/fish_3.png"/>&nbsp;낚시터</a> --%>
<%--        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/fishingshare/fishingshare.do"> --%>
<%--        <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/trend.png"/>&nbsp;주식시장</a> --%>
<%--         <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/dice/dicePage.do"> --%>
<%--         <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/dice.png"/>&nbsp;DICE</a> --%>
<%--         <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath }/infofreeboard/lotto45.do"> --%>
<%--         <img class="img-concert" src="${pageContext.request.contextPath }/resources/img/lottery.png"/>&nbsp;lotto45</a> --%>
<!--    </div> -->

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