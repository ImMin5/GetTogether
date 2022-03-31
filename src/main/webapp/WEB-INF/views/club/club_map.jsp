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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"> <!-- 부트스트랩 아이콘 -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!--  google map -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAw05Ou9RejxzFF1oBKzomAgPTwLdB8eqw&callback=initMap"></script>


<script>
	var flag_map = false;
	
	$(function(){
		$("#footer_year").text(new Date().getFullYear());
	});
	
	$(document).ready(function(){
		
		$(document).on('click',"#list_btn",function(){
			location.href="${url}/main/club/${cvo.no}";
			if(flag_map == false) return;
			$("#info_section_map").remove();
			$("#info_section").append("<div id='info_section_table'>테이블</div>");
			flag_map = false;
		});
		
		// 지도 불러오기
		$(document).on('click',"#list_map_btn",function(){
			location.href="${url}/main/club_map/${cvo.no}";
			if(flag_map == true) return;
			$("#info_section_table").remove();
			$("#info_section").append("<div id='info_section_map'>지도</div>");
			flag_map = true;
		});
		
		//지도 검색 
		$(document).on('keyup',"#search_input",function(e){
			if(e.keyCode==13){
				geocodeAddress();
			}
		});
		
		//리뷰 작성 이동
		$(document).on("click", "#write_btn", function(){
			location.href='${url}/main/club/{clubno}/reivew_form';
		})
	});
	
	//지도 검색
	function geocodeAddress(){
		var address = document.getElementById('search_input');
		if(address.value==''){
			alert("검색할 지명 또는 빌딩명을 입력하세요")	;
			address.value="";
			address.focus();
			return false;
		}
		else{
			setMapPosition(address.value,"http://www.eclipse.org", "1.jpg");
		}
	}
	
	function mapReset(review_list){
		latitude = 37.51501756622601;
		longitude = 127.07315236974777;
		
		console.log(review_list);
		
		addr = ['서울 선유도','서울 뚝섬', '서울 시청', '서울 잠실종합운동장'];
		homePage = ['https://www.nate.com','https://www.naver.com','https://www.seoul.go.kr','https://stadium.seoul.go.kr/reserve/jamsil'];
		popImg = ['01.jpg','02.png','01.jpg','02.png'];
	}
	
	//initMap
	function initMap(){
		
		mapReset();
		console.log("init");
		var mapProperties = {
				center : new google.maps.LatLng(latitude, longitude),
				zoom : 12,
				mapTypeId : google.maps.MapTypeId.ROADMAP,
				
		}
		map = new google.maps.Map(document.getElementById('info_section_map'),mapProperties);
		//GeoCoder : 지명과 건물등의 명칭을 이용하여 지도의 위도 경도를 구할 수 있다.
		geoCoder = new google.maps.Geocoder();
		console.log("review count : "+ ${rvo.size()});

		var loaction = new Array();
		var link = new Array();
		var img = new Array();
		<c:forEach var="vo" items="${rvo}">
			setMapPosition("${vo.location}", "${vo.link}", "hamburger_01.jpg", "${vo.subject}","${vo.no}");
		</c:forEach>
		
		
	}//initMap
	
	function setMapPosition(addr2,home2,pop2, subject,reviewno){
		console.log("setMapPosition");
		//마커를 표시할 주소
		geoCoder.geocode({
			'address' : addr2
		}, function(results,status){ //주소를 이용한 정보, 처리 결과
			if(status=='OK'){
				console.log(results);
				//지도의 가운데 위치를 새로 셋팅
				map.setCenter(results[0].geometry.location);
				
				//마커표시
				var marker = new google.maps.Marker({
					map:map,
					//icon :
					title:results[0].formatted_address,
					position : results[0].geometry.location
				});
				var la = results[0]['geometry']['location']['lat'](); //위도
				var lo = results[0]['geometry']['location']['lng'](); //경도
				
				var title = "<a href='${url}/main/club/${clubno}/review/"+reviewno+"'>"+subject+"</a>"
				var popMsg = "제목 : " + title;
				popMsg += "<br/> SNS : " + "<a href='"+home2+"' target='_blnak'>"+home2+"</a>";
				popMsg += "<br/> 주소 :" + results[0].formatted_address;
				popMsg += "<br/> <a href='"+home2+"' target='_blnak'><img src='${url}/static/img/hamburger_02.jpg' width='100' height='50'/></a>";
				
				var info = new google.maps.InfoWindow({content:popMsg});
				
				//이벤트에 의하여 대화상자 보여지도록 설정
				google.maps.event.addListener(marker, 'click', function(){
					info.open(map,marker);
				});
				

			}else{
				console.log("존재하지 않는 주소 입니다.");
			}
		});//geoCoder.geocode
	}
</script>
<style>
	*{font-family: 'MaruBuri';}
	html,body{height:100vh;postion:relative;}
	li{font-size:0.9em;}
	#wrap{margin:0; padding:0;}
	.bi-search, .btn{border: 1px solid #C38F5C; color:white; background-color:#C38F5C;}
	.carousel-inner{margin:0 auto;}
	.card{float:left;width:29%;;margin:3% 2% 3% 2%; }
	#wrap{width:100%;min-height: 100%;}
	#navbar{}
	#main{padding-top:20px; height: 100vh;}
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
	#info_section{padding-top:10px;}
	#info_section_map{width:100%; height:70vh; border:1px solid gray;}
	#joined_group{height:40%; margin:0 auto;}
	#group_thubnail{width:60%; margin:0 auto; 
		border-radius:100px;
		margin-bottom:10px;
	}
	.col-4, .rounded{text-align:center;}
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
						<li class="nav-item"><a class="nav-link"  data-bs-toggle="modal" data-bs-target="#modal_invite" >멤버 초대</a></li>
						<li class="nav-item"><a class="nav-link" href="${url}/main/club/${cvo.no}/admin">그룹관리</a></li>
					</ul>
				</div>
				
			</div>
		</nav>
	<main id="main">
		<div class="row">
			<div class="col-4">
				<div class="rounded mx-auto d-block" onclick="location.href='${url}/main/club_map/${clubno}'">
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
					    <button type="button" class="btn" onclick="geocodeAddress()"><i class="bi bi-search"></i></button>
					</div>
				</div>
				<div id="list_btn_container" class="container">
					<div id="list_btn_group" class="btn-group" role="group" >
					  <button id="list_btn" type="button" class="btn">목록으로 보기</button>
					  <button id="list_map_btn" type="button" class="btn">지도로 보기</button>
					</div>		
				</div>
				<div id="info_section" class="container">
					<div id="info_section_map" class="container">
					</div>
					<input id="write_btn" style="margin-top:10px; float:right;" type="button" class="btn btn-sm" value="리뷰 작성"/>
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