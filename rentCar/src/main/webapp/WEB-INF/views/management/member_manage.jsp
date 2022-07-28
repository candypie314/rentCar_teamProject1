<%@page import="com.RentLoGo.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<script src="/rentCar/resources/jQuery/jQuery3.6.js"></script>
<script src="https://kit.fontawesome.com/166dc8a7b4.js" crossorigin="anonymous"></script>
<style>
		.memberSearchBar {
			width: 500px;
			margin-left: 65%;
			margin-bottom: 10px;
		}
		
        .memberManagement .title {
            text-align: center;
        }
        
        .memberManagement article .title {
            text-align: center;
            display: grid;
            grid-template-columns: repeat(9, 1fr);
            margin-bottom: 50px;
            border-top: 1px solid rgba(0,0,0,0.3);
            border-bottom: 1px solid rgba(0,0,0,0.3);
            line-height: 50px;
        }
        .memberManagement article .content {
        	text-align: center;
            display: grid;
            grid-template-columns: repeat(9, 1fr);
            border-bottom: 1px solid rgba(160, 52, 248, 0.8);
            line-height: 30px;
        }
        
        .memberManagement article a:hover {
        	color: red;
        }
        
        #managerModifyMemberForm {
        	position: fixed;
        	width: 100%;
        	height: 100%;
        	top: 0;
        	left: 0;
        	background-color: rgba(30, 30, 30, 0.5);
        }
        
        #managerModifyMemberForm .title {
            text-align: center;
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            margin-bottom: 50px;
            border-top: 1px solid rgba(0,0,0,0.3);
            border-bottom: 1px solid rgba(0,0,0,0.3);
            line-height: 50px;
        }
        
        #managerModifyMemberForm .content > form {
            text-align: center;
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            border-bottom: 1px solid rgba(160, 52, 248, 0.8);
            line-height: 30px;
        }
        
        #managerModifyMemberForm > div {
        	background-color: white;
        	width: 1200px;
        	height: 300px;
        	margin: 0 auto;
        	position: relative;
        	top: 50%;
        	transform: translateY(-100%);
        }
        
        #managerModifyMemberForm .content input[type="text"]{
        	width: 120px;
        	border: none;
        	background: white;
        }
        
        #managerModifyMemberForm .content input[disabled] {
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
        	
           	function delMember(e) {
            		
                let memberId = e.parentElement.parentElement.querySelector('div:first-child').textContent;
                console.log("memberId >> " + memberId);
                let xhttp = new XMLHttpRequest();
                let requestJSON = new Object();
                requestJSON.memberId = memberId;

                xhttp.open('post', "${contextPath }/managerMember/dropMember.do", true);
                xhttp.setRequestHeader('Content-type', 'application/json; charset=UTF-8;');
                xhttp.responseType = "json";
                xhttp.send(JSON.stringify(requestJSON));

                xhttp.onreadystatechange = function() {
	    			if(this.readyState == 4 && this.status == 200) {

                        let article = document.querySelector('.memberManagement article');
	    				$(article).load('${contextPath}/member/manage.do article');
	    				
		    			}
		    		}
	
           	} //delMember 함수 끝
            	
$(document).ready(function() {
            		
           		$('#searchButton').click(function() { // 검색버튼 클릭 시 회원 검색
           			
               		let inputVal = $('.inputSearch').val();
               		let selected = $('.selected').val(); // 아이디로 검색, 이름으로 검색 셀렉트 박스 선택 값
               		let jsonData = {'inputVal':inputVal, 'selected':selected};
           			console.log('클릭');
           			$.ajax({
           				type: 'POST',
           				url: '${contextPath}/managerMember/searchMember.do',
           				data: JSON.stringify(jsonData),
           				contentType : "application/json; charset=utf-8",
           				dataType: 'json',
           				success: function(jsonMemberList) {

	                        let string = '';
	
							$('.content').remove();
	                        
		                        for(let j = 0; j < jsonMemberList.length; j++) {
	                      string += '<div class="content">' +
		                                '<div><a href="javascript:void(0)" onclick="modifyMember(this)" id="modAnchor">'+jsonMemberList[j].memberId+'</a></div>' +
		                                '<div>'+jsonMemberList[j].memberPw+'</div>' +
		                                '<div>'+jsonMemberList[j].memberClass+'</div>' +
		                                '<div>'+jsonMemberList[j].memberName+'</div>' +
		                                '<div>'+jsonMemberList[j].memberBirth+'</div>' +
		                                '<div>'+jsonMemberList[j].memberPhone+'</div>' +
		                                '<div>'+jsonMemberList[j].memberEmail+'</div>' +
		                                '<div>'+jsonMemberList[j].memberDate+'</div>' +
		                                '<div><input type="button" onclick="delMember(this)" value="삭제"></div>' +
		                            '</div>';
		                            
		                        }
		                        let article = document.querySelector('.memberManagement article');
		                            article.insertAdjacentHTML('beforeend', string);
           					
           				},
           				error: function() {
							location.href='${contextPath}/member/manage.do';
           				}
           			}); // ajax 끝
           		}); //searchButton 클릭 함수 끝
           		
           		let modificationForm = document.querySelector('#managerModifyMemberForm');
		    	window.addEventListener('click',function(e) {
		    		console.log(e.target);
		    		(e.target == modificationForm) ? modificationForm.classList.add('hide') : false;
		    	});
		    	
	    	
});
           	
