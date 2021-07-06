<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
	crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/header.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/tradeReadProductPage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/leftSide.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script type="text/javascript">
	var apply_modal = null;
	var apply_confirm_modal=null;
	var evaluate_modal=null;
	var reject_toast=null;
	var sessionMemberNo = null;
	var trade_freeboard_no = ${tradeVO.tradeVO.trade_freeboard_no};
	var completePurchaseCount=${completePurchaseCount};	
	
	function getSessionMemberNo(){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			    sessionMemberNo = obj.member_no;
			    if(sessionMemberNo!=null){
				    aboutPurchaseBtn();
				    rejectToast(sessionMemberNo);
			    }else{
			    	purchaseBtnNoSession(completePurchaseCount);
			    }
			}
		};
		
		xmlhttp.open("get","../member/getSessionMemberNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();		

	}  
    //글 수정
    //글수정불러오기
    
	function modifyTrade(){
		
    	var ModifyDeleteCol = document.getElementById("ModifyDeleteCol");
    	var ModifyBtn = ModifyDeleteCol.children[0].children[0];
    	
    	
		var trade_title = document.getElementById("trade_title");
		var product_price = document.getElementById("product_price");
		var textbox_size = document.getElementById("textbox_size");
		
		var title_inner = trade_title.children[0];
		var title_content = title_inner.innerText;
		title_inner.innerText = "";		
		
		var price_inner = product_price.children[0];
		var price_content = price_inner.innerText;
		price_inner.innerText = "";	
		
		var textbox_inner = textbox_size.children[0];
		var textbox_content = textbox_inner.innerText;
		textbox_inner.innerText = "";	
		
		var ModifyInput1 = document.createElement("textarea");
		ModifyInput1.setAttribute("id","ModifyInput1");
		ModifyInput1.setAttribute("class", "form-control resize-none");
		ModifyInput1.innerText = title_content;
		
        var ModifyInput2 = document.createElement("textarea");
        ModifyInput2.setAttribute("id","ModifyInput2");
        ModifyInput2.setAttribute("class", "form-control resize-none");
        ModifyInput2.innerText = price_content;
        
        var ModifyInput3 = document.createElement("textarea");
        ModifyInput3.setAttribute("id","ModifyInput3");
        ModifyInput3.setAttribute("class", "form-control resize-none");
        ModifyInput3.innerText = textbox_content;
		
        title_inner.appendChild(ModifyInput1);
        price_inner.appendChild(ModifyInput2);
        textbox_inner.appendChild(ModifyInput3);
        
		
		ModifyBtn.setAttribute("onclick","modifyContentProcess()");
	}
	
	
	//글수정 적용
	function modifyContentProcess(){
		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		var trade_freeboard_title = document.getElementById("ModifyInput1").value;
		var trade_freeboard_itemprice = document.getElementById("ModifyInput2").value;
		var trade_freeboard_content = document.getElementById("ModifyInput3").value;
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				location.href="${pageContext.request.contextPath}/trade/readProductPage.do?trade_freeboard_no="+trade_freeboard_no;
				
			}
		};
		
		xmlhttp.open("post","../trade/modifyContentProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("trade_freeboard_no="+trade_freeboard_no+"&trade_freeboard_title="+trade_freeboard_title+"&trade_freeboard_itemprice="+trade_freeboard_itemprice+"&trade_freeboard_content="+trade_freeboard_content);
	}
	//리플-----------------------------------------------------------
	function writeComment() {
		
		if(sessionMemberNo == null){
			alert("로그인을 하셔야 이용가능합니다.");
			return;
		}
		
		var commentValue = document.getElementById("trade_comment_content").value;
		commentValue.innerHTML ="";
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				
				refreshComment();
			}
		};
		
		xmlhttp.open("post","../trade/writeComment.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("trade_freeboard_no="+trade_freeboard_no + "&trade_comment_content=" + commentValue );		
		
	}
	
	function refreshComment(){
		var commentModifyRowNum = 1;

		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				//var commentListHead = document.getElementById("commentListHead");
				var commentListBody = document.getElementById("commentListBody");
				commentListBody.innerHTML ="";
				
				//commentListBody.appendChild(commentListHead);
				
				//이거 추가하기 
				var trade_comment_content = document.getElementById("trade_comment_content");				
				if(sessionMemberNo != null){
					trade_comment_content.value = "";
				}
				
				//댓글수
				var commentCount = document.getElementById("commentCount");
				commentCount.innerText= obj.commentCount;
				
				for(var data of obj.tradeCommentList){

					var li = document.createElement("li");
					li.setAttribute("class","list-group-item");
					
					var commentRowBox = document.createElement("div");
					commentRowBox.setAttribute("class","row mt-2 pb-2");
					commentRowBox.setAttribute("id","commentModifyRowBox" + commentModifyRowNum);
					
					//프로필
					var div = document.createElement("div");
					div.setAttribute("class","col-1 ps-4 bi bi-person-circle");
					div.setAttribute("style","font-size:30px;");
					commentRowBox.appendChild(div);
					
					
					var divcol = document.createElement("div");
					divcol.setAttribute("class","col pe-2");
					commentRowBox.appendChild(divcol);
					
					var divrow1 = document.createElement("div");
					divrow1.setAttribute("class","row");
					divcol.appendChild(divrow1);
					
					//댓글 작성자
					var divrowcol1 = document.createElement("div");
					divrowcol1.setAttribute("class","col");
					divrowcol1.setAttribute("style","font-size:28; font-weight:bold")
					divrowcol1.innerText = data.memberVO.member_nick;
					divrow1.appendChild(divrowcol1);
					
					//댓글 작성일자
					var divrowcol2 = document.createElement("div");
					divrowcol2.setAttribute("class","col-2 text-end");
					var d = new Date(data.tradeCommentVO.trade_comment_writedate);
					divrowcol2.innerText = d.getFullYear()+"."+(d.getMonth()+1)+"."+d.getDate();
					divrow1.appendChild(divrowcol2);
					
					//댓글 내용
					var divrow2 = document.createElement("div");
					divrow2.setAttribute("class","row mt-2 mb-3");
					divcol.appendChild(divrow2);
					
					var divrow2col = document.createElement("div");
					divrow2col.setAttribute("class","col");
					divrow2col.innerText = data.tradeCommentVO.trade_comment_content;
					divrow2.appendChild(divrow2col);
					
					//버튼
					var divrow3 = document.createElement("div");
					divrow3.setAttribute("class","row");
					divcol.appendChild(divrow3);
					
					//댓글 버튼
					if(sessionMemberNo == data.memberVO.member_no){
						
						var divrow3col = document.createElement("div");
						divrow3col.setAttribute("class","col-10");
						divrow3.appendChild(divrow3col);
						
						var divrow3col1 = document.createElement("div");
						divrow3col1.innerText = "수정";
						divrow3col1.setAttribute("class","col-1 pe-0 bi bi-pencil-square");
						divrow3col1.setAttribute("onclick","modifyComment("+data.tradeCommentVO.trade_comment_no+", " + commentModifyRowNum + ")");
						divrow3col1.setAttribute("style","color :#0000CD; ");	
						divrow3.appendChild(divrow3col1);
						
						var divrow3col2 = document.createElement("div");
						divrow3col2.innerText = "삭제";
						divrow3col2.setAttribute("class"," col-1 pe-0 bi bi-trash");
						divrow3col2.setAttribute("onclick","deleteComment("+data.tradeCommentVO.trade_comment_no+")");
						divrow3col2.setAttribute("style","color :#B22222;");	
						divrow3.appendChild(divrow3col2);
						
						
					} else{
						var divrow3col1 = document.createElement("div");
						divrow3col1.innerText = "";
						divrow3col1.setAttribute("class","col-1 text-center");
						divrow3.appendChild(divrow3col1);
						
						var divrow3col2 = document.createElement("div");
						divrow3col2.innerText = "";
						divrow3col2.setAttribute("class","col-1 text-center");
						divrow3.appendChild(divrow3col2);
					}
					
					li.appendChild(commentRowBox);
					
					commentListBody.appendChild(li);
					commentModifyRowNum++;
				}
				
			    
			}
		};
		
		xmlhttp.open("get","../trade/getCommentList.do?trade_freeboard_no="+trade_freeboard_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();		
		
	}

	
	//댓글수정불러오기
	function modifyComment(trade_comment_no, commentModifyRowNum){
		
		var commentRowBox = document.getElementById("commentModifyRowBox" + commentModifyRowNum);
		var commentContent = commentRowBox.children[1].children[1];
		var content = commentContent.innerText;
		commentContent.innerText = "";		
		
		
		var commentModifyInput = document.createElement("textarea");
		
		commentModifyInput.setAttribute("id","commentModifyInput");
		commentModifyInput.setAttribute("class", "form-control resize-none");
		commentModifyInput.innerText = content;
		
		
		commentContent.appendChild(commentModifyInput);
		
		var commentModifybtn = commentRowBox.children[1].children[2].children[1];
		commentModifybtn.setAttribute("onclick","modifyCommentProcess("+trade_comment_no+")");
	}
	
	
	//댓글수정 적용
	function modifyCommentProcess(trade_comment_no){
		
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();

		var trade_comment_content = document.getElementById("commentModifyInput").value;
 
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				refreshComment();
				
			}
		};
		
		xmlhttp.open("post","../trade/modifyCommentProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("trade_comment_no="+trade_comment_no+"&trade_comment_content="+trade_comment_content);
	}
		

	//댓글삭제 
	function deleteComment(trade_comment_no){
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				refreshComment();
			}
		};
		
		xmlhttp.open("get","../trade/deleteComment.do?trade_comment_no="+trade_comment_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();

	}	
	
	//찜하트-------------------------------------------------------------------------
	function doWish() {
				
		if(sessionMemberNo == null){
			alert("로그인을 하셔야 이용가능합니다.");
			
			return;
		}
		

		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				refreshWishData();
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/doWish.do?trade_freeboard_no=" + trade_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	
	}
	
   function refreshWishData() {
		
	   //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var wish_button = document.getElementById("wish_button");
				var wish_button_color = document.getElementById("wish_button_color");
				if(obj.myWishCount >0){
					wish_button.removeAttribute("class");
					wish_button.setAttribute("class", "bi bi-suit-heart-fill");
					wish_button.setAttribute("style", "color:#ff5757; font-size:25px;");
					wish_button_color.removeAttribute("class");
					wish_button_color.setAttribute("class", "btn btn-wishdark");


				}else{
					wish_button.removeAttribute("class");
					wish_button.setAttribute("class", "bi bi-suit-heart-fill");
					wish_button.setAttribute("style", "color:white; font-size:25px;");
					wish_button_color.removeAttribute("class");
					wish_button_color.setAttribute("class", "btn btn-wish");

				}
				
				var wishCountBox = document.getElementById("wishCountBox");
				wishCountBox.innerText = obj.wishTotalCount;
				
				var wishCountBox2 = document.getElementById("wishCountBox2");
				wishCountBox2.innerText = obj.wishTotalCount;
				wishCountBox2.setAttribute("style", "color:white;");
			}
		};  
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/getWishData.do?trade_freeboard_no=" + trade_freeboard_no, true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	
	}
   //구매신청현황
   function applyConfirmPage(){
	   apply_confirm_modal.show();
	   tradeApplyConfirmListPage();
   }
   
   function tradeApplyConfirmListPage() {
	   

	   //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				var apply_confirm_list = document.getElementById("apply_confirm_list");
				apply_confirm_list.innerHTML ="";
				
				var ApplicantCount=document.getElementById("ApplicantCount");
				ApplicantCount.innerText=obj[0].ApplicantCount;
				
				//var mannerScoreImage = document.createElement("img");
				//mannerScoreImage.setAttribute("src","${pageContext.request.contextPath}/resources/img/mannerscore.png");
				
				for(var data of obj){
									
					
                    if(data.tradeListVO.trade_list_approve == "R"){
                    	var applyListRowBox = document.createElement("div");
    					applyListRowBox.setAttribute("class","row p-2 ps-0 border-bottom border-1");
    					applyListRowBox.setAttribute("style","color:#828282;");
    					apply_confirm_list.appendChild(applyListRowBox);
    					
    					var div1 = document.createElement("div");
    					div1.setAttribute("class","col-1 pe-2 border-end border-1");
    					div1.innerText=data.memberVO.member_nick;
    					applyListRowBox.appendChild(div1);
    					
    					var div2 = document.createElement("div");
    					div2.setAttribute("class","col-2 pe-2 border-end border-1");
    					div2.innerText=data.mannerValue;
    					applyListRowBox.appendChild(div2);
    					
    					var div3 = document.createElement("div");
    					div3.setAttribute("class","col pe-2 border-end border-1");
    					div3.innerText=data.tradeListVO.trade_list_content;
    					applyListRowBox.appendChild(div3);
    					
    					var div4 = document.createElement("div");
    					div4.setAttribute("class","col-2 pe-2 border-end border-1 ");
    					div4.innerText=data.tradeListVO.trade_list_phone;
    					applyListRowBox.appendChild(div4);
    					
    					var div5 = document.createElement("div");
                    	div5.setAttribute("class","col-1 d-grid");
                    	div5.setAttribute("style","color:red; font-weight:bold; ")
                    	div5.innerText='거절됨';
                    	applyListRowBox.appendChild(div5);		
                    	
                    	var div6 = document.createElement("div");
                    	div6.setAttribute("class","col-1  d-grid");
                    	applyListRowBox.appendChild(div6);	
    					
                    }else if(data.tradeListVO.trade_list_approve == "Y"){
                    	var applyListRowBox = document.createElement("div");
    					applyListRowBox.setAttribute("class","row p-2 ps-0 border-bottom border-1");
    					apply_confirm_list.appendChild(applyListRowBox);
    					
    					var div1 = document.createElement("div");
    					div1.setAttribute("class","col-1 pe-2 border-end border-1");
    					div1.innerText=data.memberVO.member_nick;
    					applyListRowBox.appendChild(div1);
    					
    					var div2 = document.createElement("div");
    					div2.setAttribute("class","col-2 pe-2 border-end border-1");
    					div2.setAttribute("style","color:#FFB914; font-weight:bold;");
    					div2.innerText=data.mannerValue;
    					applyListRowBox.appendChild(div2);
    					
    					var div3 = document.createElement("div");
    					div3.setAttribute("class","col pe-2 border-end border-1");
    					div3.innerText=data.tradeListVO.trade_list_content;
    					applyListRowBox.appendChild(div3);
    					
    					var div4 = document.createElement("div");
    					div4.setAttribute("class","col-2 pe-2 border-end border-1 ");
    					div4.innerText=data.tradeListVO.trade_list_phone;
    					applyListRowBox.appendChild(div4);
    					
    					var div5 = document.createElement("div");
    					div5.setAttribute("class","col-2 d-grid");
    					applyListRowBox.appendChild(div5);
    					
    					var div5button = document.createElement("button");
    					div5button.setAttribute("class","btn btn-evaluate btn-sm");
    					div5button.setAttribute("onclick","evaluateBtn("+data.tradeListVO.trade_list_no+")");
    					div5button.setAttribute("style","color:white;");
    					div5button.innerText='평가하기';
    					div5.appendChild(div5button);
    					
    					
                    }else if(data.tradeListVO.trade_list_approve == "C"){
                    	var applyListRowBox = document.createElement("div");
    					applyListRowBox.setAttribute("class","row p-2 ps-0 border-bottom border-1");
    					apply_confirm_list.appendChild(applyListRowBox);
    					
    					var div1 = document.createElement("div");
    					div1.setAttribute("class","col-1 pe-2 border-end border-1");
    					div1.innerText=data.memberVO.member_nick;
    					applyListRowBox.appendChild(div1);
    					
    					var div2 = document.createElement("div");
    					div2.setAttribute("class","col-2 pe-2 border-end border-1");
    					div2.setAttribute("style","color:#FFB914; font-weight:bold;");
    					div2.innerText=data.mannerValue;
    					applyListRowBox.appendChild(div2);
    					
    					var div3 = document.createElement("div");
    					div3.setAttribute("class","col pe-2 border-end border-1");
    					div3.innerText=data.tradeListVO.trade_list_content;
    					applyListRowBox.appendChild(div3);
    					
    					var div4 = document.createElement("div");
    					div4.setAttribute("class","col-2 pe-2 border-end border-1 ");
    					div4.innerText=data.tradeListVO.trade_list_phone;
    					applyListRowBox.appendChild(div4);
    					
    					var div5 = document.createElement("div");
                    	div5.setAttribute("class","col-1 d-grid");
                    	div5.setAttribute("style","color:blue; font-weight:bold; ")
                    	div5.innerText='거래완료';
                    	applyListRowBox.appendChild(div5);		
                    	
                    	var div6 = document.createElement("div");
                    	div6.setAttribute("class","col-1  d-grid");
                    	applyListRowBox.appendChild(div6);	
                    	    					
                    }else{
                    	var applyListRowBox = document.createElement("div");
    					applyListRowBox.setAttribute("class","row p-2 ps-0 border-bottom border-1");
    					apply_confirm_list.appendChild(applyListRowBox);
    					
    					var div1 = document.createElement("div");
    					div1.setAttribute("class","col-1 pe-2 border-end border-1");
    					div1.innerText=data.memberVO.member_nick;
    					applyListRowBox.appendChild(div1);
    					
    					var div2 = document.createElement("div");
    					div2.setAttribute("class","col-2 pe-2 border-end border-1");
    					div2.setAttribute("style","color:#FFB914; font-weight:bold;");
    					div2.innerText=data.mannerValue;
    					applyListRowBox.appendChild(div2);
    					
    					var div3 = document.createElement("div");
    					div3.setAttribute("class","col pe-2 border-end border-1");
    					div3.innerText=data.tradeListVO.trade_list_content;
    					applyListRowBox.appendChild(div3);
    					
    					var div4 = document.createElement("div");
    					div4.setAttribute("class","col-2 pe-2 border-end border-1 ");
    					div4.innerText=data.tradeListVO.trade_list_phone;
    					applyListRowBox.appendChild(div4);
    					
    					if(data.completePurchaseCount >0){
	                    	
    						var div5 = document.createElement("div");
    						div5.setAttribute("class","col-1");
                        	//div5.setAttribute("class","col-1 pe-2 btn btn-success btn-sm");
                        	//div5.setAttribute("onclick","completeAlert()");
        					applyListRowBox.appendChild(div5);
        					
        					var div6 = document.createElement("div");
	    					div6.setAttribute("class","col-1");
	    					applyListRowBox.appendChild(div6);
        					
    					}else{
    						var div5 = document.createElement("div");
                        	div5.setAttribute("class","col-1  d-grid");
                        	applyListRowBox.appendChild(div5);
        					
        					var div5button = document.createElement("button");
        					div5button.setAttribute("class","btn btn-outline-primary btn-sm");
        					div5button.setAttribute("onclick","sellConfirmBtn("+data.tradeListVO.trade_list_no+")");
        					div5button.innerText='판매';
                        	div5.appendChild(div5button);
        					
        					var div6 = document.createElement("div");
        					div6.setAttribute("class","col-1 d-grid");
        					applyListRowBox.appendChild(div6);
        					
        					var div6button = document.createElement("button");
        					div6button.setAttribute("class","btn btn-outline-danger btn-sm");
        					div6button.setAttribute("onclick","rejectConfirmBtn("+data.tradeListVO.trade_list_no+")");
        					div6button.innerText='거절';
        					div6.appendChild(div6button);
    					}
                    }
										
					
				}
				
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/trade/tradeApplyConfirmListPage.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("trade_freeboard_no="+trade_freeboard_no);
   }
   
   //판매완료됐을때 판매나 거절 눌렀을 때
   function completeAlert(){
	   alert("이미 다른분과 판매했습니다. 확인해 보세요");
   }
   //판매버튼 눌렀을때-1
   function sellConfirmBtn(trade_list_no) {
	
	 
	  if (confirm("판매완료하셨습니까?")==true) {
		  sellingBtn(trade_list_no);
		  
	   } else {
	        return;
	   }
   }
   //판매버튼 눌렀을때-2
   function sellingBtn(trade_list_no) {
	
	 
	 //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);

			    tradeApplyConfirmListPage();

		    	
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/sellProcess.do?trade_list_no="+trade_list_no , false);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
   }
   
   //판매-평가하기
   function evaluateBtn(list_no) {
	 //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			       evaluate_modal.show();
				   var NameOfBuyer= document.getElementById("NameOfBuyer");
				   NameOfBuyer.setAttribute("style","font-weight:bold;")
				   NameOfBuyer.innerText=obj.buyer_nick;
				   var trade_list_no= document.getElementById("trade_list_no");
				   trade_list_no.value=list_no;
				   var evaluate_value= document.getElementById("evaluate_value").options;
				   var num = document.getElementById("evaluate_value").selectedIndex;
				   evaluate_value.value=evaluate_value[num].index;
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/evaluteBuyerInfo.do?trade_list_no="+list_no , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
		

	
}
   //판매-평가하기-확인
   function evaluateConfirmBtn() {
	   
	   
	 //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
				evaluate_modal.hide();
				tradeApplyConfirmListPage();
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/trade/evaluateInfo.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("evaluate_value=" + evaluate_value.value + "&evaluate_content="+evaluate_content.value+"&trade_list_no=" + trade_list_no.value);	
}
   //판매-평가하기-취소
   function cancelEvaluate() {
	   evaluate_modal.hide();

}
   
   //거절버튼 눌렀을때 팝업
   function rejectConfirmBtn(trade_list_no) {
	   
	        if (confirm("정말 거절하시겠습니까?")==true) {
	        	rejectBtn(trade_list_no)
	        } else {
	             return;
	        }
	    
}
   //거절 팝업 확인
   function rejectBtn(trade_list_no) {
	   
	   
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    //var obj = JSON.parse(xmlhttp.responseText);
			    console.log('fdasdfasdf');
			    tradeApplyConfirmListPage();

		    	
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/rejectProcess.do?trade_list_no="+trade_list_no , false);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
	  
   }

   
   //구매자에게 거절 알람창 띄우기
   function rejectToast(sessionMemberNo) {
	  
	  
	//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			    var obj = JSON.parse(xmlhttp.responseText);
			    
			    if(obj.result == 'R' && obj.sellcomplete == 0){
					  reject_toast.show();
				  }
			}
		};
		
		xmlhttp.open("get","${pageContext.request.contextPath}/trade/rejectPopup.do?trade_freeboard_no="+trade_freeboard_no+"&sessionMemberNo="+sessionMemberNo , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();	
   }
   //거절후 재거래 
   function reTradeBtn(){
	    
	   apply_modal.show();
   
   }
   //구매 신청
   function applyPage(){
	   apply_modal.show();
	}
   
   function tradeApplyProcess(){
	   var trade_list_phone= document.getElementById("trade_list_phone");
	   
	   if(trade_list_phone.value == ""){
			alert("전화번호를 적으십시오.");
			return;
		}
	 //AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				//var obj = JSON.parse(xmlhttp.responseText);
				
				
				
				
				var trade_list_content = document.getElementById("trade_list_content");
				trade_list_content.innerHTML="";
				//trade_list_phone.innerHTML="";
				
				if(document.getElementById("purchaseApplyBtn")){

				var purchaseApplyBtn = document.getElementById("purchaseApplyBtn");

					purchaseApplyBtn.removeAttribute("class");
					purchaseApplyBtn.setAttribute("class","btn btn-primary btn-lg d-grid disabled");
					purchaseApplyBtn.innerText='신청완료';
				    apply_modal.hide();
				}else if(document.getElementById("applyFinishBtn")){
					apply_modal.hide();
					reject_toast.hide();
				}	
				
				
			}
		};
		
		xmlhttp.open("post","${pageContext.request.contextPath}/trade/tradeApplyProcess.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("trade_list_content=" + trade_list_content.value + "&trade_list_phone="+trade_list_phone.value+"&trade_freeboard_no=" + trade_freeboard_no);	
	}
   
   function aboutPurchaseBtn() {
	       
	   
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
	        
	        
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				    var obj = JSON.parse(xmlhttp.responseText);
				    var aboutPurchaseBtn = document.getElementById("aboutPurchaseBtn");
				    //aboutPurchaseBtn.setAttribute("style", "padding-left:28px; padding-right:0px;");
				    if(sessionMemberNo == obj.tradeVO.member_no){
				    					    	
				    	var a = document.createElement("a");
				    	a.setAttribute("id","applyConfirm_button");
				    	a.setAttribute("class","btn btn-purchase btn-lg d-grid");
				    	a.setAttribute("onclick","applyConfirmPage()");
				    	a.setAttribute("style", "font-size:20px; color:white; width: 130px; height: 50px;");
				    	a.innerText='신청현황';
				    	aboutPurchaseBtn.appendChild(a);
				    	
				    }else if(obj.completePurchaseCount > 0){
				    	var a = document.createElement("a");
				    	a.setAttribute("id","applyFinishBtn");
				    	a.setAttribute("class","btn btn-purchase btn-lg d-grid disabled");
				    	a.setAttribute("style", "font-size:20px; color:white; width: 130px; height: 50px;");
				    	a.innerText='판매완료';
				    	aboutPurchaseBtn.appendChild(a);
				    }else if(obj.count != 0){
				    	var a = document.createElement("a");
				    	a.setAttribute("id","applyFinishBtn");
				    	a.setAttribute("class","btn btn-purchase btn-lg d-grid disabled");
				    	a.setAttribute("style", "font-size:20px; color:white; width: 130px; height: 50px;");
				    	a.innerText='신청완료';
				    	aboutPurchaseBtn.appendChild(a);	
				    }else{
				    	var a = document.createElement("a");
				    	a.setAttribute("id","purchaseApplyBtn");
				    	a.setAttribute("class","btn btn-purchase btn-lg d-grid");
				    	a.setAttribute("style", "font-size:20px; color:white; width: 130px; height: 50px;");
				    	a.setAttribute("onclick","applyPage()");
				    	a.innerText='구매신청';
				    	aboutPurchaseBtn.appendChild(a);
				    }
				}
			};
			
			xmlhttp.open("post","${pageContext.request.contextPath}/trade/aboutPurchasebtn.do" , true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("member_no="+sessionMemberNo+"&trade_freeboard_no="+trade_freeboard_no);	
			
	

}
   function purchaseBtnNoSession(completePurchaseCount) {
	   var aboutPurchaseBtn = document.getElementById("aboutPurchaseBtn");
	   
	   if(completePurchaseCount>0){
		   var a = document.createElement("a");
	    	a.setAttribute("id","applyFinishBtn");
	    	a.setAttribute("class","btn btn-purchase btn-lg d-grid disabled");
	    	a.setAttribute("style", "font-size:20px; color:white; width: 130px; height: 50px;");
	    	a.innerText='판매완료';
	    	aboutPurchaseBtn.appendChild(a);
	   }else{
		    
		   	var a = document.createElement("a");
		   	a.setAttribute("id","purchaseApplyBtn");
		   	a.setAttribute("class","btn btn-purchase btn-lg d-grid");
		   	a.setAttribute("style", "font-size:20px; color:white; width: 130px; height: 50px;");
		   	a.setAttribute("onclick","loginAlert()");
		   	a.innerText='구매신청';
		   	aboutPurchaseBtn.appendChild(a);
	   }
   }
   //로그인 하라고 알림
   function loginAlert() {
	   alert("로그인을 하셔야 이용가능합니다.");
			return;
}

   //게시물 삭제 수정


   //------------------------------------------
	function init(){
		apply_modal = new bootstrap.Modal(document.getElementById('applyPage'));
		apply_confirm_modal= new bootstrap.Modal(document.getElementById('applyConfirmPage'));
		evaluate_modal= new bootstrap.Modal(document.getElementById('sellAndEvaluatePage'));
		reject_toast= new bootstrap.Toast(document.getElementById('rejectToast'));
		
		getSessionMemberNo();
		refreshComment(); 
		refreshWishData();
		//setInterval(, 1000);
		//setInterval(tradeApplyConfirmListPage, 1000); 

		
	}




