<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/web/en/common/header.jsp"/>
<script>
$(window).load(function(){
	var cate_idx="0";
	if (nullChk("${cate_idx}")!='') 
	{
		cate_idx="${cate_idx}";
	}
	goDetail(cate_idx);
});

$(document).ready(function(){
	
	$('body').addClass('sub partners');
	
	var navH = $('.nav-wr').outerHeight(true) + 50;
	$('.cont-wr').css('min-height', navH + 'px');

	$('#news_list').slick({
		autoplay: true,
		autoplaySpeed: 2000,
		speed: 1500,
		initialSlide : 1,
	});
	$('#news_list').slick('slickRemove');

	goDetail("0");
});

function goDetail(idx)
{
	$('.nav-wr .nav li a').removeClass('act');
	$('.target_'+idx).addClass('act');
	
	$.ajax({
		type : "POST", 
		url : "/partners/getPtnrdetail",
		dataType : "text",
		data : 
		{
			idx  : idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
// 			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<li><button onclick="javascript:goPtnrdetail('+result.list[i].idx+');"><img src="/upload/partners/'+result.list[i].logo_img_ori+'" alt="'+result.list[i].part_nm_en+'"/><span>'+result.list[i].part_nm_en+'</span></button></li>';
				}
			}

			$(".detail").html(inner);
		}
	});	
}

function goPtnrdetail(idx) {
	
	$(".news-cont").remove();
	
	$.ajax({
		type : "POST", 
		url : "/partners/getPtnrInfo_en",
		dataType : "text",
		data : 
		{
			idx  : idx,
			cate_idx : '${cate_idx}'
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
				
			var inner = "";
			var inner2 = "";
			var inner3 = "";
			var inner4 = "";
			var inner5 = "";
			var inner6 = "";
			
			if (nullChk(result.data)!='') 
			{								
				$('#part_nm_ko').text(result.data.part_nm_en);
				$('#corp_nm_ko').text(repWord(nullChk(result.data.corp_nm_en)));
				$('#inv_year').text(result.data.inv_year);
				
				if($('#inv_year') == '')
				{
					$('.year-cont').addClass('dis-no');
				}
				
				if(result.data.return_yn == "Y")
				{
					$('#return_yn').text("exit").show().css({'display': 'inline-block'});
				}
				else 
				{
					$('#return_yn').text("회수미완료").hide();
				}
				
				inner += '<img src="/upload/partners/'+result.data.logo_img_ori+'" alt="'+result.data.part_nm_ko+'"/>';
				$("#logo_img").html(inner);
				
				inner2 += '<a class="c-href rel" onclick="window.open(\''+result.data.url+'\')">Go to web page</a>';
				
				if(result.data.url == '준비중' || result.data.url == ''){
					$('.right-wr').addClass('no-href');
				} else {
					$('.right-wr').removeClass('no-href');
				}
				
				$("#url").html(inner2);
				
				var cate_nm = result.data.get_cate_nm
				var cate_arr = cate_nm.split(",");
				for (var i = 0; i < cate_arr.length; i++) 
				{
					inner3 += '<li class="tag-it">'+cate_arr[i]+'</li>';
				}
				$("#cate_nm").html(inner3);
				
				inner4 += '	<span class="arrow" onclick="javascript:goPtnrdetail('+result.data.before_idx+')">';
				inner4 += '		<img src="/img/popup/popup_prev.png" alt="이전"/>';
				inner4 += '	</span>';
				inner4 += '	<span class="arrow-txt">'+result.data.before_nm+'</span>';
				
				$("#prev").html(inner4);
				
				
				inner5 += '	<span class="arrow" onclick="javascript:goPtnrdetail('+result.data.after_idx+')">';
				inner5 += '		<img src="/img/popup/popup_next.png" alt="다음"/>';
				inner5 += '	</span>';
				inner5 += '	<span class="arrow-txt">'+result.data.after_nm+'</span>';
				
				$("#next").html(inner5);
				
				
			/* 	//뉴스배너                        
				if(result.news.length > 0)
				{
					$('.bot-wr').show();
					for(var i = 0; i < result.news.length; i++)
					{
						inner6 += '	<li class="news-cont">';
						inner6 += '		<a class="news-href" href="/news/detail?idx='+result.news[i].idx+'" target="_blank">';
						inner6 += '			<span class="cont">'+result.news[i].conts+'</span>';
						inner6 += '			<span class="date">'+result.news[i].submit_date2+'</span>';
						inner6 += '		</a>';
						inner6 += '	</li>';
					}
				} else {
					$('.bot-wr').hide();
				}
					
				$("#news_list").slick('slickAdd', inner6);
				$("#news_list").slick('slickGoTo', 0, true); */
				
				$('#pop_area').addClass('on');
				
			}
			else
			{
				$('#pop_area').removeClass('on');
			}
		}
	});	
 	
}



