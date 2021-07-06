<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
   crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath }/resources/css/header.css">
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/lotto.css">
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
   href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
   rel="stylesheet">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/select.css">
   <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
var sessionMemberNo = null;

//로그인한 회원의 회원번호 불러오기
function getSessionMemberNo() {
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         
         sessionMemberNo = obj.member_no;
         getSessionMemberinfo();
      }
   };
   
   xmlhttp.open("get","${pageContext.request.contextPath}/member/getSessionMemberNo.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

//로그인한 회원의 닉네임,경험치  불러오기
function getSessionMemberinfo() {
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         var obj = JSON.parse(xmlhttp.responseText);
         
      
         var lottoinfoline =   document.getElementsByClassName("lottoinfoline");
         lottoinfoline[0].innerText="";
         lottoinfoline[0].innerText  = "|닉네임|"+" "+obj.member_nick+" "+"|경험치|"+" "+obj.member_levelvalue;
         
         var lottonick = document.getElementById("lottonick");
         lottonick.innerText="";
         lottonick.innerText=obj.member_nick;
         
         var lottoscore = document.getElementById("lottoscore");
         lottoscore.innerText="";
         lottoscore.innerText=obj.member_levelvalue;
         
      }
   };
   
   xmlhttp.open("post","${pageContext.request.contextPath}/infofreeboard/getlottomemberinfo.do" , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}




   function aaa() {
      var number = document.getElementsByClassName("lottocircle");
      for (var i = 0 ; i < number.length ; i++){
         if(parseInt(number[i].textContent)>=40){
            number[i].style="background-color:#FF0000";   
      }else if(parseInt(number[i].textContent)>=30){
         number[i].style="background-color:#3300CC";
      }else if(parseInt(number[i].textContent)>=20){
         number[i].style="background-color:#D2691E";
      }else if(parseInt(number[i].textContent)>=10){
         number[i].style="background-color:#00CC33";
      }   
      else{
         number[i].style="background-color:#990066";   
      }
   }
   }
   //----------------------------------------------------------------------
      
      $(document).ready(function(){
       $('#option5').click(function(){
          $("#app-cover").hide();
          adddiv(5);
       });
      
       $('#option10').click(function(){
          $("#app-cover").hide();
          adddiv(10);
       });
       
       $('#option15').click(function(){
          $("#app-cover").hide();
          adddiv(15);
       });
       
       $('#option20').click(function(){
          $("#app-cover").hide();
          adddiv(20);
       });
       
       });
   
      
      
   async function adddiv(j){
      for(i=0; i<j; i++){
         await milli();
         lottoarray = randomlottoNumber();
         $('#div').append($('<div class="numberdiv"><div class="top-div"><div class="top-div-name>">'+(i+1)+'번째 자동번호</div></div><div class="numberset"><div class="lottocircle"><p class="value">'
               +lottoarray[1]+'</p></div><div class="lottocircle"><p class="value">'+lottoarray[2]+'</p></div><div class="lottocircle"><p class="value">'
               +lottoarray[3]+'</p></div><div class="lottocircle"><p class="value">'+lottoarray[4]+'</p></div><div class="lottocircle"><p class="value">'
               +lottoarray[5]+'</p></div></div></div>'));
         drawcolor();
         
      }
   }
   
   function milli(){
      return new Promise(resolve => {
         setTimeout(() => {
            resolve('resolved');
         },500);
      });
   }
   
   
      function randomlottoNumber(){
         var lotto=[];
         var cnt=0;
         var flag="true";
         while(cnt<6){
            var number=0;
            number =parseInt(Math.random() * 45)+1;
            for(var i=0; i<cnt; i++){
               if(lotto[i]==number){
                  flag=false;
               }
            }
            if(flag==true){
               lotto[cnt] = number;
               cnt++;
            }
            flag=true;
         }
         sort_lotto = lotto.sort(function(a,b){return a-b;});
         return sort_lotto;
      }
      //----------------------------------------------------------------------
      
      
      /* 내가 고른 로또 색상 고르기 */
      function drawmycolor(){
         var number = document.getElementsByClassName("mylottocircle");
         for (var i = 0 ; i < number.length ; i++){
            if(parseInt(number[i].textContent)>=40){
               number[i].style="background-color:#FF0000";   
         }else if(parseInt(number[i].textContent)>=30){
            number[i].style="background-color:#3300CC";
         }else if(parseInt(number[i].textContent)>=20){
            number[i].style="background-color:#D2691E";
         }else if(parseInt(number[i].textContent)>=10){
            number[i].style="background-color:#00CC33";
         }   
         else{
            number[i].style="background-color:#990066";   
         }
      }
      }
      

      function doLotto(){
         
         if(sessionMemberNo == null){
            alert("로그인을 하셔야 생각을 적을수 있습니다");
         return;
         }
          
         
         var selectedNumberCheckBoxes = document.querySelectorAll(".lottoselect input[type=checkbox]:checked");
         
         if(selectedNumberCheckBoxes.length >= 7){
            alert("숫자는 6개까지만 입니다...");
            return;
         }
         
         if(selectedNumberCheckBoxes.length < 6){
            alert("숫자6개를 선택해주세요.");
            return;
         }
         
                  
         var xmlhttp =new XMLHttpRequest();
         
         xmlhttp.onreadystatechange = function(){
            if(xmlhttp.readyState==4 && xmlhttp.status == 200){
               var obj = JSON.parse(xmlhttp.responseText);
               
               
               var numberset = document.getElementsByClassName("numberset");
               
               numberset[0].innerHTML = "";
               
               for(num of obj.confirmedNumber){
                  //<div class="lottocircle"><p class="value">5</div>
                  var selectnumber= document.createElement("div");
                  selectnumber.setAttribute("class","lottocircle");
   
                  var p = document.createElement("p");
                  p.setAttribute("class","value");
                  p.innerText = num;   
                  
         
                  selectnumber.appendChild(p);
                  
                  numberset[0].appendChild(selectnumber);
               }
               
               
         
               
               var lottoalertline = document.getElementsByClassName("lottoalertline");
               lottoalertline[0].innerText=obj.count+"개 맞췄습니다!"+obj.freelottocount+"번";
            
               
                  
                  
               }
               aaa();
               drawmycolor();
               getSessionMemberinfo();
               checkfreelotto();
               
               
               
            };
         
         
            xmlhttp.open("post","${pageContext.request.contextPath}/infofreeboard/doLotto.do" , true);
            xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            
         
            var param = "";
            for(selectedNumberCheckBox of selectedNumberCheckBoxes){
               param += "&selectedNumber=" + selectedNumberCheckBox.value; 
            }
            
            xmlhttp.send(param);   
         }
         
      
   /*    function checkLottoNo(){
         
          var query = '.lottoselect input[type=checkbox]:checked';
           var selectedEls = 
               document.querySelectorAll(query);
           
           var result = '';
           selectedEls.foreach((e1) = {
              
              result += e1.value+'';
              
           });
           
           document.getElementById('result').innerText
             = result;
         
         
         
      } */
      
       function checkLottoNo(e){
         
         var show = '.lottoselect input[type=checkbox]:checked';
         var selectshow =document.querySelectorAll(show);

         if(selectshow.length > 6){
            alert("6개 까지만 선택 가능합니다.");
            
            e.checked = false;
            
            return;
         }
         
         
         var valueElements = document.querySelectorAll(".mynumberdiv .value");

         
         valueElements[0].innerText = '나';
         valueElements[1].innerText = '로';
         valueElements[2].innerText = '또';
         valueElements[3].innerText = '번';
         valueElements[4].innerText = '호';
         valueElements[5].innerText = '는';
         valueElements[6].innerText = '?';
                  

         for(var i = 0 ; i < selectshow.length ; i++){
            
            valueElements[i].innerText = selectshow[i].value;
            drawmycolor();
            
         }

      }
      function checkfreelotto(){
         
         
         //AJAX 호출.....
         var xmlhttp = new XMLHttpRequest();
         
         //호출 후 값을 받았을때... 처리 로직....
         xmlhttp.onreadystatechange = function(){
            if(xmlhttp.readyState==4 && xmlhttp.status == 200){
                var obj = JSON.parse(xmlhttp.responseText);
            
               
               var lottoalertline = document.getElementsByClassName("lottoalertline");
               var lottobutton = document.getElementById("lottobutton");
               if(obj.lottocheckcount >= 5){
                  alert("하루에 할수있는 무료 로또는 5번 입니다!");
                  
                  lottoalertline[0].innerText= "오늘 5번을 다하셨습니다!";
                  lottobutton = document.getElementById("lottobutton");
                  lottobutton.disabled='disabled';
                  lottobutton.innterText = "오늘 이용회수 초과";
                  
               
            
               }
            };
         }
         
         xmlhttp.open("post","${pageContext.request.contextPath}/infofreeboard/lottocheckcount.do", true);
         xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
         xmlhttp.send();      
      }
      
      
      function init(){
         getSessionMemberNo();
         aaa();
         drawmycolor();
         getSessionMemberinfo();
         checkfreelotto();
      }
            
