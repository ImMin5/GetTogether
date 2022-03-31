<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="${url}/static/logo/favicon.ico" type="image/x-icon" sizes="16x16">
<meta charset="UTF-8">
<title>양재동 수제버거 맛집 | Get Together</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


<script>
	
	var is_username_check = false;
	
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
		
	});
	
	$(document).ready(function(){
		//닉네임 중복검사
		$("#username_check_btn").on('click',function(){

				var url = "${url}/member/usernameCheck";
				var username = $("#username").val();
				if(username ==""){
					alert("닉네임을 입력해 주세요.");
					return false;
				}
				else if(username == "${logId}"){
					is_username_check=true;
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
		
		$("#username").on('keyup',function(){is_username_check=false;})
	});
	
	
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
		
		if(passwd.value =="" && passwd_chk.value == ""){
			return true;
		}
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
	
	function form_check(){
		var username = $("#username");
		var userpassword = $("#userpassword");
		var new_userpassword =document.getElementById("new_userpassword");
		var new_userpassword_check =document.getElementById("new_userpassword_check");
		
		
		if(userpassword.val() == ""){
			alert("비밀번호를 입력해 주세요.");
			return false;
		}
		
		if("${logName}" != username.val() && is_username_check == false){
			console.log(username.val());
			alert("중복검사를 해주세요");
			return false;
		}
		
		if("${logName}" == username.val())
			is_username_check= true;
		if(passwd_reg(new_userpassword, new_userpassword_check) == false) return false;
	}
</script>
<style>
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;postion:relative;}
	h5{border-bottom:1px solid #C38F5C; width:40%; font-size:1.1em;}
	.container{padding-bottom:40px;}
	#wrap{margin:0; padding:0;}
	.bi-search, .btn{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	thead{font-size:0.9em;}
	td{word-break:break-all; font-size:0.8em;}
	#wrap{width:100%;height: 100%;}
	#navbar{}
	#main{padding-top:20px; min-height: 100%;}

	
	footer{}
	
</style>
</head>
<body>
<div class="container-fluid" id="wrap">
		<nav id="navbar" class="navbar navbar-expand-lg navbar-light">
			<div class="container-fluid">
				<a id="brand_logo" class="navbar-brand" href="${url}/main"><img src="${url}/static/logo/horizontal_logo.png" width="130" alt=""></a>
				<button class="navbar-toggler" id="naver_btn" type="button" data-bs-toggle="collapse" data-bs-target="#navbar_toggle" >
				<span class="navbar-toggler-icon"></span>
				</button>
				<div class="nav justify-content-end navbar-collapse collapse" id="navbar_toggle">
					<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="${url}/main/mypage">마이페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="${url}/member/logout">로그아웃</a></li>
					</ul>
				</div>
				
			</div>
		</nav>
	<main id="main">
		<div id="profile_section" class="container">
			<h5 class="title">프로필</h5>
			<form id="profile_section_form" method="post" onsubmit="return form_check();" action="${url}/main/member/editOk" >
				<div class="mb-3">
					<input type="text" class="form-control" value="${vo.userid}" readonly/>
				</div>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="username" name="username" value="${vo.username}" />
					<input type="button" class="btn" id="username_check_btn" value="중복체크"/>
				</div>
				<div class="mb-3">
					<input type="password" class="form-control" id="userpassword" name="userpassword" placeholder="비밀번호"/>
				</div>
				<div class="mb-3">
					<input type="password" class="form-control" id="new_userpassword" name="new_userpassword" placeholder="변경할 비빌먼호" value=""/>
				</div>
				<div class="mb-3">
					<input type="password" class="form-control" id="new_userpassword_check" name="new_userpassword_check" placeholder="변경할 비밀번호 확인"/>
				</div>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<input type="submit" class="btn" name="member_edit_btn" value="변경"/>
				</div>
			</form>
		</div>
		<div id="joined_section" class="container">
			<h5 id="joined_section_title">내가 가입한 그룹</h5>
			<table id="joined_section_table" class="table">
				<thead>
					<tr>
					<th>그룸명</th>
					<th>가입 날짜</th>
					<th style="min-width:62px;" >비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${clist}">
					<tr>
						<td>${vo.clubid}</td>
						<td>${vo.joindate}</td>
						<td>
							<button id="withdrawal_btn" class="btn btn-sm">탈퇴</button>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<!-- 그룹초대 요청 현황 -->
		<div id="invited_section" class="container">
			<h5 id="invited_title">그룹 초대 요청 현황</h5>
			<table id="invited_section_table" class="table">
				<thead>
					<tr>
					<th scope="col">그룸명</th>
					<th scope="col">요청 시간</th>
					<th scope="col" style="min-width:68px;" >멤버수</th>
					<th scope="col" style="min-width:68px;" >리뷰수</th>
					<th scope="col" style="min-width:62px;" >비고</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>양재동 수제버거 맛집</td>
						<td>2020.01.01 12:00:00</td>
						<td>59명</td>
						<td>12개</td>
						<td id="option_btn">
							<button class="btn btn-sm">수락</button>
							<button class="btn btn-sm">거절</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 그룹 가입 신청 현황 -->
		<div id="invited_section" class="container">
			<h5 id="invited_title">그룹 가입 신청 현황</h5>
			<table id="invited_section_table" class="table">
				<thead>
					<tr>
					<th>그룸명</th>
					<th>요청 시간</th>
					<th style="min-width:68px;">멤버수</th>
					<th style="min-width:68px;">리뷰수</th>
					<th style="min-width:62px;">비고</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>라떼가 맛있는 곳</td>
						<td>2022.01.01 12:00:00</td>
						<td>53명</td>
						<td>20개</td>
						<td>
							<button class="btn btn-sm" disabled>거절</button>
						</td>
					</tr>
					<tr>
						<td>수비스 스테이크 찾아서</td>
						<td>2022.01.02 14:00:00</td>
						<td>20명</td>
						<td>42개</td>
						<td>
							<button class="btn btn-sm" disabled>수락</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</main>
	<div id="bottombar"></div>
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