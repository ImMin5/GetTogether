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
	li{font-size:0.9em;}
	#wrap{margin:0; padding:0;}
	.bi-search, .btn{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	td{word-break:break-all; font-size:0.8em;}
	#wrap{width:100%;height: 100%;}
	#navbar{}
	#main{padding-top:20px; min-height: 100%;}
	#search_section{width:70%;}
	#list_btn_container{text-align:center;}
	#list_btn_container>#list_btn_group>button:nth-child(1){
		border-top-left-radius:10px;
		border-bottom-left-radius:10px;
		border-right: 2px solid #ddd;
		font-size:0.8em;
	}
	#list_btn_container>#list_btn_group>button:nth-child(2){
		border-top-right-radius:10px;
		border-bottom-right-radius:10px;
		border-left: 2px solid #ddd;
		font-size:0.8em;
	
	}
	#joined_group{height:40%; margin:0 auto;}
	#info_section{padding:2%;}
	#info_section>table{ margin:0 auto; overflow-y: hidden}
	#info_section>nav{padding-top:10px;}
	#info_section> nav a {color:#C38F5C;}
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
		$(document).on('click',"#list_btn",function(){
			location.href="${url}/main/club/${cvo.no}";
		});
		
		
		$(document).on('click',"#list_map_btn",function(){
			location.href="${url}/main/club_map/${cvo.no}";
			
		});
		
		// 리뷰 작성 이동
		$(document).on("click", "#write_btn", function(){
			location.href='${url}/main/club/${cvo.no}/review_form';
		})
		
		//멤버 ㅊ대
		$(document).on("click","#modal_btn_invite", function(){
			var url = "${url}/main/club/invite"
			var userid = $("#modal_invite_userid").val();
			var clubno = ${clubno}
			
			$.ajax({
				url:url,
				type:"POST",
				dataType: "JSON",
				data:{
					userid : userid,
					clubno : clubno,
				},
				success:function(data){
					alert(data.msg);
				},
				error:function(e){
					alert(data.msg);
				}
			})
		});
		
		<!-- 검색 기능-->
		$("#search_input").on("keyup", function() {
			var value = $(this).val().toLowerCase();
			$("tbody tr").filter(function() {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
			});
		});
	});
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
					<li class="nav-item"><a class="nav-link" href="${url}/main/mypage">마이페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="${url}/member/logout">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"  data-bs-toggle="modal" data-bs-target="#modal_invite" >멤버 초대</a></li>
					<c:if test="${cvo.clubadmin == logId}">
						<li class="nav-item"><a class="nav-link" href="${url}/main/club/${cvo.no}/admin">그룹관리</a></li>
					</c:if>
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
				<div id="search_section" class="container">
					<div class="input-group mb-3">
					    <input type="search" id="search_input" class="form-control" placeholder="검색하기"/>
					    <button type="button" class="btn"><i class="bi bi-search"></i></button>
					</div>
				</div>
				<div id="list_btn_container" class="container">
					<div id="list_btn_group" class="btn-group" role="group" >
					  <button id="list_btn" type="button" class="btn">목록으로 보기</button>
					  <button id="list_map_btn" type="button" class="btn ">지도로 보기</button>
					</div>		
				</div>
	
	
				<div id="info_section" class="table-responsive">
					<table id="info_section_table" class="table">
					  <thead>
					    <tr>
					      <th scope="col" style="min-width:12px;">#</th>
					      <th scope="col" style="min-width:173px;">제목</th>
					      <th scope="col" style="min-width:122px;">위치</th>
					      <th scope="col" style="min-width:50px;">평점</th>
					      <th scope="col" style="min-width:78px;">방문일</th>
					      <th scope="col" style="min-width:80px;">작성자</th>
					      <th scope="col" style="min-width:78px;">작성일</th>
					    </tr>
					  </thead>
					  <tbody>
					  <c:forEach var="vo" items="${rvo}">
					    <tr >
					      <th scope="row" onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'" >${vo.no}</th>
					      <td  onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'" >${vo.subject}</td>
					      <td  onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'"  >${vo.location}</td>
					      <td  onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'" >${vo.score}</td>
					      <td  onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'" >${vo.visitdate}</td>
					      <td  onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'" >${vo.username}</td>
					      <td  onclick="location.href='${url}/main/club/${clubno}/review/${vo.no}'" >${vo.writedate}</td>
					    </tr>
					  </c:forEach>
					  </tbody>
					</table>
					<input id="write_btn" style="margin-top:10px; float:right;" type="button" class="btn btn-sm" value="리뷰 작성"/>
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
			</div>
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
				<input type="text" class="form-control" id="modal_invite_userid" placeholder="아이디 입력" maxlength="20">
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
        <button type="button" id="modal_btn_invite" class="btn">초대하기</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>