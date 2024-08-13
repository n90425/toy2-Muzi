<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="<c:url value='/css/registerForm.css'/>" type="text/css" rel="stylesheet"/>
    <title>Signup</title>
</head>
<body>
<div class="container">
    <h2>회원가입</h2>
    <form action="/signup/add" method="post" class="signup-form">
        <p id="auth-check" class="hiddenmsg"></p>
        <div class="form-group">
            <label for="c_email">이메일 <span class="required">*</span></label>
            <input type="hidden" id="c_email" name="c_email"/>
            <input type="text" id="email" name="email" required>
            <select class="domain_list" id="domain_list" name="domain_list">
                <option disabled selected>이메일선택</option>
                <option value="@naver.com">@naver.com</option>
                <option value="@gmail.com">@gmail.com</option>
                <option value="@hanmail.net">@hanmail.net</option>
                <option value="@nate.com">@nate.com</option>
                <option value="@kakao.com">@kakao.com</option>
            </select>
        </div>
        <!-- 인증 결과를 표시할 영역 -->
        <p id="resultMessage" class="result-message hiddenmsg"></p>

        <div class="form-group">
            <label for="authCode">인증번호 <span class="required">*</span></label>
            <input type="text" id="authCode" class="authCode" name="authCode" maxlength="10" required>
            <input id="verify" type="button" value="인증번호 받기" class="verify-btn" required>
        </div>

        <!-- 비밀번호 유효성 검사 결과를 표시할 위치 -->
        <p id="password-check" class="feedback hiddenmsg"></p>
        <div class="form-group">
            <label for="c_pwd">비밀번호 <span class="required">*</span></label>
            <input type="password" id="c_pwd" name="c_pwd" required>

        </div>
        <!-- 비밀번호 일치 여부를 표시할 위치 -->
        <p id="password-match-check" class="feedback hiddenmsg"></p>
        <div class="form-group">
            <label for="c_pwd_check">비밀번호 확인 <span class="required">*</span></label>
            <input type="password" id="c_pwd_check" name="c_pwd_check" required>

        </div>
        <div class="form-group">
            <label for="c_name">이름 <span class="required">*</span></label>
            <input type="text" id="c_name" name="c_name" required>
        </div>
        <div class="form-group">
            <label for="c_nick">닉네임 <span class="required">*</span></label>
            <input type="text" id="c_nick" name="c_nick" required>
        </div>
        <div class="form-group">
            <label for="c_birth">생년월일 <span class="required">*</span></label>
            <input type="hidden" id="c_birth" name="c_birth" />
            <div class="birth-gender-group">
                <div class="birth-date-group">
                    <select id="birth_year" name="birth_year" required>
                        <option disabled selected>연</option>
                    </select>
                    <select id="birth_month" name="birth_month" required>
                        <option disabled selected>월</option>
                    </select>
                    <select id="birth_day" name="birth_day" required>
                        <option disabled selected>일</option>
                    </select>
                </div>
                <div class="gender-select-group">
                    <label for="c_gnd">성별 <span class="required">*</span></label>
                    <select class="c_gnd" id="c_gnd" name="c_gnd" required>
                        <option disabled selected>성별</option>
                        <option value="W">여</option>
                        <option value="M">남</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="c_phn">휴대폰 번호 <span class="required">*</span></label>
            <input type="text" id="c_phn" name="c_phn" required>
        </div>

        <!-- 주소 입력 부분 시작 -->
        <div class="form-group">
            <label for="c_zip">주소</label>
            <div class="address-inputs">
                <div class="zip-search">
                    <input type="text" id="c_zip" name="c_zip" placeholder="우편번호" required>
                    <input type="button" class="zip-btn" value="우편번호">
                </div>
                <input type="text" id="c_road_a" name="c_road_a" placeholder="기본주소" required>
                <input type="text" id="c_det_a" name="c_det_a" placeholder="나머지주소" required>
            </div>
        </div>
        <!-- 주소 입력 부분 끝 -->

        <button type="submit" class="submit-btn" id="submit-btn">가입하기</button>
    </form>
