<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<script src="/js/musign/aboutus.js"></script>

<script>
$(document).ready(function() {
	$('body').addClass('history');
	getList();
});

// 히스토리 
function getList(){
	$.ajax({
		type : "POST", 
		url : "/aboutus/getHistoryList",
		dataType : "text",
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{						
					inner += '	<div class="cont-it">';
					inner += '		<div class="year-box"><p class="year">'+result.list[i].year+'</p></div>';
					inner += '		<div class="line-box"></div>';
					inner += '		<div class="month-box">';
				
					for(var j = 0; j < result.sub_list.length; j++)
					{
						if(result.list[i].idx == result.sub_list[j].history_idx)
						{
							inner += '	<div class="month-it">';
							inner += '		<p class="month">'+result.sub_list[j].month+'월</p>';
							inner += '		<p class="cont">'+repWord(result.sub_list[j].conts_ko)+'</p>';
							inner += '	</div>';
						}
					}
					inner += '</div>';
					inner += '</div>';
				}
			} 
		
			$('#target_area').html(inner); 
			$('.month-box').each(function(){
				if($(this).text() == ''){
					$(this).closest('.cont-it').remove();
				}
			})
			$(".cont-it:first-of-type").addClass('ani');
		}
	});
}

</script>

<div id="aboutus" class="history">
	<div class="inner">
		<!-- <div class="sub-cont"> -->
			<!-- <div class="sub-cont-inner"> -->
		<div class="sub-tit-wr">
			<jsp:include page="../sub_common/svg_wave.jsp"/>
			<p class="sub-tit">About Us</p>
			<p class="sub-txt"></p>
		</div>
		<!-- //sub-tit-wr -->
		<div class="sub-cont">
				<div class="sub-cont-inner">
					<div class="nav-wr">
						<ul class="nav">
							<li class="nav-it n1"><a href="philosophy">Philosophy</a></li>
							<li class="nav-it n2"><a href="history">History</a></li>
							<li class="nav-it n3"><a href="stewardship">Stewardship Code</a></li>
						</ul>
					</div>
						<div class="h-inner">
								<div id="target_area" class="cont-wr">

								</div>
						</div>
					</div><!-- //cont-wr -->
			</div>
		<!-- //sub-cont -->
		</div>
	</div>	
</div>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>