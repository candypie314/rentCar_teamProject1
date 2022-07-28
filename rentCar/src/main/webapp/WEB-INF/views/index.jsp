<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>렌트하고 축제가자!</title>
<script src="/rentCar/resources/jQuery/jQuery3.6.js"></script>

     <style>    
     html, body{
     	height: 100%;
     }
        .event {
            max-width: 1200px;
            height: 700px;
        }
        .d-block {
            display: block;
            width: 100%;
            height: 100%;
        }

        .favorites {
          max-width: 500px;
          height: 300px;
        }
        
        .favorites_outside {
        	margin: 100px auto;
        }
        
        .carousel-indicators > button {
        	visibility: hidden;
        }
        .carousel-caption {
        	font-weight: bold;
        	text-shadow: -1px 0 2px #000, 0 1px 2px #000, 1px 0 2px #000, 0 -1px 2px #000;
        }
        #congratulations {
        	background-color: rgba(29, 31, 33, 0.6);
        	width: 100%;
        	height: 100%;
        	position: fixed;
        	top: 0;
        	left: 0;
        	z-index: 999;
        	display: flex;
        	align-items: center;
        	justify-content: center;
        	visibility: hidden;
        }
        .joinFinished {
        	width: 500px;
        	height: 500px;
        	background-color: rgba(255, 255, 255, 0.8);
        	border-radius: 100px;
        	font-size: 50px;
        	text-align: center;
       	    display: flex;
		    align-items: center;
		    justify-content: center;
        }
        .modifyFinished {
        	width: 500px;
        	height: 500px;
        	background-color: rgba(255, 255, 255, 0.8);
        	border-radius: 100px;
        	font-size: 50px;
        	text-align: center;
       	    display: flex;
		    align-items: center;
		    justify-content: center;
        }
        .deleteFinished {
        	width: 500px;
        	height: 500px;
        	background-color: rgba(255, 255, 255, 0.8);
        	border-radius: 100px;
        	font-size: 50px;
        	text-align: center;
       	    display: flex;
		    align-items: center;
		    justify-content: center;
        }
        
     </style>
     
<!-- 회원가입 완료 시 -->
<c:choose>
	<c:when test="${info.joinResult == 'finished' }">
			<script>
			     $(function() {
			     	$('#congratulations').css({visibility: 'visible'});
			     	$('#congratulations').click(function() {
			     		$(this).css({visibility: 'hidden'});
			     	});
			     });
			</script>
	</c:when>
</c:choose>  

<!-- 회원정보수정 완료 시 -->   
<c:choose>
	<c:when test="${info.modifyResult == 'finished' }">
			<script>
			     $(function() {
			     	$('#congratulations').css({visibility: 'visible'});
			     	$('#congratulations').click(function() {
			     		$(this).css({visibility: 'hidden'});
			     	});
			     });
			</script>
	</c:when>
</c:choose>  

<!-- 회원탈퇴 완료 시 -->   
<c:choose>
	<c:when test="${info.deleteResult == 'finished' }">
			<script>
			     $(function() {
			     	$('#congratulations').css({visibility: 'visible'});
			     	$('#congratulations').click(function() {
			     		$(this).css({visibility: 'hidden'});
			     	});
			     });
			</script>
	</c:when>
</c:choose>  
        
</head>
<body>
    <div id="carouselExampleControls" class="carousel slide event event_outside" data-bs-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active event">
            <img src="/rentCar/resources/images/event01.png" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item active event">
            <img src="/rentCar/resources/images/event02.png" class="d-block w-100" alt="...">
          </div>
          <div class="carousel-item active event">
            <img src="/rentCar/resources/images/event03.png" class="d-block w-100" alt="...">
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
		
      <div id="carouselExampleCaptions" class="carousel slide favorites favorites_outside" data-bs-ride="false">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="3" aria-label="Slide 3"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="4" aria-label="Slide 3"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="5" aria-label="Slide 3"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="6" aria-label="Slide 3"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="7" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
        
          <c:forEach var="car" items="${list }">
	          <div class="carousel-item active favorites">
	            <img src="/rentCar/resources/images/temp/${car.carModel }.png" class="d-block w-100" alt="...">
	            <div class="carousel-caption d-none d-md-block">
	              <h5>${car.carModel }</h5>
	              <p>${car.carPrice }</p>
	            </div>
	          </div>
          </c:forEach>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>
      
<!-- 회원가입 완료 시 -->
    <c:choose>
	<c:when test="${info.joinResult == 'finished' }">
      <div id="congratulations">
      		<div class="joinFinished"><span>회원 가입을 <br/>완료하셨습니다!!</span></div>
      </div>
     </c:when>
	</c:choose>

<!-- 회원정보수정 완료 시 -->   
    <c:choose>
	<c:when test="${info.modifyResult == 'finished' }">
      <div id="congratulations">
      		<div class="modifyFinished"><span>회원 정보 수정을 <br/>완료하셨습니다!!</span></div>
      </div>
    </c:when>
	</c:choose> 
	
<!-- 회원탈퇴 완료 시 -->   
    <c:choose>
	<c:when test="${info.deleteResult == 'finished' }">
      <div id="congratulations">
      		<div class="deleteFinished"><span>회원 탈퇴를 <br/>완료하셨습니다!!</span></div>
      </div>
    </c:when>
	</c:choose> 	
	
</body>
</html>