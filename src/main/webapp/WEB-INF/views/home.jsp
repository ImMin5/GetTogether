<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="static/logo/favicon.ico" type="image/x-icon" sizes="16x16">
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet"> <!-- 폰트  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"> <!-- 부트스트랩 아이콘 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Get Together</title>
<style>
	*{font-family: 'MaruBuri';}
	ul,li{list-style-type:none;}
	body{}
	a{text-decoration:none; color:black;}
	a:visited{text-decoration:none;}
	#navbar_toggle > ul > li{
		color:black;
		margin: 0 auto;
	}

	#main>.container-fluid{padding-top : 10px;padding-botttom : 10px;}
	.card{margin:0 auto;width:90%;}

	#main{height:70%; padding-top:20px;}
	#section1{ width:90%; min-height:40%;}
	#img_section{text-align:center;}

	#login_form>div:nth-child(5)>#btn_login{width:100%; border:1px solid #bcb1ae; background-color:#C38F5C;}
	#login_form > div:nth-child(6){text-align:center;}
	#login_form > div:nth-child(6)>a{color:#C38F5C;}
	
	
	/*반응형 스타일 적용하기*/
	/*320px ~ 600px*/
	/* all,screen, print, tv, projection... */
	@media all and (min-width:320px) and (max-width:600px) {
		#img_section>#img_section_banner{width:88%; max-height:350px;float:right;}
		#login_section>#login_form{
			float:left;
			margin:0 auto;
			padding:0;
			width:95%;
			font-size:10px;
		}	
	}
	/*601px~ 900px*/
	@media all and (min-width:601px) and (max-width:900px){
		#img_section>#img_section_banner{width:75%;max-height:350px;float:right;}
		#login_section>#login_form{
		font-family: 'MaruBuri';
			float:left;
			margin:0 auto;
			padding:0;
			width:95%;
			font-size:10px;
		}	
	}
	/*901~*/
	@media all and (min-width:901px){
		#img_section>#img_section_banner{width:70%;max-height:350px;object-fit:scale-down;float:right;}
		#login_section>#login_form{
			float:left;
			margin:0 auto;
			width:90%;
			font-size:12px;
		}
		
	}
</style>
<script>
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
	});

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
	}
	
</script>
</head>
<body>
<div id="wrap">
		<nav id="navbar" class="navbar navbar-expand-lg navbar-light">
			<div id="header" class="container-fluid">
				<a id="brand_logo" class="navbar-brand" href="index.html"><img src="static/logo/horizontal_logo.png" width="130" alt=""></a>
				<button class="navbar-toggler" id="naver_btn" type="button" data-bs-toggle="collapse" data-bs-target="#navbar_toggle" >
				<span class="navbar-toggler-icon"></span>
				</button>
				<div class="nav justify-content-end navbar-collapse collapse" id="navbar_toggle">
					<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="${url}/login">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="${url}/signup">회원 가입</a></li>
					</ul>
				</div>
				
				
			</div>
		</nav>
	<main id="main">
		<div id="section1" class="container-fluid">
			<div class="row">
				<div id="img_section" class="col"><img id="img_section_banner" class="img-fluid" src="${url}/static/img/banner_03.png"/></div>
				<div id="login_section" class="col">
					<form class="center-block" id="login_form" method="post" onsubmit="return login_check();" action="${url}/member/loginOk">
					<h3 class="h3">우리끼리 Get Together!</h3>
					<h6 class="h6">지금 바로 모이세요.</h6>
					  <div class="mb-3">
					    <input type="text" class="form-control" name="userid" id="userid" placeholder="아이디">
					  </div>
					  <div class="mb-3">
					    <input type="password" class="form-control" name="userpassword" id="userpassword" placeholder="비밀번호">
					  </div>
					  <div class="mb-3">
					    <input type="submit" class="btn btn-primary" id="btn_login" value="로그인">
					  </div>
					  <div>아이디가 없으신가요? <a href="${url}/signup">회원가입</a></div>				
					</form>
				</div>
			</div>
		</div><!-- section1 end -->
		<div id="section2" class="container-fluid">
			<div class="card mb-3" >
			  <div class="row g-0">
			    <div class="col-md-4">
			      <img src="static/img/intro_01.jpg" class="img-fluid rounded-start" alt="...">
			    </div>
			    <div class="col-md-8">
			      <div class="card-body">
			        <h5 class="card-title">그룹을 만들어 맛집을 공유하세요!</h5>
			        <p class="card-text">친구, 직장 동료, 지인을 초대해 그룹을 이뤄 맛집을 공유하세요.</p>
			      </div>
			    </div>
			  </div>
			</div>
			<div class="card mb-3">
			  <div class="row g-0">
			    <div class="col-md-8">
			      <div class="card-body">
			        <h5 class="card-title">광고, 협찬으로 부터 Free</h5>
			        <p class="card-text">각종 SNS에 등장하는 광고, 협찬으로 부터 보다 투명하고 솔직한 리뷰를 공유하세요.</p>
			      </div>
			    </div>
			    <div class="col-md-4">
			      <img src="static/img/intro_02.jpg" class="img-fluid rounded-start" alt="...">
			    </div>			    
			  </div>
			</div>
			<div class="card mb-3">
			  <div class="row g-0">
			    <div class="col-md-4">
			      <img src="static/img/intro_03.jpg" class="img-fluid rounded-start" alt="...">
			    </div>
			    <div class="col-md-8">
			      <div class="card-body">
			        <h5 class="card-title">Get Together and Better Quality</h5>
			        <p class="card-text">함께 모일 수록, 공유 할 수록 만족도 높고 수준 높은 맛집 리스트 완성!</p>
			      </div>
			    </div>
			  </div>
			</div>	
		</div><!-- section2 end -->
		
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