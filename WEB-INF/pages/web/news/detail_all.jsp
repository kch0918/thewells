<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<script>
$(document).ready(function(){
	$("#conts").html(repWord(nullChk(('${data.conts}'))));
	
	var temp  = '${data.file_ori}';
	var temp2 = '${data.file}';
	
	var arr = temp.split('|');
	var arr2 = temp2.split('|');
	
	var inner = "";
	
	for (var i = 0; i < arr.length-1; i++) 
	{
		inner += '	<a href="/upload/news/'+arr2[i]+'" download>'+arr[i]+'</a>';
	}

	$(".file").append(inner);
});

	// mo 링크 / 첨부파일 위치 변경
	$(function(){
		$('.tit-box').after($('.cont-box'));
	})
</script>
<div id="news" class="detail">
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
				<div class="cont-wr inb">
					<div class="detail-wr">
						<div class="tit-box cf">
							<p class="tit fl ko-txt">${data.title}</p>
							<p class="date fr">${data.submit_date2}</p>
						</div><!-- //tit-wr -->
						<div class="link-box bb-e">
							<ul>
								<li class="link">
									<span class="tit">링크</span>
									<span class="txt en-txt"><a href="${data.url}" target="_blank">${data.url}</a></span>
								</li>
								<li class="attach">
									<span class="tit">첨부파일</span>
									<span class="txt file">
									</span>
								</li>
							</ul>
						</div><!-- //link-box -->
						<div class="cont-box bb-e">
							<p id="conts"></p>
						</div><!-- //cont-box -->
						<div class="nav-box">
							<ul>
								<c:choose>
									<c:when test="${pre_data.idx != null}">
										  <li class="nav-prev bb-e">
											<span class="tit">이전글</span>
											<span class="txt"><a href="/news/detail_all/?idx=${pre_data.idx}">${pre_data.title}</a></span>
										 </li>
									</c:when>
								</c:choose>
								
								<c:choose>
									<c:when test="${next_data.idx != null}">
										<li class="nav-next">
											<span class="tit">다음글</span>
											<span class="txt"><a href="/news/detail_all/?idx=${next_data.idx}">${next_data.title}</a></span>
										</li>
									</c:when>
								</c:choose>
							</ul>
						</div><!-- //nav-box -->
					</div><!-- //list-wr -->
					
					<div class="btn-box-wr">
						<a class="btn-box hover" href="/news/all">
							<span class="line"></span>
							<span class="txt">List</span>
						</a>
					</div>
				</div><!-- //cont-wr -->
			</div><!-- //sub-cont-inner -->
		</div><!-- //sub-cont -->
	</div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>