</script>


<style>
.main{
   height : auto;
}

.numberdiv{
width : 60%;
margin-top :20px;
margin-left: auto;
margin-right: auto;
position : relative;
display : flex;
flex-direction: column;
min-width:0;
border : 1px solid rgba(170,50,220,.6);
border-radius: .25rem;
background-color: black;
}

.mynumberdiv{
width : 60%;
margin-top :20px;
margin-left: auto;
margin-right: auto;
position : relative;
display : flex;
flex-direction: column;
min-width:0;
border : 1px solid rgb(255 ,180 ,0);
border-radius: .25rem;
background-color: black;
}



.top-div{
   border-radius : calc(.25rem - 1px) calc(.25rem - 1px) 0 0;
   box-sizing: border-box;
   line-height: 30px;
   background-color: #9966FF;
   color :white;
}
.mytop-div{
   border-radius : calc(.25rem - 1px) calc(.25rem - 1px) 0 0;
   box-sizing: border-box;
   line-height: 30px;
   background-color: #FFB400;
   color :white;
}


.top-div-name{
   font-weight : bold;
   font-size: 15px;
   text-align: center;
   
}

.mytop-div-name{
   font-weight : bold;
   font-size: 15px;
   text-align: center;
   
}
.numberset{
   width:400px;
   margin-left: auto;
   margin-right: auto;
   display: flex;
   background-color : black;
}

