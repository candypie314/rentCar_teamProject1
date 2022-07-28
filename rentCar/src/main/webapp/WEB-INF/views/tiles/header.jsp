<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>header</title>
    <script src="https://kit.fontawesome.com/166dc8a7b4.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/rentCar/resources/css/header.css">
</head>
<body>
    <header>
        <div class="logo">
            <a href="${contextPath }/car/indexForm.do">RentLoGo</a>
        </div>
        <div>
            <a href="#">단기 렌터카</a>
            <ul>
                <li><a href="${contextPath }/car/listCars.do">예약하기</a></li>
                <li><a href="#">이용안내</a></li>
            </ul>
        </div>
        <div><a href="${contextPath }/board/board.do">공지사항</a></div>
        <div><a href="#">고객센터</a></div>
        <div class="list">
            <input type="checkbox" class="member_menu" id="member_menu" />
            <label for="member_menu" class="burger"><i class="fa-solid fa-bars"></i></label>
            <ul>
                
                
                
                <!-- 로그인 하지 않은 상태 -->
                <c:if test="${member == null }">
                	<li><a href="${contextPath }/member/memberForm.do"><i class="fa-solid fa-plus headerIcons"></i>회원가입</a></li>
                	<li><a href="${contextPath }/member/login.do"><i class="fa-solid fa-clipboard-user headerIcons"></i>로그인</a></li>
                </c:if>
                <!-- 로그인한 상태 -->
<%--                 <c:if test="${member != null }">
                	<div class = "login_success_area">
                		<span>회원: ${member.memberId } 님 환영합니다</span>
                	</div>
                	<li><a href="${contextPath }/member/logout.do"><i class="fa-solid fa-clipboard-user headerIcons"></i>로그아웃</a></li>
                </c:if> --%>
               
               	<c:if test="${member != null }">
                	
	                <c:choose>
	                	<c:when test = "${member.memberId == 'admin' }">
	                	<li><a href="${contextPath }/manager/managerForm.do">관리자 페이지</a></li>
	                	<div class = "login_success_area">
	                		<span>관리자:${member.memberId }</span>
	                	</div>
	                	</c:when>
	                	<c:otherwise>
	                	<div class = "login_success_area">
	                		<span>회원: ${member.memberId } 님 환영합니다</span>
	                	</div>
	                	</c:otherwise>
	                </c:choose>
	                <li><a href="${contextPath }/member/logout.do"><i class="fa-solid fa-clipboard-user headerIcons"></i>로그아웃</a></li> 
                </c:if>
                
                <li><a href="#"><i class="fa-solid fa-align-right headerIcons"></i>예약정보</a></li>
                <li><a href="#"><i class="fa-solid fa-basket-shopping headerIcons"></i>장바구니</a></li>
            </ul>
        </div>
    </header>
</body>
</html>