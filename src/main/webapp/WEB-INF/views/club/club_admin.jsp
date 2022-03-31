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

<style>
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;postion:relative;}
	h5{border-bottom:1px solid #C38F5C; width:40%; font-size:1.1em;}
	li{font-size:0.9em;}
	.container{padding-bottom:40px;}
	#wrap{margin:0; padding:0;}
	.bi-search, .btn{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	thead{font-size:0.9em;}
	td{word-break:break-all; font-size:0.8em;}
	#wrap{width:100%;height: 100%;}
	#navbar{}
	#main{padding-top:20px; min-height: 100%;}
	#group_thubnail{width:60%; margin:0 auto; 
		border-radius:100px;
		margin-bottom:10px;
	}
	.col-4, .rounded{text-align:center;}

	
	footer{}
	
</style>
<script>
	var flag_map = false;
	
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
	});
	
	$(document).ready(function(){
		
		//리뷰삭제
		$(document).on("click", "button[name=review_delete_btn]",function(){
			var url = "${url}/main/review/deleteOk";
			var no = $(this).attr("data-no");
			var clubno = ${cvo.no};
			$.ajax({
				url : url,
				type :"POST",
				dataType : "JSON",
				data: {
					no : no,
					clubno : clubno,
				},
				success: function(data){
					console.log(data.msg);
					console.log(data.status);
					console.log(data);
					window.location.reload();
				}
				,error: function(e){
					alert("게시물 삭제 실패");
					
				}
			});
		});
		
		//멤버 수락
		$(document).on("click", "button[name=clubmember_accept_btn]",function(){
			var url = "${url}/main/club/accept";
			var userid =$(this).attr("data-userid");
			var clubid ="${cvo.clubid}";
			var clubno =${cvo.no};
			var ivno = $(this).attr("data-no");
			
			$.ajax({
				url:url,
				type : "POST",
				dataType : "JSON",
				data : {
					userid:userid,
					clubid:clubid,
					clubno:clubno,
					ivno: ivno,
				},
				success: function(data){
					alert(data.msg);
					window.location.reload();
				},
				error: function(e){
					alert(e.msg);
				}
			});
		});
		
		//멤버 거절
		$(document).on("click", "button[name=clubmember_rejcet_btn]",function(){
			var url = "${url}/main/club/rejcet";
			var ivno = $(this).attr("data-no");
			
			$.ajax({
				url:url,
				type : "POST",
				dataType : "JSON",
				data : {
					ivno: ivno,
				},
				success: function(data){
					alert(data.msg);
					window.location.reload();
				},
				error: function(e){
					alert(e);
				}
			});
		});
		//클럽 멤버 강퇴
		$(document).on("click", "button[name=clubmember_drop_btn]", function(){
			var no = parseInt($(this).attr("data-no"));
			var clubno = parseInt("${clubno}");
			var clubadmin = "${cvo.clubadmin}";
			var userid = $(this).attr("data-userid");
			var url ="${url}/main/club/memberDelete";
			
			$.ajax({
				url : url,
				type : "POST",
				dataType: "JSON",
				data : {
					no : no,
					clubno : clubno,
					userid : userid,
					clubadmin : clubadmin,
				},
				success : function(data){
					alert(data.msg);
					window.location.reload();
				},
				error : function(e){
					alert(e.msg);
				}
			});	
		});
			
		//클럽 호스트 변경
		$(document).on("click", "button[name=clubadmin_change_btn]", function(){
			var clubno = parseInt("${clubno}");
			var clubadmin = "${cvo.clubadmin}";
			var userid = $(this).attr("data-userid");
			var username = $(this).attr("data-username");
			var url ="${url}/main/club/adminUpdate";
			
			console.log("update");
			$.ajax({
				url : url,
				type : "POST",
				dataType: "JSON",
				data : {
					clubno : clubno,
					userid : userid,
					clubadmin : clubadmin,
				},
				success : function(data){
					alert(data.msg);
					window.location.reload();
				},
				error : function(e){
					alert(e.msg);
				}
			});	
		});
	});<!-- end-->
	

	