function toEnabled() { //수정폼 id disabled 해제
	$('#managerModifyMemberForm input[name=memberId]').attr('disabled', false);
}  	

function modifyMember(e) { // id로 검색해서 수정폼에 출력
	let id = e.childNodes[0].nodeValue;
	let jsonData = {'selected':'id', 'inputVal':id};
	
	$.ajax({
		type: 'POST',
		url: '${contextPath}/managerMember/searchMember.do',
		data: JSON.stringify(jsonData),
		contentType: "application/json; charset=utf-8",
		dataType: 'json',
		success: function(jsonMemberList) {
			let string = '';
			
			$('#managerModifyMemberForm .content').remove();
			
			string +=      '<div class="content">' +
	           '<form action="${contextPath }/managerMember/managerMemberModify.do" method="POST" onsubmit="toEnabled()">' +
	            		'<div><input type="text" name="memberId" value="'+jsonMemberList[0].memberId+'" disabled/></div>' +
			            '<div><input type="text" name="memberPw" value="'+jsonMemberList[0].memberPw+'"/></div>' +
			            '<div><input type="text" name="memberClass" value="'+jsonMemberList[0].memberClass+'"/></div>' +
			            '<div><input type="text" name="memberName" value="'+jsonMemberList[0].memberName+'"/></div>' +
			            '<div><input type="text" name="memberBirth" value="'+jsonMemberList[0].memberBirth+'"/></div>' +
			            '<div><input type="text" name="memberPhone" value="'+jsonMemberList[0].memberPhone+'"/></div>' +
			            '<div><input type="text" name="memberEmail" value="'+jsonMemberList[0].memberEmail+'"/></div>' +
			            '<div><input type="submit" value="수정완료"/></div>' +
           			'</form>' +
	            '</div>' ;
           
           let hiddenForm = document.querySelector('#managerModifyMemberForm');
           let div = document.querySelector('#managerModifyMemberForm > div');
           div.insertAdjacentHTML('beforeend', string);
           
           hiddenForm.classList.remove('hide');
		},
		error: function() {
			location.href='${contextPath}/member/manage.do';
		}
	});
}
</script>
    
</head>
<body>

	<section class="memberManagement">
		<div class="title">
			<h1>회원 관리</h1>
			<div class="memberSearchBar">
				<div class="hiddenIcon"><i class="fa-solid fa-magnifying-glass"></i></div>
				<form action="" method="post" id="memberSearchForm">
					<input type="text" class="inputSearch" name="searchInput"/>
					<select name="searchOption" class="selected">
						<option value="id">아이디</option>
						<option value="name">이름</option>
					</select>
					<input type="button" value="검색" id="searchButton"/>
				</form>
			</div>
		</div>
		<article>
			<div class="title">
				<div>아이디</div>
				<div>비밀번호</div>
				<div>회원분류</div>
				<div>이름</div>
				<div>생년월일</div>
				<div>전화번호</div>
				<div>이메일</div>
				<div>가입일자</div>
				<div></div>
            </div>
            
            <c:forEach var="member" items="${list }">
            
            <div class="content">
	            <div><a href="javascript:void(0)" onclick="modifyMember(this)" id="modAnchor">${member.memberId}</a></div>
		            <div>${member.memberPw}</div>
		            <div>${member.memberClass}</div>
		            <div>${member.memberName}</div>
		            <div>${member.memberBirth}</div>
		            <div>${member.memberPhone}</div>
		            <div>${member.memberEmail}</div>
		            <div>${member.memberDate}</div>
	            <div><input type="button" onclick="delMember(this)" value="삭제"/></div>
            </div>
            </c:forEach>
		</article>

		<section id="managerModifyMemberForm"  class="hide">
			<div>
				<div class="title">
						<div>아이디</div>
						<div>비밀번호</div>
						<div>회원분류</div>
						<div>이름</div>
						<div>생년월일</div>
						<div>전화번호</div>
						<div>이메일</div>
						<div>가입일자</div>
	            </div>
	            
	            <div class="content">
		            <form action="${contextPath }/managerMember/managerMemberModify.do" method="POST" onsubmit="toEnabled()">
		            		<div><input type="text" name="memberId" disabled/></div>
				            <div><input type="text" name="memberPw"/></div>
				            <div><input type="text" name="memberClass"/></div>
				            <div><input type="text" name="memberName"/></div>
				            <div><input type="text" name="memberBirth"/></div>
				            <div><input type="text" name="memberPhone"/></div>
				            <div><input type="text" name="memberEmail"/></div>
				            <div><input type="submit" value="수정완료"/></div>
	           		</form>
	            </div>
           
            </div>
		</section>
	</section>
</body>
</html>