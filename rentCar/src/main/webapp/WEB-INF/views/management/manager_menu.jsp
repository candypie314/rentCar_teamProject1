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
    <title>manager header</title>
    <script src="https://kit.fontawesome.com/166dc8a7b4.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/rentCar/resources/css/header.css">
</head>

<body>
    <header>
        <div class="logo">
            <a href="#">RentLoGo</a>
        </div>
        <div>
            <a href="#">단기 렌터카</a>
            <ul>
                <li><a href="#">예약하기</a></li>
                <li><a href="#">이용안내</a></li>
            </ul>
        </div>
        <div><a href="#">공지사항</a></div>
        <div><a href="#">고객센터</a></div>
        <div class="list">
            <input type="checkbox" class="member_menu" id="member_menu" />
            <label for="member_menu" class="burger"><i class="fa-solid fa-bars"></i></label>
            <ul>
                <li><a href="${contextPath }/member/manage.do"><i class="fa fa-address-card" aria-hidden="true"></i>회원관리</a></li>
                <li><a href="#"><i class="fa fa-list-alt" aria-hidden="true"></i>예약관리</a></li>
                <li><a href="${contextPath }/manager/manageCar.do"><i class="fa fa-car" aria-hidden="true"></i>렌터카관리</a></li>
            </ul>
        </div>
    </header>
</body>
</html>