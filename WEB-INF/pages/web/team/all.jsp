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

function goDetail(idx)
{
	$('.nav-wr .nav li a').removeClass('act');
	$('.target_'+idx).addClass('act');
	
	$.ajax({
		type : "POST", 
		url : "/team/getTeamdetail",
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
			// console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<li class="team-item cur-on" onclick="javascript:goTeamdetail('+result.list[i].idx+');">';
					inner += '<div class="img-wr">';
					inner += '<img src="${image_dir}team/'+result.list[i].thumb_img_ori+'" alt="The Wells Investment image">';
					inner += '</div>';
					inner += '<div class="txt-wr">';
					inner += '<p class="name">'+result.list[i].team_nm_ko+'</p>';
					inner += '<p class="team-en">'+result.list[i].level_ko+'</p>';
					inner += '<p class="team-ko">'+result.list[i].cate_nm+'</p>';
					inner += '</div>';
					inner += '</li>';
				}
			}

			$(".team-wr").html(inner);
		}
	});	
}

function goTeamdetail(idx) {
	
	$.ajax({
		type : "POST", 
		url : "/team/getTeamInfo",
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
			// console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			var inner2 = "";
			var inner3 = "";
			var inner4 = "";
			var inner5 = "";
			if (nullChk(result.data)!='') 
			{	
				if(result.data.intro_ko == "")
				{
					$('#tag_team_nm_ko').text("");
				}
				else
				{
					$('#tag_team_nm_ko').text("#" + result.data.intro_ko);
				}
				
				$('#team_img').text(result.data.inv_year);
				
				inner += '<img src="${image_dir}team/'+result.data.team_img_ori+'" alt="profile"/>';
				
				$("#team_img").html(inner);

				$('#team_nm_ko').text(result.data.team_nm_ko);
				$('#level_en').text(result.data.level_ko);
				$('#level_ko').text(result.data.cate_nm);
				
				
				var arr = result.data.career_ko.split('<br>');
				
				for (var i = 0; i < arr.length; i++) {
					
					inner4 += '<p class="txt">'+arr[i]+'</p>';
				}
				
				$('#career_ko').html(inner4);
								
				var arr2 = result.data.edu_ko.split('<br>');
				
				for (var i = 0; i < arr2.length; i++) {
					
					inner5 += '<p class="txt">'+arr2[i]+'</p>';
				}
				
				$('#edu_ko').html(inner5);
				
				
				inner2 += '	<span class="arrow" onclick="javascript:goTeamdetail('+result.data.before_idx+')">';
				inner2 += '		<img src="/img/popup/popup_prev.png" alt="이전"/>';
				inner2 += '	</span>';
				inner2 += '	<span class="arrow-txt">'+result.data.before_nm+'</span>';
				
				$("#prev").html(inner2);
				
				inner3 += '	<span class="arrow" onclick="javascript:goTeamdetail('+result.data.after_idx+')">';
				inner3 += '		<img src="/img/popup/popup_next.png" alt="다음"/>';
				inner3 += '	</span>';
				inner3 += '	<span class="arrow-txt">'+result.data.after_nm+'</span>';
				
				$("#next").html(inner3);
				
				
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
<div id="team">
	<div class="inner">
		<!-- <div class="sub-cont"> -->
			<!-- <div class="sub-cont-inner"> -->
		<div class="sub-tit-wr">
			<jsp:include page="../sub_common/svg_wave.jsp"/>
			<p class="sub-tit">Team</p>
			<p class="sub-txt">
				탁월한 투자 실적과, 다양한 산업분야의 경력을 가진 <br />
				열정적인 전문가들이 함께 일하고 있습니다.
			</p>
		</div>
		<!-- //sub-tit-wr -->
		<div class="sub-cont">
			<div class="sub-cont-inner">
				<div class="nav-wr">
				         <ul class="nav">
						    <li class="nav-it ko n1"><a href="all" class="target_0" onclick="goDetail('0')">전체<span class="count">${All_cnt}</span></a></li>
						    <c:forEach items="${team_cate}" var="i">
				         		<li class="nav-it ko n1"><a href="/team/all?cate_idx=${i.idx}" class="target_${i.idx}" onclick="goDetail('${i.idx}')">${i.cate_nm}<span class="count">${i.cate_cnt}</span></a></li>
						    </c:forEach>
						</ul>
				</div>
				<div class="cont-wr inb">
					<ul class="team-wr">
						<!-- <li class="team-item cur-on">
							<div class="img-wr">
								<img src="/img/main/pc_sec04_11.png" alt="The Wells Investment image">
							</div>
							<div class="txt-wr">
								<p class="name">이소진</p>
								<p class="team-en">Chairman & CEO</p>
								<p class="team-ko">경영진</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- //sub-cont -->
	</div>	
</div>
<div class="partners-p popup-wr"  id="pop_area">
	<div class="bg" onclick="javascript:document.getElementById('pop_area').classList.remove('on')"></div>
	<div class="inner fz0 d">
		<div class="left-wr">
			<div class="tag-box">
				<span id="tag_team_nm_ko" class="tag">#김철수</span>
				<!-- <span id="tag_level_ko" class="tag">#CEO</span> -->
			</div>
			<div id="team_img" class="img-box">
				<img src="/img/main/pc_sec04_11.png" alt="profile" />
			</div>
		</div><!-- //left-wr -->
		<div class="right-wr scroll">
			<div class="name-box">
				<p id="team_nm_ko" class="tit">김철수</p>
				<p id="level_en" class="txt">Chairman & CEO</p>
				<p id="level_ko" class="txt">경영진</p>
			</div>
			<div class="career-box dot">
				<p class="tit n-d">경력</p>
				<p id="career_ko" class="n-d"/>
			</div>
			<div class="educa-box dot">
				<p class="tit n-d">학력</p>
				<p id="edu_ko" class="n-d">MA, Commerce, Graduate School of Commerce,</p>
			</div>
		</div><!-- //right-wr -->
		<button class="close abs" onclick="javascript:document.getElementById('pop_area').classList.remove('on')"><img src="/img/icon/close_btn.png" alt="close" /></button>
		<div class="arrow-wr abs">
			<button id="prev" class="arrow-ct left cf">
				<span class="arrow">
					<img src="/img/popup/popup_prev.png" alt="이전"/>
				</span>
				<span class="arrow-txt"></span>
			</button>
			<button id="next" class="arrow-ct right cf">			
				<span  class="arrow">
					<img src="/img/popup/popup_next.png" alt="다음"/>
				</span>
				<span class="arrow-txt"></span>
			</button>
		</div>
	</div>
</div>
<script>
	$('body').addClass('sub team popup');
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>