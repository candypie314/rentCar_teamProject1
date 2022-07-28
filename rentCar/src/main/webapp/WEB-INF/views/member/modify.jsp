<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<script src="/rentCar/resources/jQuery/jQuery3.6.js"></script>
<script src="/rentCar/resources/jQuery/jquery.validate.min.js"></script>
<link rel="stylesheet" href="/rentCar/resources/css/member.css">

    <script>
        $(function() {
            $.validator.addMethod("regexId", function(value, element){
                return this.optional(element) || value.match(/^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{1,}$/g);
            }, "영문과 숫자를 입력해주세요.");

            $.validator.addMethod("regexPw", function(value, element) {
                return this.optional(element) || value.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,12}$/g); 
            }, "숫자, 영문 대·소문자, 특수문자를 포함해야 합니다.");

            $.validator.addMethod("regexName", function(value, element) {
                return this.optional(element) || value.match(/^[A-Za-z가-힣]*$/); 
            }, "이름에 특수문자, 숫자는 포함할 수 없습니다.");

            $.validator.addMethod("regexPhone", function(value, element) {
                return this.optional(element) || value.match(/^[0-9]*$/); 
            }, "숫자만 입력 가능합니다.");
    
            $.validator.addMethod("regexMail", function(value, element) {
                return this.optional(element) || value.match(/^.+@.+\..+$/); 
            }, "메일 형식이 맞지 않습니다.");
            $(".memberModifyForm").validate({
                rules:{
                    memberId: {
                        required: true,
                        maxlength: 15,
                        regexId: true
                    },
                    memberPw: {
                        required: true,
                        minlength: 8,
                        maxlength: 12,
                        regexPw: true
                    },
                    checkPw: {
                    	equalTo: "#memberPw"
                    },
                    memberName: {
                        required: true,
                        maxlength: 20,
                        regexName: true
                    },
                    memberPhone: {
                        maxlength: 20,
                        regexPhone: true
                    },
                    memberEmail: {
                        required: true,
                        email: true,
                        regexMail: true
                    }

                },
                messages: {
                    memberId: {
                        required: '아이디를 입력해주세요.',
                        maxlength: '최대 15자리입니다.'
                    },
                    memberPw: {
                        required: '비밀번호를 입력해주세요.',
                        minlength: '비밀번호는 8~12자리 입니다.',
                        maxlength: '비밀번호는 8~12자리 입니다.',
                    },
                    memberName: {
                        required: '이름은 필수입니다.',
                        minlength: '최소 2글자 이상 입력해주세요.'
                    },
                    memberPhone: {
                        maxlength: '전화번호는 20자를 넘지않습니다.'
                    },
                    memberEmail: {
                        required: '이메일은 필수입니다.',
                        email: '메일 형식이 맞지 않습니다.'
                    }
                },
                errorElement: 'span',
                errorClass: 'bad',
                validClass: 'good'
            });
        });
    </script>
</head>

<body>

<form action="${contextPath }/member/memberModify.do" method="post" novalidate class="memberModifyForm">
        <fieldset>
            <div>
                <legend>회원 정보 수정</legend>
            </div>
            <div class="formWrapper">
                <div>
                    <label for="memberId">아이디</label>
                </div>
                <div>
                    <input class="textBox" type="text" id="memberId" name="memberId" placeholder="최대 15자리, 영문, 숫자">
                </div>
                <div>
                    <label for="memberPw">비밀번호</label>
                </div>
                <div>
                    <input class="textBox" type="password" id="memberPw" name="memberPw" placeholder="8~12자 숫자, 영문 대·소문자, 특수문자(!@#$%^&*)">
                </div>
                <div>
                    <label for="checkPw">비밀번호 확인</label>
                </div>
                <div>
                    <input class="textBox" type="password" id="checkPw" name="checkPw">
                </div>
                <div>
                    <label for="memberName">이름</label>
                </div>
                <div>
                    <input class="textBox" type="text" id="memberName" name="memberName">
                </div>
                <div>
                    <label for="memberBirth">생일</label>
                </div>
                <div>
                    <input type="date" class="textBox" id="memberBirth" name="memberBirth">
                </div>
                <div>
                    <label for="memberPhone">전화번호</label>
                </div>
                <div>
                    <input class="textBox" type="tel" id="memberPhone" name="memberPhone" placeholder="-제외 숫자만 입력">
                </div>
                <div>
                    <label for="memberEmail">이메일</label>
                </div>
                <div>
                    <input class="textBox" type="email" id="memberEmail" name="memberEmail">
                </div>
                <div><input type="submit" value="수정하기"></div>
                <div><input type="button" value="회원탈퇴" onclick="location='memberDeleteForm.do'"></div>
            </div>
            <input type="hidden" name="memberClass" value="1">
        </fieldset>
    </form>


</body>
</html>