</script>
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
	<main id="main" style="overflow:auto;">
		<div class="row">
			<div class="col-4">
				<div class="rounded mx-auto d-block" onclick="location.href='${url}/main/club/${clubno}'">
	  				<img id="group_thubnail" src="${url}/static/img/${cvo.clubthumbnail}"  alt="커버사진">
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item" >${cvo.clubid}</li>
					<li class="list-group-item">생성일 : ${cvo.createdate }</li>
					<li class="list-group-item">그룹장 : ${clubadmin}</li>
					<li class="list-group-item">인원	: ${cvo.clubmember} 명</li>
					<li class="list-group-item">리뷰 수 : ${cvo.clubpost}개</li>
					<li class="list-group-item" >
						
								<공지사항><br/>
								<c:if test="${cvo.clubnotice != null}">
									${cvo.clubnotice}
								</c:if>
					
					</li>
					
					
				</ul>
			</div>
			<div class="col-8">
				<div id="groupinfo_section" class="container">
					<h5 class="title">그룹 정보 </h5>
					<form id="groupinfo_section_form" method="post" action="${url}/main/club/editOk">
						<input type="hidden" name="no" value="${cvo.no}"/>
						<div class="input-group mb-3">
							<input type="text" class="form-control" name="clubid" value="${cvo.clubid}"/>
						</div>
						<div class="input-group mb-3">
							<input type="text" class="form-control" name="clubnotice" value="${cvo.clubnotice }" placeholder="공지사항 "/>
						</div>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<input type="submit" class="btn" name="clubid_edit_btn" value="변경"/>
						</div>
					</form>
				</div>
				<div id="member_section" class="table-responsive">
					<h5 id="member_section_title">멤버 관리 </h5>
					<table id="member_section_table" class="table ">
						<thead>
							<tr>
								<th style="min-width:30px;" scope="col">#</th>
								<th style="min-width:100px;" scope="col">아이디</th>
								<th style="min-width:100px;" scope="col">닉네임</th>
								<th style="min-width:100px;" scope="col">가입일</th>
								<th style="min-width:93px;" scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${clubmemberlist}">
							<tr>
								<td>${vo.no}</td>
								<td>${vo.userid}</td>
								<td>${vo.username}</td>
								<td>${vo.joindate}</td>
								<td>
									
									<button class="btn btn-sm" name="clubmember_drop_btn" data-no="${vo.no}" data-userid="${vo.userid}">강퇴</button>
									<button class="btn btn-sm" name="clubadmin_change_btn" data-clubadmin="${cvo.clubadmin}" data-userid="${vo.userid}" data-username="${vo.username}">양도</button>
		
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				
				<div id="post_section" class="table-responsive">
					<h5 id="post_section_title">리뷰 관리 </h5>
					<table id="postr_section_table" class="table">
						<thead>
							<tr>
								<th style="min-width:30px;" >#</th>
								<th style="min-width:100px;" >제목</th>
								<th style="min-width:90px;" >작성자</th>
								<th style="min-width:100px;" >작성일</th>
							<th style="min-width:100px;" >비고</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="vo" items="${reviewlist}">
						<tr>
								<td>${vo.no}</td>
								<td onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'">${vo.subject}</td>
								<td>${vo.username}</td>
								<td>${vo.writedate}</td>
								<td>
									<button class="btn btn-sm" data-no="${vo.no}" name="review_delete_btn">삭제</button>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				
				<!-- 그룹 가입 요청 현황 -->
				<div id="invited_section" class="table-responsive">
					<h5 id="invited_title">그룹 가입 신청 현황</h5>
					<table id="invited_section_table" class="table">
						<thead>
							<tr>
								<th style="min-width:30px;" >#</th>
								<th style="min-width:100px;" scope="col">아아디</th>
								<th style="min-width:100px;" scope="col">닉네임</th>
								<th style="min-width:100px;" scope="col">요청 시간</th>
								<th style="min-width:30px;" scope="col" style="min-width:62px;" >비고</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="vo" items="${submitlist}">
							<tr>
								<td>${vo.no}</td>
								<td>${vo.userid}</td>
								<td>${vo.username }</td>
								<td>${vo.createdate }</td>
								<td id="option_btn">
									<button name="clubmember_accept_btn" class="btn btn-sm" data-no="${vo.no}" data-userid="${vo.userid}">수락</button>
									<button name="clubmember_rejcet_btn" class="btn btn-sm" data-no="${vo.no}">거절</button>
								</td>
							</tr>						
						</c:forEach>
							
						</tbody>
					</table>
				</div>
				<!-- 그룹 초대 신청 현황 -->
				<div id="invited_section" class="table-responsive">
					<h5 id="invited_title">그룹 초대 신청 현황</h5>
					<table id="invited_section_table" class="table">
						<thead>
							<tr>
								<th style="min-width:30px;" >#</th>
								<th style="min-width:100px;">아이디</th>
								<th style="min-width:100px;">초대한 사람</th>
								<th style="min-width:100px;">요청 시간</th>								
								<th style="min-width:100px;">비고</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="vo" items="${invitelist}">
							<tr>
								<td>${vo.no}</td>
								<td>${vo.userid }</td>
								<td>${vo.username }</td>
								<td>${vo.createdate }</td>
								<td>
									<button class="btn btn-sm" disabled>대기</button>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div> <!-- col-8 end -->
		</div> <!-- row end -->
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