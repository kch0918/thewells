<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
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
					inner += '<li><button onclick="javascript:goPtnrdetail('+result.list[i].idx+');"><img src="${image_dir}partners/'+result.list[i].logo_img_ori+'" alt="paytalab"/><span>'+result.list[i].part_nm_ko+'</span></button></li>';
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
		url : "/partners/getPtnrInfo",
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
				$('#part_nm_ko').text(result.data.part_nm_ko);
				$('#corp_nm_ko').text(repWord(nullChk(result.data.corp_nm_ko)));
				$('#inv_year').text(result.data.inv_year);
				
				if($('#inv_year') == '')
				{
					$('.year-cont').addClass('dis-no');
				}
				
				if(result.data.return_yn == "Y")
				{
					$('#return_yn').text("????????????").show().css({'display': 'inline-block'});
				}
				else 
				{
					$('#return_yn').text("???????????????").hide();
				}
				
				inner += '<img src="${image_dir}partners/'+result.data.logo_img_ori+'" alt="logo"/>';

				$("#logo_img").html(inner);
						
				if(result.data.url != "")
				{
					inner2 += '<a class="c-href rel" onclick="window.open(\''+result.data.url+'\')">???????????? ????????????</a>';
				}
				
				if(result.data.url == '?????????' || result.data.url == ''){
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
				inner4 += '		<img src="/img/popup/popup_prev.png" alt="??????"/>';
				inner4 += '	</span>';
				inner4 += '	<span class="arrow-txt">'+result.data.before_nm+'</span>';
				
				$("#prev").html(inner4);
				
				
				inner5 += '	<span class="arrow" onclick="javascript:goPtnrdetail('+result.data.after_idx+')">';
				inner5 += '		<img src="/img/popup/popup_next.png" alt="??????"/>';
				inner5 += '	</span>';
				inner5 += '	<span class="arrow-txt">'+result.data.after_nm+'</span>';
				
				$("#next").html(inner5);
				

				//????????????                        
				if(result.news.length > 0)
				{
					$('.bot-wr').show();
					for(var i = 0; i < result.news.length; i++)
					{
						inner6 += '	<li class="news-cont">';
						inner6 += '		<a class="news-href" onclick="window.open(\''+result.news[i].url+'\')">';
						inner6 += '			<span class="cont">'+repWord(nullChk(result.news[i].title))+'</span>';
						inner6 += '			<span class="date">'+result.news[i].submit_date2+'</span>';
						inner6 += '		</a>';
						inner6 += '	</li>';
					}
				} else {
					$('.bot-wr').hide();
				}
					
				$("#news_list").slick('slickAdd', inner6);
				$("#news_list").slick('slickGoTo', 0, true);
				
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
			<jsp:include page="../sub_common/svg_wave.jsp"/>
			<p class="sub-tit">Partners</p>
			<p class="sub-txt pc">
				????????? ????????????, ??? ??????, ????????? ???????????? ???????????? ??????????????? ????????? ????????? ????????? ????????? <br />
				?????????????????? Pre-IPO ?????? ????????? ??????????????? ???????????? ??????????????? ?????? ????????????.
			</p>
			<p class="sub-txt mo">
				????????? ????????????, ??? ??????, ????????? ????????????  <br />???????????? ??????????????? ????????? ????????? ?????????  <br />
				????????? ?????????????????? Pre-IPO <br />?????? ????????? ??????????????? ???????????? ??????????????? ?????? ????????????.
			</p>
		</div>
		<!-- //sub-tit-wr -->
		
		<div class="sub-cont">
			<div class="sub-cont-inner">
				<div class="nav-wr">
					<ul class="nav">
					  <li class="nav-it ko"><a href="all"  class="target_0" onclick="goDetail('0')">??????<span class="count"></span></a></li>
					  <c:forEach items="${ptnr_cate}" var="i">
			         		<li class="nav-it"><a href="/partners/all?cate_idx=${i.idx}" class="target_${i.idx}" onclick="goDetail('${i.idx}')">${i.cate_nm}<span class="count">${i.cate_cnt}</span></a></li>
					    </c:forEach>
					</ul>
				</div>
				<div class="cont-wr popup scroll inb">
					<ul class="inner detail">
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
					<p  id="part_nm_ko" class="c-tit">???????????????123</p>
					<p  class="c-year">
						<span class="year-tit">????????????</span>
						<span id="inv_year" class="year-cont">2020???, 2022???</span>
						<span id="return_yn" class="year-btn">????????????</span>
					</p>
					<p id="url" class="c-href-wr">
						<a class="c-href rel" href="#" target="_blank">???????????? ????????????</a>
					</p>
				</div>
			</div>
			<!-- //info-wr -->
		</div>
		<!-- //top-wr -->
		<div class="mid-wr">
			<p class="info-tit popup-tit">????????????</p>
			<p class="info-txt" id="corp_nm_ko" >?????? #1 ????????? ????????? ????????? (?????????, ??????, ????????? ???) ??????</p>
		</div>
		<!-- //mid-wr -->
		<div class="bot-wr">
			<p class="news-tit popup-tit">????????????</p>
			<ul id="news_list" class="news-list cur-on">
			</ul>
		</div>
		<!-- //bot-wr -->
		<button class="close abs" onclick="javascript:document.getElementById('pop_area').classList.remove('on')"><img src="/img/icon/close_btn.png" alt="close" /></button>
			<div class="arrow-wr abs">
				<button id="prev" class="arrow-ct left cf">
					<span class="arrow">
						<img src="/img/popup/popup_prev.png" alt="??????"/>
					</span>
					<span class="arrow-txt"></span>
				</button>
				<button id="next" class="arrow-ct right cf">			
					<span class="arrow">
						<img src="/img/popup/popup_next.png" alt="??????"/>
					</span>
					<span class="arrow-txt"></span>
				</button>
			</div>
	</div>
</div>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>