.mynumberset{
   width:400px;
   margin-left: auto;
   margin-right: auto;
   display: flex;
   
   
}
.lottocircle{
   display:table;
   border-radius: 50%;
   width:32px;
   height:32px;
   border: none;
   text-align : center;
   font-weight : bold;
   font-size : 15px;
   margin-top: 10px;
   margin-bottom: 10px;
   margin-left: 15px;
   margin-right : 15px; 
   color: white;
   
}

.mylottocircle{
   display:table;
   border-radius: 50%;
   width:32px;
   height:32px;
   border: none;
   text-align : center;
   font-weight : bold;
   font-size : 15px;
   margin-top: 10px;
   margin-bottom: 10px;
   margin-left: 15px;
   margin-right : 15px; 
   color: white;
}

.value{
   display : table-cell;
   vertical-align : middle;
}

.lottoselect{
   text-align: center;
   font-weight : bold;
   color : white;
   margin-top: 10px;
   margin-bottom: 10px;
   margin-left: 15px;
   margin-right : 15px;
} 

.lottoinfo{
   height:32px;
   color : red;
   
}
.lottoinfoline{
   text-align: center;
   font-weight : bold;
   border : 3px solid rgb(220 ,53 ,69);
   border-radius: .25rem;
}
.lottoalert{
   height : 25px;
}
.lottoalertline{
   text-align: center;
   font-weight : bold;
   color : red;
}

.img-concert {
        width: 30px;
        height: 30px;
      }

#quick_menu {
    position: fixed;
    top: 330px;
    left: 50px;
    width: 200px;
    /* height: 550px; */
    cursor: pointer;
    /* z-index: 30;
    border: 1px solid #dbdbdb;
    border-bottom: 0;
    border-right: 0; */
}






/* .lottoselect input[type=checkbox]{
display: none;

}
 */
/* ------------------------------------------------------------------------로또번호 이미지*/
/* input[type=checkbox] {
    display:none;
}
input[type=checkbox] + label { 
    cursor: pointer; 
    padding-left: 23px; 
    background-repeat: no-repeat;
    background-image: url('./src/resources/img/lotto2.png');
}/* 
input[type=checkbox]:checked + label {
    background-image: url('./img/checker-on.svg');
}
input[type=checkbox]:disabled + label {
    background-image: url('./img/checker-disabled.svg');
} */

 */
</style>
   
   
</head>
<body onload="init()">
   
   <div style="width: 1200px; margin: 0 auto;">
      <!-- 헤더 -->
      <jsp:include page="/WEB-INF/views/commons/header.jsp" />
      <!-- 헤더 끝 -->
   </div>
<div style= "width: 100%; margin :0 auto;  background-color : black;">
   <div style="background-color : black; width: 1200px; height:1448px; margin: 0 auto;">
      
   <div class="container-fluid mb-5" style="background-image: url('/fishingmate/resources/img/lottogalaxy.jpg')">
<div style="position:absoulte;width:100%;height:100%;">
<img style="position:absoulte;width:100%;height:100%; padding-top: 5px;"  id="lottologo" src="${pageContext.request.contextPath }/resources/img/lottologo.png">

