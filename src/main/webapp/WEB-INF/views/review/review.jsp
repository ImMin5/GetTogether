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
	li{font-size:0.9em;   list-style:none;}
	a{text-decoration:none; color:black;}
	a:hover{color:#C38F5C;}
	.col{margin:0;, padding:0;}
	#wrap{margin:0; padding:0;}
	.bi-search, .btn{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	td{word-break:break-all; font-size:0.8em;}
	#wrap{width:100%;height: 100%;}
	#navbar{}
	#main{padding-top:20px; min-height: 100%;}
	#main article{height:100%;}
	#main article>#btn_section{margin-top:10px;}
	#main article>#btn_section button{float:right; font-size:0.6em;}

	
	#main article>#review_header_section #review_title{font-size:1.2em;}
	#main article>#review_header_section #review_info {font-size:0.6em; text-align:right;}
	#group_thubnail{width:60%; margin:0 auto; 
		border-radius:100px;
		margin-bottom:10px;
	}
	.col-4, .rounded{text-align:center;}	
	#btn_next_review{margin-left:2px;}
	#reivew_section_score{float:right;}

	footer{}
		/*  별표 점수 주기*/
	.star-rating { 
		display:flex;
	  	flex-direction: row-reverse;
	  	font-size:1.5em;
	  	justify-content:space-around;
	  	padding:0 .2em;
	  	text-align:center;
	  	width:5em;
	}
	.star-rating input {display:none;}
	.star-rating label {color:#ccc;cursor:pointer;}
	.star-rating :checked ~ label {color:#C38F5C;}
	.star-rating label:hover,.star-rating label:hover ~ label {color:#C38F5C;}
</style>
<script>
	var flag_map = false;
	
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
	});
	
	$(document).ready(function(){
		console.log("인원 수 "+ ${rvo.people});
		
		$(document).on('click',"#list_btn",function(){
			location.href="group_info.html";
			if(flag_map == false) return;
			$("#info_section_map").remove();
			$("#info_section").append("<div id='info_section_table'>테이블</div>");
			flag_map = false;
		});
		
		
		$(document).on('click',"#list_map_btn",function(){
			location.href="group_info_map.html";
			if(flag_map == true) return;
			$("#info_section_table").remove();
			$("#info_section").append("<div id='info_section_map'>지도</div>");
			flag_map = true;
		});
		
		// 리뷰 작성 이동
		$(document).on("click", "#write_btn", function(){
			location.href='review_form.html';
		})
		
		// 평점 설정
		var score = parseInt(${rvo.score});
		$("#"+score+"-stars").prop("checked",true);
		
		
		//리뷰삭제	
		$(document).on("click", "#review_delete_btn",function(){
			var url = "${url}/main/review/deleteOk";
			var no = ${rvo.no}
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
					window.location.href=data.redirect;
				}
				,error: function(e){
					console.log("실패");
					console.log(e);
					window.location.href=e.redirect;
				}
			});
		});
	});
	

	
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
	<main id="main">
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
				<article class="container">
					<div id="btn_section">
						<div class="row">
							<div class="col-7"></div>
							<div class="col-5">
								<button id="btn_next_review" class="btn">이전글</button>
						  		<button class="btn">다음글</button>
						 	</div>
						 </div>
					</div>
					<div id="review_header_section" class="containe-fluid">
						<a href="${url}/main/club/${clubno}" style="font-size:0.7em;">목록으로 돌아가기</a>
						<div class="row">
							<div id="review_title" class="col-12">${rvo.subject}</div>
						</div>
						<div id="review_info" class="row">
							<div class="col-6"></div>
							<div class="col-6">${rvo.username} &nbsp&nbsp&nbsp ${rvo.writedate}<!-- Split dropend button -->
								<div class="btn-group dropend">
								  <i  class=" dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
								    <span class="visually-hidden">Toggle Dropright</span>
								  </i>
								  <c:if test="${rvo.userid == logId}">
								   <ul class="dropdown-menu">
								    <li class="dropdown-item"  onclick="location.href='${url}/main/club/${clubno}/review/${reivewno}/edit'" >수정하기</li>
								    <li class="dropdown-item" id="review_delete_btn">삭제하기</li>
								  </ul>
								 
								  
								  
								  </c:if>
								</div>
							</div>
						</div>
					</div>
					<hr/>
					<div id="review_section">
						<div> <!-- 사용자 입력 데이터  -->
							<ul class="list-group list-group-flush">
								<li >방문 인원 : ${rvo.people}</li>
								<li>재방문 의사 : 
									<c:if test="${rvo.revisit}"> 있음</c:if>
									<c:if test="${rvo.revisit == false}"> 없음</c:if>
								</li>
								<li>방문날짜 : ${rvo.visitdate } ${rvo.people} ${rvo.people}</li>
								<li>SNS링크 : <a href="${rvo.link}" target="blank">이동하기</a></li>
								<li><i class="bi bi-pin-map"></i><a href="#">${rvo.location}</a></li>
								<li id="reivew_section_score"> 
									<div class="row" style="float:left;">
										<div class="col">
											<div class="star-rating"> 
											  <input type="radio" id="5-stars" class="form-control" name="rating" value="5" />
											  <label for="5-stars" class="star">&#9733;</label>
											  <input type="radio" id="4-stars" name="rating" value="4"/>
											  <label for="4-stars" class="star">&#9733;</label>
											  <input type="radio" id="3-stars" name="rating" value="3" />
											  <label for="3-stars" class="star">&#9733;</label>
											  <input type="radio" id="2-stars" name="rating" value="2" />
											  <label for="2-stars" class="star">&#9733;</label>
											  <input type="radio" id="1-star" name="rating" value="1" />
											  <label for="1-star" class="star">&#9733;</label>
											</div>										
										</div>

									</div>
								</li>
							</ul>

						</div>
						<!-- 리뷰 내용 예시 -->
						<pre id="content" >
						 	${rvo.content }
						</pre>
					</div>
				</article>
			</div><!-- col-8 -->
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

<!-- Modal -->
<div class="modal fade" id="modal_invite" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">멤버 초대 </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="modal_userid" placeholder="아이디 입력" maxlength="20">
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn">초대하기</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>