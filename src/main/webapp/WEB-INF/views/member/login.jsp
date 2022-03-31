<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="static/logo/favicon.ico" type="image/x-icon" sizes="16x16">
<meta charset="UTF-8">
<title>로그인 | GetTogether</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
	
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;postion:relative;}
	.btn{color: white;}
	#brand_logo{margin:0 auto;}
	#form_container{height:70vh;width:60%; margin:0 auto; padding-top:100px;}
	#login_form>div:nth-child(5)>#btn_login{width:100%; border:1px solid #bcb1ae; background-color:#C38F5C;}
	#login_form > div:nth-child(6){text-align:center;}
	#login_form > div:nth-child(6)>a{color:#C38F5C;}
	
	
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
	function login_check(){
		
		var userid = document.getElementById('userid');
		var pw = document.getElementById("userpassword");
		if(userid.value == ""){
			alert("아이디를 입력해 주세요.");
			userid.focus();
			return false;
		}
		if(pw.value == ""){
			alert("비밀번호를 입력해 주세요.");
			pw.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<div id="wrap">
		<nav id="navbar" class="navbar navbar-expand-lg navbar-light ">
			<div id="header" class="container-fluid">
				<a id="brand_logo" class="navbar-brand" href="${url}"><img src="${url}/static/logo/horizontal_logo.png" width="200" alt=""></a>
			</div>
		</nav>
	<main id="main">
		<div id="form_container">
			<form class="center-block" id="login_form" onsubmit="return login_check();" method="post" action="${url}/member/loginOk">
				<h3 class="h3">우리끼리 Get Together!</h3>
				<h6 class="h6">지금 바로 모이세요.</h6>
				<div class="mb-3">
					<input type="text" class="form-control" name="userid" id="userid" placeholder="아이디">
				</div>
				<div class="mb-3">
					<input type="password" class="form-control" name="userpassword" id="userpassword" placeholder="비밀번호">
				</div>
				<div class="mb-3">
					<input type="submit" class="btn" id="btn_login" value="로그인">
				</div>
				<div>아이디가 없으신가요? <a href="${url}/signup">회원가입</a></div>		
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