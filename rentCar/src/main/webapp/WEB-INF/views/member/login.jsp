<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="/rentCar/resources/jQuery/jQuery3.6.js"></script>
<link rel="stylesheet" href="/rentCar/resources/css/member.css">
<script src="/rentCar/resources/js/kakaoSDK.js"></script>
<style>
	#login_form {
		text-align: center;
	}
	.login_button {
		margin-top: 10px;
	}
	.kakaoLoginButton {
		border: none;
		background-color: white;
	}
	
	.kakaoLoginButton img {
		width: 150px;
	}
</style>
<script>
window.onload = function() {
	
	let kakaoLoginButton = document.querySelector('.login_wrap .kakaoLoginButton');
	
	/* 자바스크립트로 카카오 로그인 정보 받기
	Kakao.init('9dbfc7a6bff2cfcd881815feed3ea0d6');
	
	kakaoLoginButton.addEventListener('click', function() {
		
		Kakao.Auth.login({ // 추가로 동의받을 항목
			
		    scope: 'account_email',
		    success: function(response) {
		        console.log(response);
		        
		        Kakao.API.request({ // 사용자 정보 가져오기
		        	 url: '/v2/user/me',
		        	 data: { // 사용자의 특정 정보만 지정해서 가져올 때 사용
		        		 property_keys: ["kakao_account.email", "kakao_account.profile"]
		        	 },
		        	 success: function(response) {
		        		 let id = response.id;
		        		 let name = response.kakao_account.profile;
		        		 let email = response.kakao_account.email;
		        	 }
		        }); // Kakao.API.request 끝
		       
		    }, // login success
		    fail: function(error) {
		        console.log(error);
		    } // login fail
		    
		}); // 인증 로그인 메서드 끝
		
	}); // 카카오로그인 버튼 클릭 이벤트 끝
	*/
	
	kakaoLoginButton.addEventListener('click', function() {
		
		let xhttp = new XMLHttpRequest();
		
		xhttp.open('get', "${contextPath}/member/kakaoAuth.do", true);
		xhttp.responseType = "text";
		xhttp.send();
		
		xhttp.onreadystatechange = function() {
			
			if(this.readyState == 4 && this.status == 200) {
				let url = this.response;
				location.href = url;
			}
			
		}
		
	});
	
}

</script>
</head>
<body>

		<form id="login_form" action="${contextPath }/member/memberLogin.do" method="post" class="loginForm">
			<fieldset>
			<legend><span>Rent Car</span></legend>
				<div class="wrap">
					<div class="login_wrap">
							<div class="id_input_box">
								<input class="id_input" name="memberId" placeholder="ID">
							</div>
						<div class="pw_wrap">
								<input type="password" class="pw_iput" name="memberPw" placeholder="Password">
						</div>
						<c:if test="${result == 0 }">
							<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
						</c:if>
						<div>
							<input class="login_button" type="submit" value="로그인">
						</div>
						<div>
							<button type="button" class="kakaoLoginButton"><img alt="" src="/rentCar/resources/images/kakao_login.png"></button>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
		
</body>
</html>