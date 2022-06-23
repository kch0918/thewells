<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="lnb">
	<ul class="mainmenu">
		<li class="dep1">
			<span>Main</span>
			<ul class="submenu">
				<li><a href="/admin/main/achievement">업적관리</a></li>
			</ul>
		</li>
		<li class="dep1"> 
			<span>About Us</span>
			<ul class="submenu">
				<li><a href="/admin/aboutus/history_list">History 관리</a></li>
			</ul>
		</li>
		<li class="dep1">
			<span>Partners</span>
			<ul class="submenu">
				<li><a href="/admin/partners/partners_cate">카테고리 관리</a></li>
				<li><a href="/admin/partners/partners_list">파트너스 리스트 관리</a></li>
			</ul>
	 	</li>
	 	<li class="dep1">
			<span>Our Team</span>
			<ul class="submenu">
				<li><a href="/admin/team/team_cate">카테고리 관리</a></li>
				<li><a href="/admin/team/team_list">팀원 리스트 관리</a></li>
			</ul>
	 	</li>  
 		<li class="dep1">
			<span>News</span>
			<ul class="submenu">
				<li><a href="/admin/news/news_cate">카테고리 관리</a></li>
				<li><a href="/admin/news/news_list">게시글 관리</a></li>
			</ul>
	 	</li>  
	</ul> 
</div>

<script>
$(window).ready(function() {
	//$('.submenu li a[href *="' + window.location.pathname +'"]').addClass('on');



	var submenuA = $('.submenu li a');
	
    $('.mainmenu li').click(function(){
    	
        if($(this).hasClass("on")){
    		$(this).removeClass("on");
        } else {
        	$('.mainmenu li').removeClass("on");
        	$(this).addClass("on");
        }
    });
   
     
     
 	// 전체 주소 가져오기 	
 	var pathFull = window.location.pathname,
  		li = $('.mainmenu > .submenu');


 	$('.mainmenu .submenu a').each(function(){
 		var href = $(this).attr('href');
 		if(pathFull === href){
 			$(this).closest('.dep1').addClass('active');
 			$(this).closest('li').addClass('on');
 		}
 	});
 	
	
    $('.aaa a').each(function(){
    	var href2 = $(this).attr('href');
    	if(pathFull === href2){
 			$(this).parent('.dep1').addClass('active');
 		}
    });
    
    

  
})

</script>