</div>


   <div class="row">
      <div class="col text-center" style="color:white";>
               FREE ROUND
      </div>
   </div>
   <div class="main" >
      <div class="numberdiv">
         <div class="top-div">
         <div class="top-div-name">추첨번호!</div>
         </div>
      

   <div class="numberset">
      <div class="lottocircle"><p class="value"> <img alt="" src="${pageContext.request.contextPath }/resources/img/spaceship.png"> </div>
      <div class="lottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottoalien.png"></div>
      <div class="lottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottospaceship2.png"></div>
      <div class="lottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/spaceship.png"></div>
      <div class="lottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottospaceship2.png"></div>
      <div class="lottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottoalien.png"></div>
      <div class="lottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottospaceship2.png"></div>
      </div>
   </div>
   
   </div>
   
<div class="row">
<div class="col"></div>
<div class="col-8">
   <div class="lottoselect text-center">
   <table class="checkbox m-0 mx-auto"  style="${pageContext.request.contextPath }/resourse/img/lotto2.png">
   <c:forEach begin="0" end="8" var="i">
      <tr>
         <c:forEach begin="${i *5 +1 }" end="${(i *5 +1)+4}" var="j">
         
      <td width="70" height="60">
         <%--<input type="checkbox" onclick="checkLottoNo(this)" value="${j}">${j}--%>
         <input type="checkbox" class="btn-check" name="options-outlined" id="danger-outlined${j}" autocomplete="off" value="${j}" onclick="checkLottoNo(this)">
         <label class="btn btn-outline-danger fs-6" for="danger-outlined${j}">${j}</label>
      
      </td>
         </c:forEach>   
      </tr>
      
   </c:forEach>
   </table>
   
   

   
 </div>
</div>

<div class="col"></div>
<div class="row lottoalert mb-3">
   <div class="col-4"></div>
      <div class="col-4 text-center lottoalertline"></div>
   <div class="col-4"></div>
</div>


<div class="row lottoinfo">
<div class="col-4"></div>
   <div class="col-4 text-center lottoinfoline" id="danger-outlined">로그인을 해주시기 바랍니다.</div>
<div class="col-4"></div>
</div>

<div class="row mb-3">
   <div class="mynumberdiv px-0">
         <div class="mytop-div">
         
         
         <div class="mytop-div-name">나의 추첨번호!</div>
         </div>
   
   <div class="mynumberset">
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/spaceship.png"></div>
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottospaceship2.png"></div>
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottoalien.png"></div>
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottospaceship2.png"></div>
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/spaceship.png"></div>
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottoalien.png"></div>
      <div class="mylottocircle"><p class="value"><img alt="" src="${pageContext.request.contextPath }/resources/img/lottospaceship2.png"></div>
      </div>
   </div>
</div>
 
 </div>

 <div class="row">
 <div class="col-4"></div>
    <button class="col-4 mb-3 btn btn-outline-danger" id="lottobutton"onclick="doLotto()"><i class="bi bi-controller fs-1"style="color:#B90000;"></i></button>
<div class="col-4"></div>
<br>
         <br>
         <br> 
</div>
 </div>
 </div>
 </div>
 <!-- 퀵메뉴 시작 오른쪽 -->
    <div id="quick_menu2" class="list-group">
      
      
         <img src="${pageContext.request.contextPath }/resources/img/lottoname.png">
         <div id ="lottonick" class="text-center"></div>
         <div class="row">
         	<div class="col">
           <img alt="" src="${pageContext.request.contextPath }/resources/img/lottoairplane.jpg">
          <img alt="" src="${pageContext.request.contextPath }/resources/img/lottoairplane.jpg">
          <img alt="" src="${pageContext.request.contextPath }/resources/img/lottoairplane.jpg">
         	
         	</div>
         </div>
       <%--    <img alt="" src="${pageContext.request.contextPath }/resources/img/lottoairplane.jpg"> --%>
         
         
        
         
         <img src="${pageContext.request.contextPath }/resources/img/lottoscore.png">
          <div id ="lottoscore" class="text-center"></div>
         
         
      <div class="text-center" style="border: 1px solid white;">
                 배당 경험치<br>  1개 &nbsp;&nbsp;&nbsp;일만원<br>
                       2개 &nbsp;&nbsp;&nbsp;오만원<br>
                       3개 &nbsp;&nbsp;&nbsp;십만원<br>
                       4개 &nbsp;&nbsp;&nbsp;오백만원<br>
                       5개 &nbsp;&nbsp;&nbsp;사천만원<br>
                       6개 &nbsp;&nbsp;&nbsp;일억원<br>
   </div>                       
         <br>
      </div>
    <!-- 퀵메뉴 끝 --
 
 
 
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
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
      crossorigin="anonymous"></script>
</body>
</html>