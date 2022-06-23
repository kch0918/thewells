<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/web/en/common/header.jsp"/>
<script src="/js/jquery.fullPage.js"></script>
<script src="/js/musign/main.js"></script>
<link rel="stylesheet" type="text/css" href="/css/jquery.fullPage.css"/>
<script>
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
			inner += '	<img src="/upload/partners/'+result[i].logo_img_ori+'" alt="'+result[i].part_nm_en+'" />';
			inner += '	<span class="txt">'+result[i].part_nm_en+' </span>';
			inner += '</li>';
	
		}
		
		$("#left").html(inner);
		
		//파트너스 아래
		for(var j = len_2; j < result.length; j++)
		{
			inner2 += '<li class="cont-it cur-on">';       
			inner2 += '	<img src="/upload/partners/'+result[j].logo_img_ori+'" alt="'+result[j].part_nm_en+'" />';
			inner2 += '	<span class="txt">'+result[j].part_nm_en+'</span>';
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
			inner3 += '		<span class="team">'+result2[k].cate_nm_en+'</span>';
			inner3 += '		<span class="name">'+result2[k].team_nm_en+'</span>';
			inner3 += '	</span>';
			inner3 += '	<div class="img-wr">';
			inner3 += '		<img src="/upload/team/'+result2[k].team_img_ori+'" alt="The Wells Investment image" />';
			inner3 += '	</div>';
			inner3 += '</li>';
			
			$("#team_left").html(inner3);
		}
		
		//팀 가운데
		for(var l = len_4; l < len_6; l++)
		{		
			inner4 += '<li class="slide-item">';
			inner4 += '	<span class="txt-wr">';
			inner4 += '		<span class="team">'+result2[l].cate_nm_en+'</span>';
			inner4 += '		<span class="name">'+result2[l].team_nm_en+'</span>';
			inner4 += '	</span>';
			inner4 += '	<div class="img-wr">';
			inner4 += '		<img src="/upload/team/'+result2[l].team_img_ori+'" alt="The Wells Investment image" />';
			inner4 += '	</div>';
			inner4 += '</li>';
			
			$("#team_middle").html(inner4);
		}
		
		//팀 오른쪽
		for(var m = len_6; m < result2.length; m++)
		{		
			inner5 += '<li class="slide-item">';
			inner5 += '	<span class="txt-wr">';
			inner5 += '		<span class="team">'+result2[m].cate_nm_en+'</span>';
			inner5 += '		<span class="name">'+result2[m].team_nm_en+'</span>';
			inner5 += '	</span>';
			inner5 += '	<div class="img-wr">';
			inner5 += '		<img src="/upload/team/'+result2[m].team_img_ori+'" alt="The Wells Investment image" />';
			inner5 += '	</div>';
			inner5 += '</li>';
			
			$("#team_right").html(inner5);
		}
		
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
					inner += '	<img src="/upload/partners/'+result[o].logo_img_ori+'" alt="'+result[o].part_nm_en+'" />';
					inner += '	<span class="txt">'+result[o].part_nm_en+' </span>';
					inner += '</li>';
			
				}
					$("#left_mo").html(inner);
				
				//파트너스 아래
				for(var p = len_2; p < len_4; p++)
				{
					inner2 += '<li class="cont-it cur-on">';       
					inner2 += '	<img src="/upload/partners/'+result[p].logo_img_ori+'" alt="'+result[p].part_nm_en+'" />';
					inner2 += '	<span class="txt">'+result[p].part_nm_en+'</span>';
					inner2 += '</li>';
				
				}
					$("#right_mo").html(inner2);
				
				//파트너스 아래
				for(var q = len_4; q < result.length; q++)
				{
					inner3 += '<li class="cont-it cur-on">';       
					inner3 += '	<img src="/upload/partners/'+result[q].logo_img_ori+'" alt="'+result[q].part_nm_en+'" />';
					inner3 += '	<span class="txt">'+result[q].part_nm_en+'</span>';
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
					inner6 += '		<span class="team">'+result3[r].cate_nm_en+'</span>';
					inner6 += '		<span class="name">'+result3[r].team_nm_en+'</span>';
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
					inner7 += '		<span class="team">'+result3[s].cate_nm_en+'</span>';
					inner7 += '		<span class="name">'+result3[s].team_nm_en+'</span>';
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
<jsp:include page="common/contact.jsp"/>
<div id="fullpage" class="main en">
	<section class="section sec01 mian-v cur-def ani">
		<div class="inner rel">
			<div class="iframe-box">
				<!-- <img src="/img/main/pc_sec01_01.jpg" alt="The Wells Investment image" /> -->
				<video muted autoplay loop autoplay="autoplay" loop="loop" muted="muted" src="/img/main.mp4" data-autoplay playsinline> 
				   <!-- <source src="/img/main.mp4" type="video/mp4"> --> 
				</video>
			</div>
			<div class="txt-box abs">
				<p class="tit pc">We Have Found Water</p>
				<p class="tit mo">We Have <br />Found Water</p>
				<p class="txt">We strive to see our stakeholders prosper, <br />to build an investment ecosystem defined by healthy, sustainable growth.</p>
			</div>
		</div>
	</section>
	<!-- //sec01 -->
	
	<section class="section sec02 f-anchor">
		<div class="pc">
			<jsp:include page="../sub_common/svg_wave.jsp"/>
		</div>
		<div class="inner fz0">
			<div class="txt-box inb">
				<div class="t-wr">
					<p class="tit main-c pc">The Wells Investment</p>
					<p class="tit main-c mo">The Wells <br />Investment</p>
					<p class="txt pc">
						Our Venture Capital firm delivers capital, management expertise, and network support to companies that exhibit promising potential.  <br />
						Like a flowing spring, we bring sustainable life to the visions of companies and investors that seek genuinely to better society.
					</p>
					<p class="txt mo n1">
						Our Venture Capital firm delivers capital,management expertise  						
					</p>
					<p class="txt mo n2">
						and network support to companies that exhibit promising potential.
					</p>
					<p class="txt mo n3">
						Like a flowing spring, we bring sustainable life to the visions of companies and investors that seek genuinely to better society.
					</p>
				</div>
				<div class="btn-box-wr mo">
					<a class="btn-box" href="/aboutus/philosophy_en">
						<span class="line"></span>
						<span class="txt">About Us</span>
					</a>
				</div>
				<div class="mo-ver cf">
					<div class="img-wr mo"><img src="/img/main/mo_sec02_01.jpg" alt="The Wells Investment image" /></div>
					<ul class="b-wr count-box ani_view" id="counter">
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num" data-num="${achieve.year}"></strong><span class="unit"></span></span>
							<span class="sub-txt">Year Established</span>
						</li>
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num spot" data-num="${achieve.finance_en}"></strong><span class="unit">M$</span></span>
							<span class="sub-txt">AUM (Accumulated)</span>
						</li>
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num spot" data-num="${achieve.partners}"></strong><span class="unit"></span></span>
							<span class="sub-txt">Partners</span>
						</li>
						<li class="count-item cur-on">
							<span class="fir-wr"><strong class="num" data-num="${achieve.team}"></strong><span class="unit"></span></span>
							<span class="sub-txt">Investment Professionals</span>
						</li>
					</ul>
				</div>
			</div>
			<div class="img-box pc inb fz0 abs">
				<div class="btn-box-wr">
					<a class="btn-box" href="/aboutus/philosophy_en">
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
		<jsp:include page="../sub_common/svg_wave.jsp"/>
		<div class="inner">
			<div class="txt-box">
				<p class="tit pc">Innovative Partners</p>
				<p class="tit mo">Innovative <br />Partners</p>
				<p class="txt pc">
					We partner with bio-healthcare, deep tech and technology-enabled service companies that dream of advancing their industry and society alike with innovative solutions. <br />
					With a portfolio featuring over 90 partnered companies, we are devoted to supporting pioneering companies of all walks. At every stage of growth, we provide all the tools our partners need to realize their strategies.				
				</p>
				<p class="txt mo n1">
					We partner with bio-healthcare, deep tech and technology-enabled service companies that dream of advancing their industry and society alike with innovative solutions.
					With a portfolio featuring over 90 partnered companies, we are devoted to supporting pioneering companies of all walks. At every stage of growth, we provide all the tools our partners need to realize their strategies.
				</p>
				<p class="txt mo n2">
				</p>
			</div>
			<div class="btn-box-wr">
				<a class="btn-box" href="/partners/all_en">
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
				<p class="txt">
					The Wells team is defined by its professionalism and passion. <br />
					Every member brings an exceptional investment track record, storied industry experience and unique perspective to the projects we power.
				</p>
				<div class="btn-box-wr">
					<a class="btn-box" href="/team/all_en">
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
				<p class="txt">
					The Wells team is defined by its professionalism and passion. <br />
					Every member brings an exceptional investment track record, storied industry experience and unique perspective to the projects we power.
				</p>
				<div class="btn-box-wr">
					<a class="btn-box" href="/team/all_en">
						<span class="line"></span>
						<span class="txt">Team</span>
					</a>
				</div>
			</div>
		</div>
	</section>
	<!-- //sec04 -->
	<section class="section sec05 f-anchor dis-no">
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
			<ul class="news-wr">
				<c:forEach items="${news}" var="i" varStatus="loof">
					<li class="news-it n1 out-link">
						<a href="/news/detail/?idx=${i.idx}" target="_blank">
							<p class="sec-tit">News</p>
							<div class="news-cont">
								<p class="news-tit">${i.title}</p>
								<p class="news-txt">
									${i.cont}
								</p>
								<p class="news-date">${i.submit_date2}</p>
							</div>
						</a>
						<a class="to-out-link" onclick="window.open('${i.url}')"></a>
					</li>
			    </c:forEach>
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
				<div class="contact-wr">
					<button class="contact-it dis-no">Contact Us</button>
				</div>
			</div>
			<!-- //left-box -->
			<div class="right-box inb fz0">
				<ul class="anchor-wr inb">
					<li class="anchor-it n1"><a href="#about">About Us</a></li>
					<li class="anchor-it n2"><a href="#partners">Partners</a></li>
					<li class="anchor-it n3"><a href="#team">Team</a></li>
					<li class="anchor-it n4 dis-no"><a href="#news">News</a></li>
				</ul>
				<ul class="info-wr inb">
					<li class="info-it n1 ko-txt">The Wells Investment, Inc.</li>
					<li class="info-it n2 ko-txt">Address : Suite 419, 22 Teheranro87-gil, Gangnam-ku, Seoul, Korea </li>
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
