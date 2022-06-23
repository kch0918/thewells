<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<script src="/js/jquery.fullPage.js"></script>
<script src="/js/musign/main.js"></script>
<link rel="stylesheet" type="text/css" href="/css/jquery.fullPage.css"/>
<script>
$(document).ready(function(){
	// 뉴스
	var result = JSON.parse('${news}');
	var conts = "";
	for(var i = 0; i < 3; i++)
	{
		conts += '<li class="news-it out-link">';
		conts += '<a onclick="window.open(\''+result[i].url+'\')" >'; 
		conts += '<p class="sec-tit">'+result[i].cate+'</p>';
		conts += '<div class="news-cont">';
		conts += '<p class="news-tit">'+result[i].title+'</p>';
		conts += '<p id="conts'+[i+1]+'" class="news-txt"></p>';
		conts += '<p class="news-date">'+result[i].submit_date2+'</p>';
		conts += '</div>';
		conts += '</a>';
		conts += '</li>';
	}
	
	$(".news_inner").append(conts);
	$("#conts1").html(repWord(nullChk(result[0].conts)));
	$("#conts2").html(repWord(nullChk(result[1].conts)));
	$("#conts3").html(repWord(nullChk(result[2].conts)));
});

	$(function(){
		checkPosition();
		$('#header').removeClass('black');
		$('body').addClass('main');
		
		// pc일때 파트너스 배너
		var result = JSON.parse('${ptnr}');
		var len_1 = result.length/2;
		var len_2 = Math.round(len_1);
		var inner = '';
		var inner2 = '';
		
		//파트너스 위
		for(var i = 0; i < len_2; i++)
		{
			inner += '<li class="cont-it cur-on">';       
			inner += '	<img src="/upload/partners/'+result[i].logo_img_ori+'" alt="'+result[i].part_nm_ko+'" />';
			inner += '	<span class="txt">'+result[i].part_nm_ko+' </span>';
			inner += '</li>';
	
		}
		
		$("#left").html(inner);
		
		//파트너스 아래
		for(var j = len_2; j < result.length; j++)
		{
			inner2 += '<li class="cont-it cur-on">';       
			inner2 += '	<img src="/upload/partners/'+result[j].logo_img_ori+'" alt="'+result[j].part_nm_ko+'" />';
			inner2 += '	<span class="txt">'+result[j].part_nm_ko+'</span>';
			inner2 += '</li>';
		
		}
		
		$("#right").html(inner2);
		
		var result2 = JSON.parse('${team}');
		var len_3 = result2.length/3;
		var len_4 = Math.round(len_3);
		var len_5 = result2.length/1.5;
		var len_6 = Math.round(len_5);
		var inner3 = '';
		var inner4 = '';
		var inner5 = '';
		
		//팀 왼쪽
		for(var k = 0; k < len_4; k++)
		{		
			inner3 += '<li class="slide-item">';
			inner3 += '	<span class="txt-wr">';
			inner3 += '		<span class="team">'+result2[k].cate_nm+'</span>';
			inner3 += '		<span class="name">'+result2[k].team_nm_ko+'</span>';
			inner3 += '	</span>';
			inner3 += '	<div class="img-wr">';
			inner3 += '		<img src="/upload/team/'+result2[k].team_img_ori+'" alt="The Wells Investment image" />';
			inner3 += '	</div>';
			inner3 += '</li>';
			
		}
			$("#team_left").html(inner3);
		
		//팀 가운데
		for(var l = len_4; l < len_6; l++)
		{		
			inner4 += '<li class="slide-item">';
			inner4 += '	<span class="txt-wr">';
			inner4 += '		<span class="team">'+result2[l].cate_nm+'</span>';
			inner4 += '		<span class="name">'+result2[l].team_nm_ko+'</span>';
			inner4 += '	</span>';
			inner4 += '	<div class="img-wr">';
			inner4 += '		<img src="/upload/team/'+result2[l].team_img_ori+'" alt="The Wells Investment image" />';
			inner4 += '	</div>';
			inner4 += '</li>';
			
		}
			$("#team_middle").html(inner4);
		
		//팀 오른쪽
		for(var m = len_6; m < result2.length; m++)
		{		
			inner5 += '<li class="slide-item">';
			inner5 += '	<span class="txt-wr">';
			inner5 += '		<span class="team">'+result2[m].cate_nm+'</span>';
			inner5 += '		<span class="name">'+result2[m].team_nm_ko+'</span>';
			inner5 += '	</span>';
			inner5 += '	<div class="img-wr">';
			inner5 += '		<img src="/upload/team/'+result2[m].team_img_ori+'" alt="The Wells Investment image" />';
			inner5 += '	</div>';
			inner5 += '</li>';
			
		}
		
			$("#team_right").html(inner5);
		
		function checkPosition()
		{
			
		    if($(window).width() < 900)
		    {
				var result = JSON.parse('${ptnr}');
				var len_1 = result.length/3;
				var len_2 = Math.round(len_1);
				var len_3 = result.length/1.5;
				var len_4 = Math.round(len_3);
				var inner = '';
				var inner2 = '';
				var inner3 = '';
					
				//파트너스 위
				for(var o = 0; o < len_2; o++)
				{
					inner += '<li class="cont-it cur-on">';       
					inner += '	<img src="/upload/partners/'+result[o].logo_img_ori+'" alt="'+result[o].part_nm_ko+'" />';
					inner += '	<span class="txt">'+result[o].part_nm_ko+' </span>';
					inner += '</li>';
			
				}
					$("#left_mo").html(inner);
				
				//파트너스 아래
				for(var p = len_2; p < len_4; p++)
				{
					inner2 += '<li class="cont-it cur-on">';       
					inner2 += '	<img src="/upload/partners/'+result[p].logo_img_ori+'" alt="'+result[p].part_nm_ko+'" />';
					inner2 += '	<span class="txt">'+result[p].part_nm_ko+'</span>';
					inner2 += '</li>';
				
				}
					$("#right_mo").html(inner2);
				
				//파트너스 아래
				for(var q = len_4; q < result.length; q++)
				{
					inner3 += '<li class="cont-it cur-on">';       
					inner3 += '	<img src="/upload/partners/'+result[q].logo_img_ori+'" alt="'+result[q].part_nm_ko+'" />';
					inner3 += '	<span class="txt">'+result[q].part_nm_ko+'</span>';
					inner3 += '</li>';
				
				}
					$("#bottom_mo").html(inner3);
						
				var result3 = JSON.parse('${team}');
				// console.log('${team}');
				var len_7 = result3.length/2;
				var len_8 = Math.round(len_7);
				var inner6 = '';
				var inner7 = '';
				
				
				//팀 왼쪽
				for(var r = 0; r < len_7; r++)
				{		
					inner6 += '<li class="slide-item">';
					inner6 += '	<span class="txt-wr">';
					inner6 += '		<span class="team">'+result3[r].cate_nm+'</span>';
					inner6 += '		<span class="name">'+result3[r].team_nm_ko+'</span>';
					inner6 += '	</span>';
					inner6 += '	<div class="img-wr">';
					inner6 += '		<img src="/upload/team/'+result3[r].team_img_ori+'" alt="The Wells Investment image" />';
					inner6 += '	</div>';
					inner6 += '</li>';
					
				}
					$("#team_left_mo").html(inner6);

				
				//팀 오른쪽
				for(var s = len_8; s < result3.length; s++)
				{		
					inner7 += '<li class="slide-item">';
					inner7 += '	<span class="txt-wr">';
					inner7 += '		<span class="team">'+result3[s].cate_nm+'</span>';
					inner7 += '		<span class="name">'+result3[s].team_nm_ko+'</span>';
					inner7 += '	</span>';
					inner7 += '	<div class="img-wr">';
					inner7 += '		<img src="/upload/team/'+result3[s].team_img_ori+'" alt="The Wells Investment image" />';
					inner7 += '	</div>';
					inner7 += '</li>';
					
				}
					$("#team_middle_mo").html(inner7);
		    }   
		}
	
	})
