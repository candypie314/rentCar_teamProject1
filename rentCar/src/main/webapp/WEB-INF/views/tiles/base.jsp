<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>렌트로 고고!</title>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<style>
	html, body {
		margin: 0;
		padding: 0;
		width: 100%;
		height: 100%;
	}
	
	.wrapper {
		display: flex;
		flex-direction: column;
 		align-items: center; 
 		max-width: 1200px;
 		margin: 0 auto;
		height: 100%;
	}
	.container {
		margin-top : 100px;
		flex: 1
	}
	.footer {
		width: 1200px;
	}
</style>
</head>
<body>
<div class="wrapper">
	<header>
		<tiles:insertAttribute name="header"/>
	</header>
	<div class="container">
		<tiles:insertAttribute name="body"/>
	</div>
	<div class="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>

</body>
</html>