<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<script type="text/javascript" src="/js/function.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="/js/function.js"></script>
<script>
$(window).load(function(){
	var cate_idx="0";
	if (nullChk("${cate_idx}")!='') 
	{
		cate_idx="${cate_idx}";
	}
	else if(cate_idx="0")
	{
		search_init();
	}
	
	getList_news(cate_idx);
	
	// 검색어 입력시 검색어 지우기 버튼 활성화
	$('#search_name').keyup(function(){
		if($(this).val() == ''){
			$('.del-btn').removeClass('show');	
		}else {
			$('.del-btn').addClass('show');
		}
	})
});

$(document).ready(function(){
	
  	var latest_date  =	'${data.submit_date2}';
 
  	var today = new Date();

  	var year = today.getFullYear();
  	var month = ('0' + (today.getMonth() + 1)).slice(-2);
  	var day = ('0' + today.getDate()).slice(-2);

  	var now_submit_date = year + '-' + month  + '-' + day;
 	
	$("#start_date").val(latest_date);
	$("#finish_date").val(now_submit_date);
	
});

function getList_news(idx)
{	 
	$('.nav-wr .nav li a').removeClass('act');
	$('.target_'+idx).addClass('act');
	
	setCookie('cate_cookie_news',$('#cate').val());     
	setCookie('start_date',$('#start_date').val());
	setCookie('finish_date',$('#finish_date').val());         
	
	$.ajax({
		type : "POST", 
		url : "/news/getNewsdetail",
		dataType : "text",
		data : 
		{
			idx  		:  idx,
			page 	 	:  page,
			listSize 	:  "10",
			start_date  :  $("#start_date").val().replace(/-/gi, ""),
			finish_date :  $("#finish_date").val().replace(/-/gi, ""),
			search_name :  $("#search_name").val(),
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
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					if(result.list[i].top_yn == "Y")
					{
						inner +='<tr class="fixed-top">';
						inner +='	<td class="num">'+[i+1]+'</td>';
						inner +='	<td class="cate"><span>'+result.list[i].get_cate_nm+'</span></td>';
						inner +='	<td class="tit ta-l ko-txt cur-on" onclick="window.open(\''+result.list[i].url+'\')">'+result.list[i].title+'</td>';
						inner +='	<td class="date">'+result.top_list[i].submit_date2+'</td>';
						inner +='</tr>';

					}
						inner2 +='<tr>';
						inner2 +='	<td class="num">'+[result.list.length-i]+'</td>';
						inner2 +='	<td class="cate"><span>'+result.list[i].get_cate_nm+'</span></td>';
						inner2 +='	<td class="tit ta-l ko-txt cur-on" onclick="window.open(\''+result.list[i].url+'\')">'+result.list[i].title+'</td>';
						inner2 +='	<td class="date">'+result.list[i].submit_date2+'</td>';
						inner2 +='</tr>';
				}
			}

			listSize = result.listSize;
			
			$(".detail").html(inner);
			$(".detail2").html(inner2);
			
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			
		}
	});	
}

// 전체 클릭시 검색 조건 초기화
function search_init()
{	
	$.ajax({
		type : "POST", 
		url : "/news/getNewsdetail",
		dataType : "text",
		data : 
		{
			idx  		:  '',
			page 	 	:  page,
			listSize 	:  "10",
			start_date  :  $("#start_date").val().replace(/-/gi, ""),
			finish_date :  $("#finish_date").val().replace(/-/gi, ""),
			search_name :  ''
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
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					if(result.list[i].top_yn == "Y")
					{
						inner +='<tr class="fixed-top">';
						inner +='	<td class="num">'+[i+1]+'</td>';
						inner +='	<td class="cate"><span>'+result.top_list[i].get_cate_nm+'</span></td>';
						inner +='	<td class="tit ta-l ko-txt cur-on" onclick="window.open(\''+result.list[i].url+'\')">'+result.list[i].title+'</td>';
						inner +='	<td class="date">'+result.top_list[i].submit_date2+'</td>';
						inner +='</tr>';

					}
						inner2 +='<tr>';
						inner2 +='	<td class="num">'+[result.list.length-i]+'</td>';
						inner2 +='	<td class="cate"><span>'+result.list[i].get_cate_nm+'</span></td>';
						inner2 +='	<td class="tit ta-l ko-txt cur-on" onclick="window.open(\''+result.list[i].url+'\')">'+result.list[i].title+'</td>';
						inner2 +='	<td class="date">'+result.list[i].submit_date2+'</td>';
						inner2 +='</tr>';
				}
			}

			listSize = result.listSize;
			
			$(".detail").html(inner);
			$(".detail2").html(inner2);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			
		}
	});	
}