</script>
<div id="fullpage" class="main">
	<section class="section sec01 mian-v cur-def ani">
		<div class="inner rel">
			<div class="iframe-box">
				<!-- <img src="/img/main/pc_sec01_01.jpg" alt="The Wells Investment image" /> -->
				<video muted autoplay loop autoplay="autoplay" loop="loop" muted="muted" src="/img/main.mp4" data-autoplay playsinline background="true"> 
				   <!-- <source src="/img/main.mp4" type="video/mp4"> --> 
				</video>
			</div>
			<div class="txt-box abs">
				<p class="tit pc">We Have Found Water</p>
				<p class="tit mo">We Have <br />Found Water</p>
				<p class="txt ko-txt">우리는 섬김의 경영, 우물자본의 철학 위에 <br />건강한 투자 생태계를 만들어 나갑니다. </p>
			</div>
		</div>
	</section>
	<!-- //sec01 -->
	
	<section class="section sec02 f-anchor">
		<div class="pc">
			<jsp:include page="sub_common/svg_wave.jsp"/>
		</div>
		<div class="inner fz0">
			<div class="txt-box inb">
				<div class="t-wr">
					<p class="tit main-c pc">The Wells Investment</p>
					<p class="tit main-c mo">The Wells <br />Investment</p>
					<p class="txt pc">
						우리는 흐르는 생수처럼 성장이 유망한 기업에 <br />
						자본, 경영노하우, 네트워크를 제공하여 투자자와 기업, 그리고 사회의 <br />
						지속가능한 번영을 추구하는 <span class="en-txt">Venture Capital</span> 입니다.
					</p>
					<p class="txt mo n1">
						우리는 흐르는 생수처럼 성장이 유망한 기업에 자본,
					</p>
					<p class="txt mo n2">
						경영노하우, 네트워크를 제공하여 투자자와 기업, 그리고
					</p>
					<p class="txt mo n3">
						사회의  지속가능한 번영을 추구하는 <span class="en-txt">Venture Capital</span> 입니다.
					</p>
				</div>
				<div class="btn-box-wr mo">
					<a class="btn-box" href="/aboutus/philosophy">
						<span class="line"></span>
						<span class="txt">About Us</span>
					</a>
				</div>
				<div class="mo-ver cf">
					<div class="img-wr mo"><img src="/img/main/mo_sec02_01.jpg" alt="The Wells Investment image" /></div>
					<ul class="b-wr count-box ani_view" id="counter">
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num" data-num="${achieve.year}"></strong><span class="unit">년</span></span>
							<span class="sub-txt">설립연도</span>
						</li>
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num spot" data-num="${achieve.finance}"></strong><span class="unit">억원</span></span>
							<span class="sub-txt">운용자산(누적)</span>
						</li>
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num spot" data-num="${achieve.partners}"></strong><span class="unit">개</span></span>
							<span class="sub-txt">파트너사</span>
						</li>
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num" data-num="${achieve.team}"></strong><span class="unit">명</span></span>
							<span class="sub-txt">투자 전문가</span>
						</li>
					</ul>
				</div>
			</div>
			<div class="img-box pc inb fz0 abs">
				<div class="btn-box-wr">
					<a class="btn-box" href="/aboutus/philosophy">
						<span class="line"></span>
						<span class="txt">About Us</span>
					</a>
				</div>
				<div class="img-wr n1 inb"><img src="/img/main/pc_sec02_01.jpg" alt="The Wells Investment image" /></div>
				<div class="img-wr n2 inb"><img src="/img/main/pc_sec02_02.jpg" alt="The Wells Investment image" /></div>
			</div>
		</div>			
	</section>
	<!-- //sec02 -->
	
	<section class="section sec03 f-anchor">
		<jsp:include page="sub_common/svg_wave.jsp"/>
		<div class="inner">
			<div class="txt-box">
				<p class="tit pc">Innovative Partners</p>
				<p class="tit mo">Innovative <br />Partners</p>
				<p class="txt pc">
					바이오헬스케어, 딥테크, IT서비스 등의 영역에서 혁신적인 솔루션으로 <br />
					산업과 사회의 변화를 꿈꾸는 다양한 성장단계의 기업들과 파트너쉽을 맺고 있습니다.						
				</p>
				<p class="txt mo n1">
					바이오헬스케어, 딥테크, IT서비스 등의 영역에서
				</p>
				<p class="txt mo n2">
					혁신적인 솔루션으로 산업과 사회의 변화를 꿈꾸는 <br /> 
				</p>
				<p class="txt mo n3">
					다양한 성장단계의 기업들과 파트너쉽을 맺고 있습니다.						
				</p>
			</div>
			<div class="btn-box-wr">
				<a class="btn-box" href="/partners/all">
					<span class="line"></span>
					<span class="txt">Partners</span>
				</a>
			</div>
			<div class="flow-box">
				<div class="pc">
					<ul id="left" class="cont-wr n1"></ul>
					<ul id="right" class="cont-wr n2" dir="rtl"></ul>
				</div>
				<div class="mo">
					<ul id="left_mo" class="cont-wr n1"></ul>
					<ul id="right_mo" class="cont-wr n2" dir="rtl"></ul> 
					<ul id="bottom_mo" id="mo" class="cont-wr n3 mo"></ul>
				</div>
			</div>
		</div>
	</section>
	<!-- //sec03 -->
	<section class="section sec04 f-anchor">
		<div class="inner fz0">
			<div class="mo-box mo right-box">
				<p class="tit">Passionate <br />Professionals</p>
				<p class="txt">탁월한 투자 실적과 다양한 <br />산업경력을 가진 열정적인 전문가들이 함께 일하고 있습니다.</p>
				<div class="btn-box-wr">
					<a class="btn-box" href="/team/all">
						<span class="line"></span>
						<span class="txt">Team</span>
					</a>
				</div>
			</div>
			<div class="left-box inb cur-on">
				<div class="pc">
					<ul id="team_left" class="teamslide teamslide1 n1">
					</ul>
					<ul id="team_middle" class="teamslide teamslide2 n2">
					</ul>
					<ul id="team_right" class="teamslide teamslide1 n3 pc">
					</ul>
				</div>
				<div class="mo">
					<ul id="team_left_mo" class="teamslide teamslide1 n1">
					</ul>
					<ul id="team_middle_mo" class="teamslide teamslide2 n2">
					</ul>
				</div>
			</div>
			<div class="right-box inb pc-box pc">
				<p class="tit">Passionate <br />Professionals</p>
				<p class="txt">탁월한 투자 실적과 다양한 <br />산업경력을 가진 열정적인 전문가들이 함께 일하고 있습니다.</p>
				<div class="btn-box-wr">
					<a class="btn-box" href="/team/all">
						<span class="line"></span>
						<span class="txt">Team</span>
					</a>
				</div>
			</div>
		</div>
	</section>
	<!-- //sec04 -->
	<section class="section sec05 f-anchor">
		<div class="inner">
			<div class="top-wr rel">
				<p class="tit">Lastest News</p>
				<div class="btn-box-wr pc">
					<a class="btn-box" href="/news/all">
						<span class="line"></span>
						<span class="txt">More</span>
					</a>
				</div>
			</div>
			<ul class="news-wr news_inner">
			</ul>
			<div class="btn-box-wr mo">
				<a class="btn-box" href="/news/all">
					<span class="line"></span>
					<span class="txt">More</span>
				</a>
			</div>
		</div>
	</section>
	<!-- //sec05 -->
	<section id="footer" class="section fp-auto-height">
		<div class="footer-wr fz0 rel">
			<div class="left-box inb">
				<div class="logo-wr">
					<img src="/img/header/footer-logo.png" alt="The Wells Investment" />
				</div>	
				<p class="copyright">ⓒTHE WELLS INVESTMENT ALL RIGHT RESERVED.</p>
				<p class="privacy"><a href="">개인정보처리방침</a></p>
				<div class="contact-wr">
					<button class="contact-it">Contact Us</button>
				</div>
			</div>
			<!-- //left-box -->
			<div class="right-box inb fz0">
				<ul class="anchor-wr inb">
					<li class="anchor-it n1"><a href="#about">About Us</a></li>
					<li class="anchor-it n2"><a href="#partners">Partners</a></li>
					<li class="anchor-it n3"><a href="#team">Team</a></li>
					<li class="anchor-it n4"><a href="#news">News</a></li>
				</ul>
				<ul class="info-wr inb">
					<li class="info-it n1 ko-txt">(주)더웰스인베스트먼트</li>
					<li class="info-it n2 ko-txt">Address : 서울시 강남구 테헤란로 87길 22 도심공항터미널 419호</li>
					<li class="info-it n3 en-txt">Contact : <a href="mailto:yshyun@investwells.com">yshyun@investwells.com</a></li>
					<li class="info-it n4 en-txt">Tel : <a href="tel:02-552-1203">+82 2 552 1203</a></li>
					<li class="info-it n5 en-txt"><a href="tel:02-552-1204">+82 2 552 1204</a></li>
				</ul>
			</div>
			<!-- //right-box -->
			<a class="top-btn-wr abs" href="#main">
				<span></span>
			</a>
		</div>	
	</section>
	
</div>