</script>
</head>
<body onload="init()">
	
	<div style="width: 1200px; margin: 0 auto;">
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/commons/header.jsp" />
	<!-- 헤더 끝 -->
	<div class="container-fluid mb-5">
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
				<!-- 본문 시작 -->
							 	 		
					<!--내용 이미지랑  정보와 구매 신청 창 -->
					<div class="row mb-4"> 
					    <div class="col ps-3">
					      <a href="${pageContext.request.contextPath}/trade/tradePage.do" style="text-decoration:none"><span style="color: gray;"><i class="bi bi-house-door-fill"></i>&nbsp;홈 </span></a>
					      <span style="color: gray;">&nbsp;&nbsp;>&nbsp;&nbsp;</span>
					      <span style="color: gray;">${tradeVO.itemCategoryVO.item_category_name }</span>
						 </div>
						  
					</div>
					<div class="row border-border-2 mb-3 pb-2">
					  <!--내용 이미지  -->
					  	
					  <div class="col-6" id="trade_readPage_image">
					    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel"> 
						  
						  <div class="carousel-indicators" >
						   <c:forEach items="${tradeVO.tradeImageVO}" var="tradeImageVOList" varStatus="status">
						   <c:choose>
						     <c:when test="${status.first }">
						      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						     </c:when>
						     <c:otherwise>
						      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" aria-label="Slide 2"></button>
						     </c:otherwise>
						     </c:choose>
						   </c:forEach>
						  </div>
						  
						  <div class="carousel-inner" id="carouselExampleIndicators">
						   <c:forEach items="${tradeVO.tradeImageVO}" var="tradeImageVOList" varStatus="status"> 
						     
						     <c:choose>
						       <c:when test="${status.first }">
						     	<div class="carousel-item active">
						         <img src="/upload_files/${tradeImageVOList.image_location }" width="450" height="500" class="d-block w-100" >
						        </div>
						       </c:when>
						       
						       <c:otherwise>
						         <div class="carousel-item ">
						          <img src="/upload_files/${tradeImageVOList.image_location }" width="450" height="500" class="d-block w-100" alt="...">
						         </div>
						       </c:otherwise>
						     
						     </c:choose>
						      
						    </c:forEach>
						  </div>
						  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Previous</span>
						  </button>
						  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Next</span>
						  </button>
						</div>
					  </div>
					  
					  
					  <div class="col-6 ps-5">   
					   <!--제목  -->
						
						<div class="row mb-2 mt-2">
							<div class="col" id="trade_title">
								<span class="text-start fs-3"> <b>${tradeVO.tradeVO.trade_freeboard_title }</b></span>
							</div>
						</div>
						<div class="row mb-4">   
						   <div class="d-flex "> 
							<div  id="product_price">
								<span class="text-start fs-1" ><b><fmt:formatNumber value="${tradeVO.tradeVO.trade_freeboard_itemprice }"/></b></span>
							</div>
							<div class="text-start align-self-center fs-3 ps-0 ">&nbsp;원</div>
						    </div>
						</div>
						 
						<c:choose>
						<c:when test="${tradeVO.memberVO.member_no eq sessionUser.member_no }">
						<div class="row border-bottom border-1" >
							 <div class="col-9"></div>
							 <div class="col ps-4" id="ModifyDeleteCol">
								<span class="pull-right" onclick="modifyTrade()" ><i style="color : darkgrey; font-size:20px;" class="bi bi-pencil-square"></i></span>
								<span>&nbsp;</span>
								<span class="pull-right"  ><a href="${pageContext.request.contextPath }/trade/contentDelete.do?trade_freeboard_no=${tradeVO.tradeVO.trade_freeboard_no}"><i  style="color : darkgrey; font-size:20px;" class="bi bi-trash"  ></i></a></span> 
							 </div>
					    </div> 
						</c:when>
						<c:otherwise>
							<div class="row border-bottom border-1" >
							   <span style=" font-size:20px;">&nbsp;</span>
							</div>
						</c:otherwise>
						</c:choose> 
						     
						<div class="row mt-4 mb-4">	
							<div class="col">
								<p style="color : darkgrey;"> 
									<span><i class="bi bi-heart-fill"></i></span>
									<span id ="wishCountBox"></span><b>&nbsp;&nbsp;|&nbsp;&nbsp;</b>
									<span><i class="bi bi-eye-fill"></i> ${tradeVO.tradeVO.trade_freeboard_readcount }<b>&nbsp;&nbsp;|&nbsp;&nbsp;</b></span>   
									<span><b><i class="bi bi-person-fill"></i>&nbsp;${tradeVO.memberVO.member_nick }&nbsp;&nbsp;</b></span>
								   
								</p>  
							</div>       
						</div>    
					   <div class="row">  
					      <div class="row mb-3 " style="color : gray"><b>상품 정보</b></div> 
					      <div class="row" >
							  <div class="col border border-1 p-3" id="textbox_size">					  
							    <p>${tradeVO.tradeVO.trade_freeboard_content }</p>
							  </div>
					      </div>
					     </div>  
					      <!-- 찜 추천  구매신청-->
						    <div class="row mt-4 justify-content-center">
							  <div class="col-4 ps-1"><button type="button" class="btn btn-wish" id="wish_button_color" onclick="doWish()" style="width: 130px; height: 50px;"><span id="wish_button"></span><span style="font-size:18px; color:white;">&nbsp;&nbsp;찜&nbsp;&nbsp;</span><span id ="wishCountBox2"></span></button></div>
						      <div class="col-4 ps-1" id="aboutPurchaseBtn"></div>
							 </div>					       
					  </div>	
					</div>
					<!--내용 이미지랑  정보와 구매 신청 창 끝 -->
								  
					<!-- 댓글  쓰기 -->
					
					<div class="row border-bottom border-1 mb-3"></div>
					<div class="row mt-4">
					  <div class="col ps-4" style="font-size:20px;"><span><b>상품문의&nbsp;</b></span><span style="color:red;" id="commentCount"></span></div>
					  <div class="col-9"></div>
					</div>
					<div class="row mt-3 mb-3 ">
					 <c:choose>
						 <c:when test="${sessionUser == null }">
						  <div class="col ps-4">					  
							   <textarea id="trade_comment_content" class="form-control resize-none " name="trade_comment_content" placeholder="로그인 후 입력 가능합니다" disabled></textarea>
						  </div>  
						  </c:when>
						  <c:otherwise>
						  <div class="col ps-4">					  
							   <textarea id="trade_comment_content" class="form-control resize-none" name="trade_comment_content" placeholder="상품문의 입력"></textarea>
						  </div>
						  </c:otherwise>
				      </c:choose>
				      
				      <div class="col-1 p-0">
						 <button type="button" class="btn btn-commentRegister" onclick="writeComment()"><span style="font-size:14px; color:white;"><i class="bi bi-pencil"></i></span><span style="font-size:15px; color:white;">&nbsp;등록</span></button>					      
					  </div>   
						    
					</div> 
	
				   <div class="row">
				      <div class="col">
				      	<ul id="commentListBody" class="list-group list-group-flush"></ul>
				      </div>
				   </div>
				   
				<!-- 본문 끝 -->
			</div>
			</div>
		</div>
		</div>  
	</div>
	</div>
	
	<!--============================ Toast =========================================-->
	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 5">
		<div id="rejectToast" class="toast" role="alert" aria-live="assertive" data-bs-autohide="false">
			<div class="toast-header">
				<i class="bi bi-bell-fill fs-6 me-2 text-danger"></i>
				<strong class="me-auto">거래거부</strong>
				<small></small>
				<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
			<div class="toast-body">

				<div class="row"><div class="col-3"></div>판매자가 거래 거절했습니다.</div>
				<div class="row"><div class="col-3"></div>다시 거래메세지를 보내시겠습니까?</div>
				<div class="row mt-3">
				   <div class="col-3"></div>
				   <div class="col"><button type="button" class="btn btn-primary btn-sm" onclick="reTradeBtn()">네</button></div>
				   <div class="col"><button type="button" class="btn btn-danger btn-sm" data-bs-dismiss="toast" aria-label="Close">아니오</button></div>
				   <div class="col-3"></div>
				</div>

			</div>
		</div>
	</div>
	
	<div id="toast_container" class="toast-container">
	</div>

