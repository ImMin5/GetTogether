<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="${url}/static/logo/favicon.ico" type="image/x-icon" sizes="16x16">
<meta charset="UTF-8">
<title>그룹 만들기 | Get Together</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style>
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;}
	#wrap{margin:0; padding:0;}
	#wrap{width:100%;min-height: 100%;}
	#main{padding-top:20px; min-height: 100vh;}
	
	#form_container>#group_form>#groupid_label{ font-size:0.8em; padding:0.375rem 0.75rem;}
	#form_container>#group_form>div:nth-child(7){text-align:center;}
	#groupid{border:none; border-bottom:1px solid #ddd;}
	
	#thumbnail_container img,input{}
	#thumbnail_container input{}
	#thumbnail_container>#group_thumbnail{width:40%; height:30%; margin-bottom:10px; object-fit:cover;}
	#btn_make_group{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	/*반응형 스타일 적용하기*/
	/*320px ~ 600px*/
	/* all,screen, print, tv, projection... */
	@media all and (min-width:320px) and (max-width:600px) {
		#form_container{width:90%; margin:0 auto;}
	}
	/*601px~ 900px*/
	@media all and (min-width:601px) and (max-width:999px){
		#form_container{height:70vh;width:90%; margin:0 auto;}
	}
	@media all and (min-width:1000px){
		#form_container{height:70vh;width:910px;; margin:0 auto;}
	}
	
</style>
<script>
	$(document).ready(function(){
		$("#btn_cancel").on("click",function(){
			window.history.back();
		});
	});
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
	});

	function setThumbnail(event) { 
		console.log("thumnail");
		var reader = new FileReader(); reader.onload = function(event) {
			var thumbnail = document.getElementById("group_thumbnail");
			thumbnail.setAttribute("src", event.target.result);
		}; 
		reader.readAsDataURL(event.target.files[0]); 
	}
	
	function group_form_check(){
		var groupid = document.getElementById("groupid");
		var description = document.getElementById("description");
		
		if(groupid.value == ""){
			alert("그룹명을 입력해 주세요.");
			groupid.focus();
			return false;
		}
		if(description.value == ""){
			alert("설명을 간단하게 입력해 주세요!.");
			description.focus();
		}
		return true;
	}

</script>

</head>
<body>
<div class="container-fluid" id="wrap">
		<nav id="navbar" class="navbar navbar-expand-lg navbar-light">
			<div class="container-fluid">
				<a id="brand_logo" class="navbar-brand" href="${url}"><img src="${url}/static/logo/horizontal_logo.png" width="130" alt=""></a>
				<button class="navbar-toggler" id="naver_btn" type="button" data-bs-toggle="collapse" data-bs-target="#navbar_toggle" >
				<span class="navbar-toggler-icon"></span>
				</button>
				<div class="nav justify-content-end navbar-collapse collapse" id="navbar_toggle">
					<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="${url}/club/clubForm">그룹 만들기</a></li>
						<li class="nav-item"><a class="nav-link" href="mypage.html">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="${url}/member/logout">로그아웃</a></li>
					</ul>
				</div>
				
			</div>
		</nav>
	<main id="main">
		<div id="form_container">
			<form class="center-block" id="group_form" method="post" action="${url}/main/club/clubFormOk"onsubmit="return group_form_check();">
				<label id="groupid_label"><b>그룹 이름</b></label>
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="clubid" id="groupid" placeholder="그룹 이름 입력	" maxlength="20">
				</div>
				<label id="groupid_label" ><b>커버 사진</b></label>
				<div class="mb-3" id="thumbnail_container">
						<img src="${url}/static/img/thumbnail_01.jpg"  id="group_thumbnail" class="img-thumbnail" alt="...">
						<input type="file" class="form-control" name="clubthumbnail" onchange="setThumbnail(event)">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" name="description" id="description" placeholder="그룹 설명" maxlength="50">
				</div>
				<div class="mb-3">
					<input class="form-check-input" type="checkbox" name="ispublic" id="group_btn_public">
					<label class="form-check-label" >공개</label>
			  	</div>
				<div class="mb-3">
					<input type="button" class="btn btn-outline-secondary" id="btn_cancel" value="취소">
					<input type="submit" class="btn" id="btn_make_group" value="완료">
				</div>
			</form>
		</div>
	</main>
	<div id="bottombar">
	</div>
<footer class="bg-light text-center text-lg-star">
	  
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