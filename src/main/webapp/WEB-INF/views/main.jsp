<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<c:set var="url" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="${url}/static/logo/favicon.ico" type="image/x-icon" sizes="16x16">
<meta charset="UTF-8">
<title>Get Together</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style>
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;postion:relative;}
	#wrap{margin:0; padding:0;}
	.bi-search, .btn{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	.carousel-inner{margin:0 auto;}
	.card{margin:0 auto; width:33%; max-width:600px;}
	#wrap{width:100%;min-height: 100%;}
	#navbar{}
	
	#main{padding-top:20px; min-height: 100vh;}
	#search_section{width:70%;}
	
	#main>#group_table>table{ margin:0 auto; width:95%; overflow:auto;}
	#main>#group_table thead{font-size:0.8em;}
	#main>#group_table tbody{font-size:0.8em;}
	#joined_group{height:40%; 

	}
	#joined_group>#joined_group_box{ 
	
	}
	#joined_group>#joined_gruop_box>div{float:left;}
	#main>#group_table>nav{padding-top:10px;}
	#main>#group_table>nav a {color:#C38F5C;}
	footer{}
	
	/*반응형 스타일 적용하기*/
	/*320px ~ 600px*/
	/* all,screen, print, tv, projection... */
	@media all and (min-width:320px) and (max-width:500px) {
		.card{width:50%; height:260px;}
	@media all and (min-width:501px) and (max-width:600px) {
		.card{width:33%; height:295px;}
	}
	@media all and (min-width:601px) and (max-width:700px){
		.card{width:33%; height:38vh;}
	}
	/*601px~ 900px*/
	@media all and (min-width:701px) and (max-width:900px){
		.card{width:33%; height:35vh;}
	}
	@media all and (min-width:901px){
		.card{width:33%; width:300px; }

	}
	
</style>
<script>
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
	});
	
	<!-- 검색 기능 -->
	$(document).ready(function(){
		$("#search_input").on("keyup", function() {
			var value = $(this).val().toLowerCase();
			$("tbody tr").filter(function() {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
			});
		});
		$("button[name=club_join_btn]").on("click",function(){
			var url = "${url}/main/club/submit"
			var clubno = $(this).attr("data-no");
				console.log(clubno);

			$.ajax({
				url:url,
				type:"POST",
				dataType : "JSON",
				data : {
					clubno : clubno,
				},success:function(data){
					alert(data.msg);
				}
				,error: function(e){
					alert(e.msg);
					console.log(e);
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
				<a id="brand_logo" class="navbar-brand" href="${url}"><img src="static/logo/horizontal_logo.png" width="130" alt=""></a>
				<button class="navbar-toggler" id="naver_btn" type="button" data-bs-toggle="collapse" data-bs-target="#navbar_toggle" >
				<span class="navbar-toggler-icon"></span>
				</button>
				<div class="nav justify-content-end navbar-collapse collapse" id="navbar_toggle">
					<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="${url}/main/club/clubForm">그룹 만들기</a></li>
						<li class="nav-item"><a class="nav-link" href="${url}/main/mypage">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="${url}/member/logout">로그아웃</a></li>
					</ul>
				</div>
				
			</div>
		</nav>
	<main id="main">
		<div id="search_section" class="container">
			<div class="input-group mb-3">
			    <input type="search" id="search_input" class="form-control" placeholder="검색하기"/>
			    <button type="button" class="btn"><i class="bi bi-search"></i></button>
			</div>
		</div>
		<div id="joined_group">
			<div id="carouselExampleControls" class="carousel carousel-dark slide" data-bs-ride="carousel">
			  <div class="carousel-inner">
			  <c:forEach var="vo" items="${clublist}" step="1" varStatus="status">
			  <c:if test="${status.first}"> <div class="carousel-item active"></c:if>
			  <c:if test="${!status.first}"> <div class="carousel-item"></c:if>
					<div class="card mb-3" onclick="location.href='${url}/main/club/${vo.no}'">
					  <img src="${url}/static/img/${vo.clubthumbnail}" class="card-img-top" alt="...">
					  <div class="card-body">
					    <h5 class="card-title">${vo.clubid}</h5>
					    <p class="card-text">${vo.description}</p>
					    <p class="card-text"><small class="text-muted">인원:${vo.clubmember} 리뷰:${vo.clubpost}	</small></p>
					  </div>
					</div>
			    </div>
			  </c:forEach>
			  </div><!-- inner end -->
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span style="color:black;"class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
		</div>
		<div id="group_table" class="table">
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" style="width:10%;">#</th>
			      <th scope="col" style="width:23%;">그룸 이름</th>
			      <th scope="col" style="width:20%;">설명</th>
			      <th scope="col" style="width:13%;">인원수</th>
			      <th scope="col" style="width:13%;">리뷰수</th>
			      <th scope="col" style="width:21%;">그룹 생성일</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach var="vo" items="${clublistPublic}">
			   <tr>
			  	 <th scope="row"><button class="btn btn-sm" name="club_join_btn" data-no="${vo.no}">가입</button></th>
			      <td onclick="location.href='${url}/main/club/${vo.no}'">${vo.clubid}</td>
			      <td onclick="location.href='${url}/main/club/${vo.no}'">${vo.description}</td>
			      <td>${vo.clubmember}</td>
			      <td>${vo.clubpost }개</td>
			      <td>${vo.createdate }</td>
			   </tr>
			  </c:forEach>
			  </tbody>
			</table>
			<nav>
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</nav>
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