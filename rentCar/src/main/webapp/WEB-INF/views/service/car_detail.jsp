<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>자동차 상세 페이지</title>
	<style>
        .detailedWrapper {
            display: grid;
            grid-template-areas: ;
        }
    </style>
</head>
<body>
	<div class="detailedWrapper">
        <figure>
            <img src="https://via.placeholder.com/300" alt="">
            <figcaption><img src="https://via.placeholder.com/100" alt=""></figcaption>
        </figure>
        <article class="">
            <div class="itemTitle"><h1>차 모델</h1></div>
            <div class="itemPrice">가격</div>
        </article>
        <article>
            <div class="selectDate">대여날짜</div>
            <div class="selectLocation">대여장소</div>
            <div class="buttonWraper">
                <ul>
                    <li>찜하기</li>
                    <li>결제하기</li>
                </ul>
            </div>
        </article>
    </div>
</body>
</html>