<!--========================================= Modal ================================================-->
<!--신청 페이지  -->
<div class="modal fade" id="applyPage" tabindex="-1" aria-labelledby="applyPageLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="applyPageLabel">중고거래신청</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
					
		<div class="row mt-2 pb-2 border-bottom border-1">
			<div class="col-8">
				<span class="box"><i class="bi bi-cart"></i><b>&nbsp; ${tradeVO.tradeVO.trade_freeboard_title }</b></span>
			</div>
		    <div class="col">
				<p class="text-end pt-2 mb-0">
					<small><i class="bi bi-person-fill"></i> &nbsp;${sessionUser.member_nick }</small>
				</p>
			</div>
		</div>
		<!--내용  -->
		<div class="row mb-3 mt-3">
			<div class="col-8">전화번호 : &nbsp; <input  type="text" id="trade_list_phone" name="trade_list_phone" placeholder="- 없이 입력해주세요" ></div>
			<div class="col"></div>
		</div>
		<div class="row">
				<textarea class="form-control h-100" id="trade_list_content" name="trade_list_content" placeholder="내용을 입력하세요"></textarea>
		</div>			
					
			
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="tradeApplyProcess()">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<!--신청 현황 페이지  -->
<div class="modal fade" id="applyConfirmPage" tabindex="-1" aria-labelledby="applyConfirmPageLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="applyConfirmPageLabel">신청현황</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
		  	<div class="row border border-1 mb-3 mt-2">
				<ul class="list-group list-group-flush pe-0">
				<li class="list-group-item mt-3">
					<div class="row mt-2 pb-2 ">
					  	 <div class="col-1 pe-2">No.${tradeVO.tradeVO.trade_freeboard_no }</div>
						 <div class="col pe-2"><span style="font-size:18px;"><b>${tradeVO.tradeVO.trade_freeboard_title }</b></span></div>
			   	         <div class="col-2 text-end p-0"><i class="bi bi-calendar-check"></i>&nbsp;<fmt:formatDate value="${tradeVO.tradeVO.trade_freeboard_writedate }" pattern="yy.MM.dd"/></div>  		 
					     <div class="col-1 text-end pe-3"><i class="bi bi-people-fill"></i>&nbsp;<span id="ApplicantCount"></span></div>
					</div>
				  </li>
				  <li class="list-group-item">
					<div class="row">
					  	 <div class="col-1 pe-2 border-end border-1"><b>이름</b></div>
						 <div class="col-2 pe-2 border-end border-1"><b>매너점수</b></div>
			             <div class="col pe-2 border-end border-1"><b>내용보기</b></div>
			             <div class="col-2 pe-2 border-end border-1"><b>전화번호</b></div> 		 
					     <div class="col-2 pe-2"><b>판매상태</b></div>
					     
					</div>
				  </li> 
				  
				  <li class="list-group-item" id="apply_confirm_list">
				  </li>  
				  
				</ul>		   	
			</div>				

      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창 닫기</button>
      </div>
    </div>
  </div>
</div>
<!--판매누르면 나오면 평가 페이지  -->
<div class="modal fade" id="sellAndEvaluatePage" tabindex="-1" aria-labelledby="sellAndEvaluatePageLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="sellAndEvaluatePageLabel">평가하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
			<div class="row mt-2 pb-2 " id="evaluate_info">
				<div class="col-1 pe-2 "><i class="bi bi-person-fill"></i></div> 
				<div class="col-2 ps-0 border-end border-1" id="NameOfBuyer"></div>
				<div class="col-2 ps-2"> 
				  <select name="evaluate_value" id="evaluate_value">
				    <option value="5">5</option>
				    <option value="4">4</option>
				    <option value="3">3</option>
				    <option value="2">2</option>
				    <option value="1">1</option>
				</select>
				</div>	  	 	         
			</div>
			<div class="row">
				<textarea class="form-control h-100" id="evaluate_content" name="evaluate_content" placeholder="내용을 입력하세요"></textarea>
		    </div>
		    
		    <input type="hidden" id="trade_list_no">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="evaluateConfirmBtn()">확인</button>
        <button type="button" class="btn btn-secondary" onclick="cancelEvaluate()">취소</button>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous"></script>
</body>
</html>