//datepicker
$(function() {
	$(".datepicker").datepicker({
		dateFormat : 'yy-mm-dd'
	});
}); 

// 쿠키세팅 
function setCookie(cname,cvalue) {

	  var d = new Date();
	  var exdays = 1;
	  d.setTime(d.getTime() + (60*60*24));

	  var expires = "expires="+ d.toUTCString();

	  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";

	} 

function getCookie(cname) {

	  var name = cname + "=";

	  var decodedCookie = decodeURIComponent(document.cookie);

	  var ca = decodedCookie.split(';');

	  for(var i = 0; i <ca.length; i++) {

	    var c = ca[i];

	    while (c.charAt(0) == ' ') {

	      c = c.substring(1);

	    }

	    if (c.indexOf(name) == 0) {

	      return c.substring(name.length, c.length);

	    }

	  }

	  return "";

	} 
	
function delSearch(){
	
	$("#search_name").val("");
	$('.del-btn').removeClass('show');
}
	
</script>
<div id="news">
	<input type="hidden" id="cate_val2" name="cate_val2"/>
	<div class="inner">
		<div class="sub-tit-wr">
			<jsp:include page="../sub_common/svg_wave.jsp"/>
			<p class="sub-tit">News</p>
		</div>
		<!-- //sub-tit-wr -->
		
		<div class="sub-cont">
			<div class="sub-cont-inner">
		<!-- <div class="sub-cont"> -->
			<!-- <div class="sub-cont-inner"> -->
			<div class="nav-wr">
				<ul class="nav">
				     <li class="nav-it ko n1"><a class="cate_val target_0" href="all" onclick="search_init();" value="all">전체<span class="count">${All_cnt}</span></a></li>
				 	 <c:forEach items="${news_cate}" var="i">
			        		<li class="nav-it">
			        			<a id="cate_val" class="cate_val target_${i.idx}" href="/news/all?cate_idx=${i.idx}" onclick="getList_news('${i.idx}')" value="${i.idx}">${i.cate_nm}
			        				<span class="count">${i.cate_cnt}</span>
			        			</a>
			        		</li>
				     </c:forEach>
				</ul>
			</div>
			<div class="cont-wr inb">
				<div class="search-wr fz0 pc">
					<div class="per-wr inb">
						<input type="text" id="start_date" name="start_date" class="datepicker input-calendar" autocomplete="off"> 
						<em> - </em>
						<input type="text" id="finish_date" name="finish_date" class="datepicker input-calendar calendar" autocomplete="off">
						</div>
						<div class="bar-wr inb">
							<input type="text" id="search_name" name="search_name" class="search_bar" placeholder="제목 또는 내용을 입력해주세요." onkeypress="javascript:pagingReset(); excuteEnter(getList_news);"/>
							<input type="text" class="del-btn" onclick="javascript:delSearch();" value="지우기"></input>
							<input type="text" class="search-btn" onclick="javascript:getList_news();" value="검색"></input>
						</div>
					</div>
				<!-- <div class="cont-wr inb"> -->
				
					<table class="list-wr">
						<thead>
							<tr>
								<th>번호</th>
								<th>카테고리</th>
								<th>제목</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody class="detail">
						</tbody>
						<tbody class="detail2">
						</tbody>	
					</table><!-- //list-wr -->
					
					<div class="pagination">
						<jsp:include page="/WEB-INF/pages/common_admin/paging.jsp"/>
					</div>
					
				</div><!-- //cont-wr -->
			</div><!-- //sub-cont-inner -->
		</div><!-- //sub-cont -->
	</div>	
</div>
<script>
$(document).ready(function(){
	
	getCookie('cate_cookie')  != '' ? $('#cate').val(getCookie('cate_cookie')) 	 :  $('#cate').val();
	getCookie('start_date')   != '' ? $('#start_date').val(getCookie('start_date')) 	 : $('#start_date').val();
	getCookie('finish_date')  != '' ? $('#finish_date').val(getCookie('finish_date')) 	 : $('#finish_date').val();
	
});
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>