</script>
<div id="partners">
	<div class="inner">
		<!-- <div class="sub-cont"> -->
			<!-- <div class="sub-cont-inner"> -->
		<div class="sub-tit-wr">
			<jsp:include page="../../sub_common/svg_wave.jsp"/>
			<p class="sub-tit">Partners</p>
			<p class="sub-txt pc">
				We partner with bio-healthcare, deep tech and technology-enabled service companies that dream of advancing their industry and society alike with innovative solutions. <br />
				With a portfolio featuring over 90 partnered companies, we are devoted to supporting pioneering companies of all walks. At every stage of growth, we provide all the tools our partners need to realize their strategies.
			</p>
			<p class="sub-txt mo n1">
				We partner with bio-healthcare, deep tech and technology-enabled service companies that dream of advancing their industry and society alike with innovative solutions.
				With a portfolio featuring over 90 partnered companies, we are devoted to supporting pioneering companies of all walks. At every stage of growth, we provide all the tools our partners need to realize their strategies.
			</p>
			<p class="sub-txt mo n2">
			</p>
		</div>
		<!-- //sub-tit-wr -->
		
		<div class="sub-cont">
			<div class="sub-cont-inner">
				<div class="nav-wr">
					<ul class="nav">
					  <li class="nav-it"><a href="all_en" class="target_0" onclick="goDetail('0')">ALL<span class="count">${All_cnt}</span></a></li>
					  <c:forEach items="${ptnr_cate}" var="i">
			         		<li class="nav-it"><a href="/partners/all_en?cate_idx=${i.idx}" class="target_${i.idx}" onclick="goDetail('${i.idx}')">${i.cate_nm}<span class="count">${i.cate_cnt}</span></a></li>
					    </c:forEach>
					</ul>
				</div>
				<div class="cont-wr popup scroll inb">
					<ul class="inner detail">
					<!-- 	<li><button><img src="/img/logo/paytalab.png" alt="paytalab"/><span>페이타랩</span></button></li> -->
					</ul>
				</div>
			</div>
		</div>
		<!-- //sub-cont -->
	</div>	
</div>
<div class="partners-p popup-wr" id="pop_area">
	<div class="bg" onclick="javascript:document.getElementById('pop_area').classList.remove('on')"></div>
	<div class="inner">
		<div class="n ">
			<ul id="cate_nm" class="tag-wr">
				<li class="tag-it">Bio Healthcare</li>
				<li class="tag-it">Social Impact</li>
				<li class="tag-it">Other Industries</li>
			</ul>
			<!-- //tag-wr -->
			<div class="base-wr fz0">
				<div id="logo_img" class="left-wr inb">
					<img src="/img/logo/ridibooks.png" alt="logo"/>
				</div>
				<div class="right-wr inb">
					<p  id="part_nm_ko" class="c-tit">리디컴퍼니123</p>
					<p  class="c-year">
						<span class="year-tit">Year of investment</span>
						<span id="inv_year" class="year-cont">2020년, 2022년</span>
						<span id="return_yn" class="year-btn">recovered</span>
					</p>
					<p id="url" class="c-href-wr">
						<a class="c-href rel" href="#" target="_blank">Go to web page</a>
					</p>
				</div>
			</div>
			<!-- //info-wr -->
		</div>
		<!-- //top-wr -->
		<div class="mid-wr">
			<p class="info-tit popup-tit">Company overview</p>
			<p class="info-txt" id="corp_nm_ko" >국내 #1 디지털 컨텐츠 플랫폼 (전자책, 웹툰, 웹소설 등) 운용</p>
		</div>
		<!-- //mid-wr -->
<!-- 		<div class="bot-wr">
			<p class="news-tit popup-tit">Related News</p>
			<ul id="news_list" class="news-list cur-on">
 				<li class="news-cont">
					<a class="news-href" href="#">
						<span class="cont">더웰스인베스트먼트, 도시재생펀드 일반조합원 모집</span>
						<span class="date">2021.11.25</span>
					</a>
				</li> 
			</ul>
		</div> -->
		<!-- //bot-wr -->
		<button class="close abs" onclick="javascript:document.getElementById('pop_area').classList.remove('on')"><img src="/img/icon/close_btn.png" alt="close" /></button>
			<div class="arrow-wr abs">
				<button id="prev" class="arrow-ct left cf">
					<span class="arrow">
						<img src="/img/popup/popup_prev.png" alt="이전"/>
					</span>
					<span class="arrow-txt"></span>
				</button>
				<button id="next" class="arrow-ct right cf">			
					<span class="arrow">
						<img src="/img/popup/popup_next.png" alt="다음"/>
					</span>
					<span class="arrow-txt"></span>
				</button>
			</div>
	</div>
</div>
<jsp:include page="/WEB-INF/pages/web/en/common/footer.jsp"/>