<%@page import="com.RentLoGo.rentCar.model.AllCarDTO"%>
<%@page import="com.RentLoGo.rentCar.model.CarDTO"%>
<%@page import="com.RentLoGo.rentCar.model.RentCarDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>렌터카 관리</title>
<script src="/rentCar/resources/jQuery/jQuery3.6.js"></script>

<style>
		.carSearchBar {
			width: 500px;
			margin-left: 65%;
			margin-bottom: 10px;
		}
		
        .carManagement .title {
            text-align: center;
        }
        
        .carManagement article .title {
            text-align: center;
            display: grid;
            grid-template-columns: repeat(9, 1fr);
            margin-bottom: 50px;
            border-top: 1px solid rgba(0,0,0,0.3);
            border-bottom: 1px solid rgba(0,0,0,0.3);
            line-height: 50px;
        }
        .carManagement article .content {
        	text-align: center;
            display: grid;
            grid-template-columns: repeat(9, 1fr);
            border-bottom: 1px solid rgba(160, 52, 248, 0.8);
            line-height: 30px;
        }
        
        .carManagement article a:hover {
        	color: red;
        }
        
        #managerModifyCarForm {
        	position: fixed;
        	width: 100%;
        	height: 100%;
        	top: 0;
        	left: 0;
        	background-color: rgba(30, 30, 30, 0.5);
        }
        
        #managerModifyCarForm .title {
            text-align: center;
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            margin-bottom: 50px;
            border-top: 1px solid rgba(0,0,0,0.3);
            border-bottom: 1px solid rgba(0,0,0,0.3);
            line-height: 50px;
        }
        
        #managerModifyCarForm .content > form {
            text-align: center;
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            border-bottom: 1px solid rgba(160, 52, 248, 0.8);
            line-height: 30px;
        }
        
        #managerModifyCarForm > div {
        	background-color: white;
        	width: 1200px;
        	height: 300px;
        	margin: 0 auto;
        	position: relative;
        	top: 50%;
        	transform: translateY(-100%);
        }
        
        #managerModifyCarForm .content input[type="text"]{
        	width: 120px;
        	border: none;
        	background: white;
        }
        
        #managerModifyCarForm .content input[disabled] {
        	color: silver;
        }
        
        .hiddenIcon {
        	display: none;
        	font-size: 30px;
        	margin-right: 50px;
        }
        
        @media(max-width: 960px) {
        	.hiddenIcon {
        		display: block;
        	}
        	.memberSearchBar form {
        		display: none;
        	}
        }
        
        @media(max-width: 780px) {
        	.hiddenIcon {
        		text-align: left;
        		margin-left: 100px;
        	}
        }
</style>
 <script>
        	
	function delCar(e) {
		
        let carNumber = e.parentElement.parentElement.querySelector('div:first-child').textContent;
        let xhttp = new XMLHttpRequest();
        let requestJSON = new Object();
        requestJSON.carNumber = carNumber;

        xhttp.open('post', "${contextPath }/manager/dropCar.do", true);
        xhttp.setRequestHeader('Content-type', 'application/json; charset=UTF-8;');
        xhttp.responseType = "json";
        xhttp.send(JSON.stringify(requestJSON));

        xhttp.onreadystatechange = function() {
			if(this.readyState == 4 && this.status == 200) {

                let article = document.querySelector('.carManagement article');
				$(article).load('${contextPath}/manager/manageCar.do article');
				
    			}
    		}

    	} //delCar 이벤트 함수 끝
            	
    	$(document).ready(function() {
    		
       		$('#searchButton').click(function() {
       			
           		let inputVal = $('.inputSearch').val();
           		let selected = $('.selected').val();
           		let jsonData = {'inputVal':inputVal, 'selected':selected};
       			console.log('클릭');
       			$.ajax({
       				type: 'POST',
       				url: '${contextPath}/manager/searchCar.do',
       				data: JSON.stringify(jsonData),
       				contentType : "application/json; charset=utf-8",
       				dataType: 'json',
       				success: function(jsonCarList) {

                        let string = '';

						$('.content').remove();
                        
	                        for(let j = 0; j < jsonCarList.length; j++) {
                      string += '<div class="content">' +
	                                
	                                '<div><a href="javascript:void(0)" onclick="modifyCar(this)" id="modAnchor">'+jsonCarList[j].rentCarDTO.carNumber+'</a></div>' +
	                                '<div>'+jsonCarList[j].carDTO.carModel+'</div>' +
	                                '<div>'+jsonCarList[j].rentCarDTO.carColor+'</div>' +
	                                '<div>'+jsonCarList[j].carDTO.carSize+'</div>' +
	                                '<div>'+jsonCarList[j].carDTO.carType+'</div>' +
	                                '<div>'+jsonCarList[j].rentCarDTO.carDistance+'</div>' +
	                                '<div>'+jsonCarList[j].carDTO.carMade+'</div>' +
	                                '<div>'+jsonCarList[j].carDTO.carPrice+'</div>' +
	                                '<div><input type="button" onclick="delCar(this)" value="삭제"></div>' +
	                            '</div>';
	                            
	                        }
	                        let article = document.querySelector('.carManagement article');
	                            article.insertAdjacentHTML('beforeend', string);
       					
       				},
       				error: function() {
						location.href='${contextPath}/manager/manageCar.do';
       				}
       			}); // ajax 끝
       		}); //searchButton 클릭 함수 끝
           		
       		let modificationForm = document.querySelector('#managerModifyCarForm');
	    	window.addEventListener('click',function(e) {
	    		console.log(e.target);
	    		(e.target == modificationForm) ? modificationForm.classList.add('hide') : false;
	    	});
		    	
});
           	
