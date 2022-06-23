

$ (document) .ready(function(){
		
	
		//	 admin 로그아웃
	
	var sw = false;
	
	$($('.t_menu').click(function(){
		if (sw==false) {
			$('.t_menu').addClass("show");
			sw=true;
		} else {
			$('.t_menu').removeClass("show");
			sw=false;
		}
	}));
	
	
// gnb active
    var subMenu = $('.submenu > li > a');
   	var localPath = window.location.pathname; 
   	var pathStr = localPath.split('/');
   	var pathStrbtp = localPath.split('_');
   	
   	
   	console.log(pathStrbtp);
   	console.log(pathStr);
   	console.log(pathStr[3]);
   	console.log(pathStrbtp[0]);

	$.each(subMenu, function(index, item){
		var aHref = $(this).attr('href');
		var aaHref = aHref;
		
		if (aHref.indexOf(pathStr[3]) != -1) {
			$(this).parents('.submenu').addClass('on');
			$(this).parents('li').addClass('on');
			$(this).parents('li').addClass('active');
//		} else if (aHref.indexOf(pathStr[3]) === -1 && aHref.indexOf(pathStr[2]) != -1) {
//			$(this).parents('.submenu').addClass('on');
//			$(this).parents('li').addClass('on');
//			$(this).parents('li').addClass('active');
			
		}else if(pathStr[3] == 'history_upload') {
			$(".mainmenu").children("li").eq(1).addClass('on active');
			$(".mainmenu").children("li").eq(1).find(".submenu li").addClass("on active");
					
		}else if(pathStr[3] == 'partners_upload') {			
			$(".mainmenu").children("li").eq(2).addClass('on active');
			$(".mainmenu").children("li").eq(2).find(".submenu li").eq(1).addClass("on active");
			
		}else if(pathStr[3] == 'team_upload') {			
			$(".mainmenu").children("li").eq(3).addClass('on active');
			$(".mainmenu").children("li").eq(3).find(".submenu li").eq(1).addClass("on active");
			
		}else if(pathStr[3] == 'news_upload') {			
			$(".mainmenu").children("li").eq(4).addClass('on active');
			$(".mainmenu").children("li").eq(4).find(".submenu li").eq(1).addClass("on active");
		}
		
		
		
		
		
//		else if(aHref.indexOf(pathStrbtp[0]) > 0 && $(this)) {
//
//		};
	});
	
	
	// 메뉴 상단 dropmenu
	$('.search_input .detail_btn').click(function(){
		var drop_m = $('.search_input .detail_btn').next('div') 
		
		if (drop_m.hasClass('show')){
			drop_m.removeClass('show')
		} else {
			drop_m.addClass('show')
		}
		
	});
	
	// 메뉴 상단 dropmenu 배경클릭해도 dropmenu 올라가게 
	$(document).click(function(){
		 $("#container.partners_list .top_cont .search_input .drop_box").removeClass('show'); 
	});

	$(".search_input .detail_btn").click(function(e){
		  e.stopPropagation(); 
	});
	$("#container.partners_list .top_cont .search_input .drop_box").click(function(e){
		  e.stopPropagation(); 
		  
		  $("#ui-datepicker-div").click(function(e){
			  e.stopPropagation(); 
		  });
	});
	
	
	
	//dropmenu 리셋버튼
    $( ".reset_btn").click(function () {
        $( ".drop_box .contbox").each( function () {
            $(this).reset();
        });
    });
    
    //업적관리 화폐단위
	
	$(".cont .tit .add_box").click(function(){
		if($(this).parent().hasClass('active')){
			$(this).parent().removeClass('active');
			$(this).parents(".cont").removeClass('change')
		} else {
			$(this).parent().addClass('active');
			$(this).parents(".cont").addClass('change')
		}
	});
	
	// 뉴스 업로드 페이지 관련 파트너사 부분
	$(".cont07 .rt .txtbox input").focus(function(){
		$("#part_search2").show();
	})
	// 파트너사 목록 클릭시 입력창에 기입
	$(document).on("click",".partname .scroll li",function(event){
		fin_idx =  $(this).val();
		console.log($(this).text());
		$('#part_idx').val($(this).text());
		$('#part_result').text($(this).text()).append('<span class="del_btn"></span>');
		$('#part_result').addClass("del");
		$("#part_search2").hide();
	})
	// 파트너사 결과창 del_btn
	$(document).on('click', '#part_result .del_btn', function(){ 
		
		$('#part_result').text('');
		$('#part_result').removeClass("del");
	})
	// 파트너사 목록 외 배경 클릭시 목록 사라짐
	$('html').click(function(e) { 
		if(!$(e.target).hasClass("part_search2")) { 
			console.log('click')
			$('#part_search2').css('display', 'none');
		} 
	});
	

	
//	$(document).on('click',"body:not('.partname')", function(){
//		console.log("z")
//		$("#part_search2").hide();
//	});
//	$(".cont07 .rt .txtbox input").focusout(function(){
//		$("#part_search2").hide();
//	})

	
//	var list = new Array();
//	$("ul[name=part_search2]").each(function(index, item){
//		list.push($(item).val());
//	});

	
});

