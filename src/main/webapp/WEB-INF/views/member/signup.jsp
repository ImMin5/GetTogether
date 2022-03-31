<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="static/logo/favicon.ico" type="image/x-icon" sizes="16x16">
<meta charset="UTF-8">
<title>회원가입 | GetTogether</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet"> <!-- 폰트 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"> <!-- 부트스트랩 아이콘 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;postion:relative;}
	.btn{color: white;}
	#brand_logo{margin:0 auto;}
	#form_container{height:70vh;width:75%; margin:0 auto; padding-top:100px;}
	#login_form>div:nth-child(3)>#userid_check_btn{color:white;background-color:#C38F5C;}
	#login_form>div:nth-child(4)>#username_check_btn{color:white;background-color:#C38F5C;}
	#login_form>div:nth-child(7)>#btn_signup{width:100%; border:1px solid #bcb1ae; background-color:#C38F5C;}
	#login_form>div:nth-child(7){text-align:center;}
	#login_form>div:nth-child(7)>a{ color:#C38F5C;}
	#login_form input{ font-size:0.82em;}
	
	
	/*반응형 스타일 적용하기*/
	/*320px ~ 600px*/
	/* all,screen, print, tv, projection... */
	@media all and (min-width:320px) and (max-width:600px) {
	}
	/*601px~ 900px*/
	@media all and (min-width:601px) and (max-width:999px){
		#form_container{height:70vh;width:60%; margin:0 auto; padding-top:100px;}
	}
	@media all and (min-width:1000px){
		#form_container{height:70vh;width:600px;; margin:0 auto; padding-top:100px;}
	}

</style>
<script>
	var is_check = false;
	var is_username_check = false;
	
	$(document).ready(function(){
		//id 중복검사
		$("#userid_check_btn").on('click',function(){
			if(id_reg(document.getElementById("userid")) == false){
				return;
			}
			else{
				var url = "${url}/member/idCheck";
				var userid = $("#userid").val();
				$.ajax({
					url : url,
					type : "POST",
					dataType : "JSON",
					data : {
						userid : userid 
					},success: function(data){
						if(data == "0"){
							console.log(data);
							alert("사용가능한 아이디 입니다");
							is_check=true;
						}
						else
							alert("중복된 아이디 입니다.");
							
					},error : function(){
						alert("통신오류....");
						is_check = false;
					}
				});
			}
		});
		
		
		//닉네임 중복검사
		$("#username_check_btn").on('click',function(){

				var url = "${url}/member/usernameCheck";
				var username = $("#username").val();
				if(username ==""){
					alert("닉네임을 입력해 주세요.");
					return false;
				}
				$.ajax({
					url : url,
					type : "POST",
					dataType : "JSON",
					data : {
						username : username 
					},success: function(data){
						if(data == "0"){
							console.log(data);
							alert("사용가능한 닉네임 입니다");
							is_username_check=true;
						}
						else
							alert("중복된 닉네임 입니다.");
							
					},error : function(){
						alert("통신오류....");
						is_check = false;
					}
				});
			
		});
		
		$("#userid").on('keyup',function(){is_check=false;})
		$("#username").on('keyup',function(){is_username_check=false;})
		
	});
	
	function id_reg(userid){
		var reg = /^[a-zA-Z0-9]{4,20}$/;
		
		if(userid.value==""){
			alert("아이디를 입력해 주세요.");
			userid.focus();
			return false;
		}
		if(reg.test(userid.value) == false){
			alert("아이디를 잘못 입력하였습니다.");
			userid.value="";
			userid.focus();
			return false;
		}
		
		return true;
	}
	
	function username_reg(username){
		var reg= /^[a-zA-Z0-9가-힣]{4,20}$/;
		
		if(username.value==""){
			alert("닉네임을 입력해 주세요.");
			return false;
		}
		if(reg.test(username.value) == false){
			alert("닉네임을 잘못 입력했습니다.\n 영문 대소문자, 한글 ,숫자 , 4-20자리");
			return false;
		}
	}
	
	function passwd_reg(passwd,passwd_chk){
		var reg = /[a-zA-Z0-9]{8,20}/;
		if(passwd.value==""){
			alert("비밀번호를 입력해 주세요.");
			passwd.focus();
			return false;
		}
		if(passwd.value.length<8){
			alert("비밀번호를 8자 이상 입력해 주세요!");
			passwd.focus();
			return false;
		}
		if(passwd.value != passwd_chk.value){
			alert("비밀번호가 동일하지 않습니다.");
			passwd.focus();
			return false;
		}
		if(passwd_chk.value == ""){
			alert("비밀번호를 확인해 주세요.");
			passwd_chk.focus();
			return false;
		}
		if(reg.test(passwd.value) == false){
			alert("비밀번호를 영문대소문자, 숫자 , !@* 만 사용가능.");
			passwd.focus();
			return false;
		}
		
		
		
	}
	
	function signup_check(){
		var userid = document.getElementById("userid");
		var username = document.getElementById("username");
		var passwd = document.getElementById("userpassword");
		var passwd_chk = document.getElementById("userpassword_check");
		
		
	
		if(id_reg(userid) == false) return false;
		if(passwd_reg(passwd, passwd_chk) == false) return false;
		if(username_reg(username) == false) return false;
		if(is_check == false){
			alert("아이디 중복체크를 해주세요!");
			return false;
		}
		if(is_username_check == false){
			alert("닉네임 중복체크를 해주세요!");
			return false;
		}
	}
	
	
</script>
</head>
<body>
<div id="wrap">
		<nav id="navbar" class="navbar navbar-expand-lg navbar-light ">
			<div id="header" class="container-fluid">
				<a id="brand_logo" class="navbar-brand" href="index.html"><img src="static/logo/horizontal_logo.png" width="200" alt=""></a>
			</div>
		</nav>
	<main id="main" class="container">
		<div id="form_container">
			<form class="center-block" id="login_form" method="post" onsubmit="return signup_check()" action="${url}/member/signupOk">
				<h3 class="h3">우리끼리 Get Together!</h3>
				<h6 class="h6">지금 바로 모이세요.</h6>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="userid" id="userid" placeholder="아이디">
					<input type="button" class="btn" id="userid_check_btn" value="중복체크"/>
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="username" id="username" placeholder="닉네임">
					<input type="button" class="btn" id="username_check_btn" value="중복체크"/>
				</div>
				<div class="mb-3">
					<input type="password" class="form-control" name="userpassword" id="userpassword" placeholder="비밀번호">
				</div>
				<div class="mb-3">
					<input type="password" class="form-control"  id="userpassword_check" placeholder="비밀번호 확인">
				</div>
				<div class="mb-3">
					<input type="submit" class="btn btn-primary" id="btn_signup" value="가입하기">
				</div>
				<div>이미 가입하셨나요? <a href="login.html">로그인하기</a></div>		
			</form>
		</div>
	</main>
	<div id="bottombar"></div>
		<footer id="bg-light text-center text-lg-star">
	  
	  <!-- Copyright -->
	  <div class="text-center p-3" style="background-color: #C38F5C;">
	    © 2022-<span id="footer_year"></span> Copyright:
	    <a class="text-dark" href="#">Get Together</a>
	  </div>
  	<!-- Copyright -->
	</footer>
</div>
</body>
</html>