function toEnabled() { //수정폼 number disabled 해제
	$('#managerModifyCarForm input[name=carNumber]').attr('disabled', false);
}  	

function modifyCar(e) { // number로 검색해서 수정폼에 출력
	let number = e.childNodes[0].nodeValue;
	let jsonData = {'selected':'number', 'inputVal':number};
	
	$.ajax({
		type: 'POST',
		url: '${contextPath}/manager/searchCar.do',
		data: JSON.stringify(jsonData),
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		success: function(jsonCarList) {
			let string = '';
			
			$('#managerModifyCarForm .content').remove();
			
			string +=      '<div class="content">' +
	           '<form action="${contextPath }/manager/managerCarModify.do" method="POST" onsubmit="toEnabled()">' +
		            '<div><input type="text" name="carNumber" value="'+jsonCarList[0].rentCarDTO.carNumber+'" disabled/></div>' +
		            '<div><input type="text" name="carModel" value="'+jsonCarList[0].carDTO.carModel+'" /></div>' +
		            '<div><input type="text" name="carColor" value="'+jsonCarList[0].rentCarDTO.carColor+'"/></div>' +
		            '<div><input type="text" name="carSize" value="'+jsonCarList[0].carDTO.carSize+'"/></div>' +
		            '<div><input type="text" name="carType" value="'+jsonCarList[0].carDTO.carType+'"/></div>' +
		            '<div><input type="text" name="carDistance" value="'+jsonCarList[0].rentCarDTO.carDistance+'"/></div>' +
		            '<div><input type="text" name="carMade" value="'+jsonCarList[0].carDTO.carMade+'"/></div>' +
		            '<div><input type="text" name="carPrice" value="'+jsonCarList[0].carDTO.carPrice+'"/></div>' +
		            '<div><input type="submit" value="수정완료"/></div>' +
           			'</form>' +
	            '</div>' ;
           
            let hiddenForm = document.querySelector('#managerModifyCarForm');
            let div = document.querySelector('#managerModifyCarForm > div');
            div.insertAdjacentHTML('beforeend', string);
            
            hiddenForm.classList.remove('hide');
 		},
 		error: function() {
 			location.href='${contextPath}/manager/manageCar.do';
 		}
	});
}

//삭제 확인 - 취소해도 이미 지워져있음..	
$(document).ready(function(){
	$('.delete_Car').click(function() {
		if(!confirm("삭제 시, 복구할 수 없습니다. 삭제하시겠습니까?")){
			return false;
		}
	})
}) 
</script>
    
</head>
<body>

	<section class="carManagement">
		<div class="title">
			<h1>렌터카 관리</h1>
			<div class="carSearchBar">
				<div class="hiddenIcon"><i class="fa-solid fa-magnifying-glass"></i></div>
				<form action="" method="post" id="carSearchForm">
					<input type="text" class="inputSearch" name="searchInput"/>
					<select name="searchOption" class="selected">
						<option value="number">차량번호</option>
						<option value="model">모델명</option>
					</select>
					<input type="button" value="검색" id="searchButton"/>
				</form>
			</div>
		</div>
		<article>
			<div class="title">
				<div>차량번호</div>
				<div>모델</div>
				<div>색상</div>
				<div>크기</div>
				<div>종류</div>
				<div>주행거리</div>
				<div>제조사</div>
				<div>가격</div>
                <div></div>
            </div>
            
            <c:forEach var="allCar" items="${list }">
            <div class="content">
	            	<div><a href="javascript:void(0)" onclick="modifyCar(this)" id="modAnchor">${allCar.rentCarDTO.carNumber}</a></div>
		            <div>${allCar.carDTO.carModel }</div>
		            <div>${allCar.rentCarDTO.carColor }</div>
		            <div>${allCar.carDTO.carSize }</div>
		            <div>${allCar.carDTO.carType }</div>
		            <div>${allCar.rentCarDTO.carDistance }</div>
		            <div>${allCar.carDTO.carMade }</div>
		            <div>${allCar.carDTO.carPrice }</div>
		            <div><input type="button" class="delete_Car" onclick="delCar(this)" value="삭제"/></div>
	            </div>
            </c:forEach>
		</article>

		<!-- 수정폼 -->
		<section id="managerModifyCarForm"  class="hide">
			<div>
				<div class="title">
				<div>차량번호</div>
				<div>모델</div>
				<div>색상</div>
				<div>크기</div>
				<div>종류</div>
				<div>주행거리</div>
				<div>제조사</div>
				<div>가격</div>
	        </div>
	            
	            <div class="content">
		            <form action="${contextPath }/manager/managerCarModify.do" method="POST" onsubmit="toEnabled()">
		            		<div><input type="text" name="carNumber" disabled/></div>
				            <div><input type="text" name="carModel"/></div>
				            <div><input type="text" name="carColor"/></div>
				            <div><input type="text" name="carSize"/></div>
				            <div><input type="text" name="carType"/></div>
				            <div><input type="text" name="carDistance"/></div>
				            <div><input type="text" name="carMade"/></div>
				            <div><input type="text" name="carPrice"/></div>
				            <div><input type="submit" value="수정완료"/></div>
	           		</form>
	            </div>
           
            </div>
		</section>
	</section>
</body>
</html>