</div>
<script>
    let getdate = new Date();

    /* year 리스트 목록 생성여부 false */
    let isYearOption = false;
    let isMonthOption = false;

    /* 생년월일 리스트목록을 생성하는 function */
    function birthOption(selectElement, start, end){
        /* 기존옵션을 초기화 */
        selectElement.innerHTML = '';
        for(let i = start; i<=end; i++){
            const option = document.createElement('option');
            option.value=i;
            option.innerText=i;
            selectElement.appendChild(option);
        }
    }

    /* 출생연도 option 포커스되었을때 이벤트 생성*/
    document.querySelector('#birth_year').addEventListener('focus', function (){
        if(!isYearOption){
            birthOption(this, 1950, getdate.getFullYear());
            isYearOption=true;
        }
    })
    /* 출생월 option 포커스되었을때 이벤트 생성*/
    document.querySelector('#birth_month').addEventListener('focus', function(){
        if(!isMonthOption){
            birthOption(this,1,12);
            isMonthOption=true;
        }
    })
    /* 출생일 option 포커스되었을때 이벤트 생성*/
    document.querySelector('#birth_day').addEventListener('focus',function (){
        /* year 와 month의 selected value를 가져온다 */
        let year = $('#birth_year option:selected').val();
        let month = $('#birth_month option:selected').val();
        /* 값이 존재할경우 */
        if(year && month){
            /* 새로운 Date를 생성하여 선택한 마지막 일자를 가져온다 */
            const lastDay = new Date(year, month, 0).getDate();
            /* birth_day를 1일부터 마지막날짜까지 option 추가 */
            birthOption(document.querySelector('#birth_day'), 1, lastDay);
        }
    })

    /* 생년월일의 value를 저장해서 서버로 넘긴다 */
    function combineDate(){
        let birth_year = document.getElementById("birth_year").value;
        let birth_month = document.getElementById("birth_month").value;
        let birth_day = document.getElementById("birth_day").value;

        if(!(birth_year && birth_month && birth_day)){
            return null;
        }

        /* year, month, day를 문자열로 변환 */
        birth_year = birth_year.toString();
        birth_month = birth_month.toString();
        birth_day = birth_day.toString();

        /* month와 day의 길이가 1인경우 앞에 0을 붙인다 */
        if(birth_month.length===1){
            birth_month='0'+birth_month;
        }
        if(birth_day.length===1){
            birth_day='0'+birth_day;
        }

        /* year,month,day 문자열 합치기 */
        let birth_date = birth_year+birth_month+birth_day;
        /* c_birth 컬럼에 문자열 넣기 */
        document.getElementById("c_birth").value = birth_date;
        return birth_date;
    }

    /* birth_day 태그에 값이 변하면 c_birth 에 연월일 값이 저장된다 */
    document.querySelector('#birth_day').addEventListener('change', function(){
        combineDate();
    })

    /* 고객의 email 과 domain 을 합쳐서 hidden태그에 입력한다 */
    document.querySelector('#domain_list').addEventListener('change', function(){
        let email = document.getElementById("email").value.toString();
        let domain_list = document.getElementById("domain_list").value.toString();
        document.getElementById("c_email").value = email+domain_list;
    })



    $('#email').on('input', function(){
        emailCheck();
    })
    $('#domain_list').on('change', function(){
        emailCheck();
    });
    $('#authCode').on('input', function() {
        verifyNumber();
    });

    /* 이메일 중복체크 */
    function emailCheck(){
        const email = document.getElementById("email").value.trim();    //trim(): email의 양쪽 공백을 제거
        const domain = document.getElementById("domain_list").value;
        const authCheck = document.getElementById("auth-check");
        const verifyBtn = $('#verify');

        /* 이메일과 도메인을 합쳐 c_email에 저장 */
        const c_email = email + domain;

        /* email이 공백일경우 */
        if(!email){
            authCheck.style.color = "red";
            authCheck.innerHTML = "이메일을 입력해주세요";
            /* 버튼 비활성화 */
            verifyBtn.prop('disabled', true)
            return;
        }

        // const c_email = document.getElementById("c_email").value;
        var emailPattern = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

        //이메일 패턴이 유효하지 않을 경우
        if(!emailPattern.test(c_email)){
            authCheck.style.color = "red";
            authCheck.innerHTML = "이메일 형식을 다시 확인해주세요";
            /* 버튼 비활성화 */
            verifyBtn.prop('disabled', true);
            return;
        }

        //이메일 패턴이 유효할 경우
        authCheck.style.color = "green";
        authCheck.innerHTML = "인증받기를 진행해주세요.";
        /* 버튼 활성화 */
        verifyBtn.prop('disabled', false);
    }

    //비밀번호 유효성검사
    document.getElementById('c_pwd').addEventListener('input', password);
    document.getElementById('c_pwd_check').addEventListener('input', passwordmatch);

    function password(){
        const password = document.getElementById('c_pwd').value;
        const passwordcheck = document.getElementById('password-check');

        // 비밀번호 유효성 검사 (최소 8자, 대문자, 소문자, 숫자, 특수문자 포함)
        const passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$/;

        if (passwordPattern.test(password)) {
            passwordcheck.style.color = "green";
            passwordcheck.innerHTML = "비밀번호가 유효합니다.";
        }else{
            passwordcheck.style.color = "red";
            passwordcheck.innerHTML = "비밀번호는 최소 8자, 대소문자, 숫자 및 특수문자를 포함해야 합니다.";
        }
    }

    /* 비밀번호가 일치하는지 검사 */
    function passwordmatch(){
        const password = document.getElementById('c_pwd').value;
        const confirmPassword = document.getElementById('c_pwd_check').value;
        const checkpasswordmatch = document.getElementById('password-match-check');

        if(password === confirmPassword){
            checkpasswordmatch.style.color = "green";
            checkpasswordmatch.innerHTML = "비밀번호가 일치합니다."
        } else{
            checkpasswordmatch.style.color = "red";
            checkpasswordmatch.innerHTML = "비밀번호가 일치하지 않습니다."
        }
    }

    //인증번호 요청
    $('#verify').click(function() {
        const $this = $(this); // 클릭된 버튼을 jQuery 객체로 저장
        $this.prop('disabled', true); // 버튼을 비활성화

        alert('인증번호가 전송되었습니다.'); // 인증번호 전송 알림

        const email = $('#c_email').val(); // 이메일 주소값 얻어오기
        console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
        const checkInput = $('#authCode') // 인증번호 입력하는곳
        const url = '/signup/mailCheck?email=' + email; // URL 생성
        $.ajax({
            type: 'GET',
            url: url, // 생성한 URL 사용
            success: function(data) {
                console.log("data : " + data);
                checkInput.attr('disabled', false);
                code = data;
                setTimeout(function() {
                    $this.prop('disabled', false);
                }, 7000);
            }
        });
    });

    //인증번호 유효성 검사
    function verifyNumber() {
        const inputCode = $('#authCode').val().trim();

        // 인증번호가 일치하는지 확인
        if (inputCode === code) {
            $('#resultMessage').html('인증번호가 일치합니다.');
            $('#resultMessage').css('color', 'green');
            $('#verify').attr('disabled', true);
            $('#c_email').attr('readonly', true);
            return true;
        } else {
            $('#resultMessage').html('인증번호를 다시 확인해주세요');
            $('#resultMessage').css('color', 'red');
            return false;
        }
    }

</script>
</body>
</html>
