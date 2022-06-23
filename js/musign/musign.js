$(function(){
	
	// mo ver
	function mo_ver (){
		var ww = $(window).width();
		if( ww <= 768 ){
			$('body').addClass('mo-ver no-scroll-end');
			$('.btn-box-wr .btn-box').addClass('hover');
		} else {
			$('body').removeClass('mo-ver no-scroll-end');
			$('.btn-box-wr .btn-box').removeClass('hover');		
		}		
	} mo_ver();
	
	var timer = null;
	$(window).on('resize', function(){
		clearTimeout(timer);
		timer = setTimeout(function(){
			mo_ver();
		}, 300);
	});
	
	// main cursor
	if(!$('body').hasClass('mo-ver')){
		var cursor = $('.cursor');
		$(document).mousemove(function(over) {
			setTimeout(function() {
				cursor.css({
			      left: over.pageX,
			      top: over.pageY
			    });
			}, 0);
		}); out();
		
	//	$(".cur-def").on('mouseover', def );
	//	$(".cur-def").on('mouseout', def_re );
		$("a, button, input, .cur-on").on('mouseover', over );
		$("a, button, input, .cur-on").on('mouseout', out );
		
	//	function def (t) {cursor.addClass("off");} // 기본 마우스
	//	function def_re (t) {cursor.removeClass("off");} // 기본 마우스 끝
		function over (t) {cursor.addClass("hover");} // a, button hover
		function out (t) {cursor.removeClass("hover");} // a, button hover 끝
	
		
		// lnb cursor
		var float = $('.float-wr');
		var mouseX = 100,
			mouseY = 100,
			floatX = 0, 
			floatY = 0,
			speed = 0.15;
		
		function move() {
			var distX = mouseX - floatX;
			var distY = mouseY - floatY;
			floatX = floatX + (distX * speed);
			floatY = floatY + (distY * speed);
	
			float.css({
				left: floatX + "px",
				top: floatY + "px"
			});
			requestAnimationFrame(move);
		} move();
		
		$("#lnb .nav .dep1").each(function(){
			var _this = $(this), 
				img = float.find('img'), 
				idx = _this.index(),
				src = _this.attr('data-img');
				
			_this.on('mousemove', function(e, i){
				mouseX = event.pageX;
				mouseY = event.pageY;
			}).on('mouseenter', function(e){
				float.addClass("hover");
				img.eq(idx).appendTo($('.float-img'));
			}).on('mouseleave', function(e){
				float.removeClass("hover");
			});
		});
	};

	// 아이패드 커서 삭제
//	var filter = "macintel"; 
//	alert(navigator.platform)
//	alert(navigator.platform.toLowerCase())
//	if ( navigator.platform ){ 
//		if ( filter.indexOf( navigator.platform.toLowerCase() ) > -1 ) {
//			$('.cursor').addClass('dn');
//		}
//	}
});


$(window).load(function(){
	
	// header menu active
	if ( !$('body').hasClass('main') ){
		var path = window.location.pathname.split('/')[1],
			gnb = $('#gnb .dep1 > li > a');
		gnb.each(function(e, i){
			if( $(this).attr('href').indexOf(path) > -1 ){
				$(this).closest('li').addClass('act');
			}
		});
	};
	
	// main - menu hover > white 삭제
	$('.dep1 li').mouseenter(function(){
		if ($('body').hasClass('fp-viewing-main')){
			$('#header').removeClass('white');
		};
		if($(this).hasClass('short')){			
			$('#gnb').removeClass('hover');			
			$('#gnb').addClass('hover-short');
		} else {
			$('#gnb').removeClass('hover-short');			
			$('#gnb').addClass('hover');			
		}
	}).mouseleave(function(){
		if ($('body').hasClass('fp-viewing-main')){
			$('#header').addClass('white');	
		};
		$('#gnb').removeClass('hover hover-short');
	})
	
	var sct = null;
	// lnb open
	$('#gnb .menu').click(function(){
		sct = $(window).scrollTop();
		$('#lnb').addClass('open');
		$('#header .svg-wr').removeClass('on');
		$('#header').addClass('white');
		$('body').addClass('no-scroll');
		// pc - scroll 금지
		if(!$('body').hasClass('mo-ver')){
			$('body').on('scroll mousewheel', function(event) {
				event.preventDefault();
				event.stopPropagation();
				return false;
			})
		}
		// 무조건 sct 0으로
		if($('#lnb').hasClass('open')){
			var timer = null;
			clearTimeout(timer);
			timer = setTimeout(function(){
				$("html,body").stop().animate({scrollTop: 0 + 'px'}, 0);
			}, 500);
		}
		// mo lang 박스
		if(!$('.sel-box').hasClass('on')){
			$('.sel-box').addClass('on'); 			
		}
	});
	// lnb close
	$('#lnb .close-btn').click(function(){
		// scroll 금지 해제
		$('#lnb').off('scroll touchmove mousewheel');
		$('#lnb').removeClass('open');
		$('.sel-box').removeClass('on');
		$('body').removeClass('no-scroll');
		// 원래 sct로
		var timer = null;
		clearTimeout(timer);
		timer = setTimeout(function(){
			$("html,body").stop().animate({scrollTop: sct + 'px'}, 0);			
		}, 500);
		if( $('body').hasClass('fp-viewing-main') ){
			$('#header').addClass('white');						
		} else {
			setTimeout(function(){$('#header').removeClass('white')}, 900);							
		}
	});
	
	// pc lnb menu hover
	$('#lnb .nav .dep1').each(function(){
		$(this).mouseenter(function(){
			$('#lnb .nav .dep1').addClass('off');
		}).mouseleave(function(){			
			$('#lnb .nav .dep1').removeClass('off');
		})
	});
	
	// mo lnb click 활성화
	if($('body').hasClass('mo-ver')){
		$('#lnb .nav .dep1 > a').click(function(e){
			e.preventDefault();
			if(!$(this).hasClass('on')){
				$('.dep2-wr').slideUp();
				$('#lnb .nav .dep1 a').removeClass('on')				
				$(this).addClass('on');
				$(this).siblings($('.dep2-wr')).slideToggle();
			} else {
				$('.dep2-wr').slideUp();
				$(this).removeClass('on')
			}
		})
	};
	
	// pc lang box on
	if ( !$('body').hasClass('mo-ver') ){
		$('.lang-box').click(function(){
			if( !$('.lang-box').hasClass('show') ){
				$(this).addClass('show');
			} else {
				$(this).removeClass('show');
			}
		})
	}
	
	// lang 활성화
	$('.gnb-side .sel-box li').each(function(){
		var lang = $(this).attr('data-lang');
		if( lang == $('html').attr('lang') ){
			$('.gnb-side .sel-box li').removeClass('act')
			$(this).addClass('act')
		}
	});
	
	// lang 변환
	$('.sel-box li').click(function(e){
		var url = window.location.href,
			lnag_body = $('html').attr('lang'),
			lang_href = $(this).attr('data-lang'); 
		var cate0 = url.split("?")[0],
			cate1 = url.split("?")[1];											
		
		if(!$('body').hasClass('main') && url.indexOf('news') == -1 &&  url.indexOf('stewardship') == -1){			
			e.preventDefault();
			if ( lnag_body == lang_href ){
			} else {
				if(lang_href == 'ko'){ // to ko
					if(url.indexOf('?') < 0){ // cate 없음
						location.href = url.split("_")[0];							
					} else { // cate 있음
						location.href = cate0.split('_')[0] + '?' + cate1;			
					}
				} else { // to en
					if(url.indexOf('?') < 0){ // cate 없음
						location.href = url + '_' + lang_href;											
					} else { // cate 있음
						location.href = cate0 + '_' + lang_href + '?' + cate1;			
					}
				}
			}
		}
	})
	
	// nav scroll 방지
	if( $('#lnb').hasClass('open') && $('body').hasClass('mo-ver')){
		$(window).scroll(function () {	
			$('body').bind("scroll touchmove mousewheel DOMMouseScroll", function (e) {
				e.preventDefault();
			})
		})
	}
	
	// footer anchor
	var h = $('#header'), hh = h.height(), sec = $('.f-anchor'),
		anchor = $('#footer .anchor-wr .anchor-it');
	anchor.click(function(){
		var _this = $(this), idx = _this.index();
		target = sec.eq(idx).offset().top; move();
	});
	
	//footer top btn
	var topbtn = $('body:not(.main) .top-btn-wr');
	topbtn.click(function(e){
		e.preventDefault();
		target = 0; move();
//		setTimeout(function(){
//			$('#header').removeClass('down');
//			$('#header').addClass('up');
//		}, 1000)
	});
	function move (){
		$("html,body").stop().animate({
	        scrollTop: target + 'px'}, 900);
	};

	// animation
	$(window).scroll(function () {
		var sct = $(window).scrollTop() + ( $(window).height() * 0.65 );
		$('.section, .ani-wr').each(function(){
			var sec_ost = $(this).offset().top;
			if (sct > sec_ost){
				$(this).addClass('ani');
			} else {
				$(this).removeClass('ani');				
			}
		});
	});
	
	// sub nav active - aboutus
	$('.nav-wr .nav li a').each(function(){
		var navH = $(this).attr('href'),
			path = window.location.pathname.split('/')[2];
		
		if ( navH == path ){
			$(this).addClass('act');
		} else {
			$(this).removeClass('act');			
		}
	});
	// sub nav active - 나머지
//	$('#container > div:not(#aboutus) .nav-wr .nav li a').click(function(e){
//		e.preventDefault();
//		$('.nav-wr .nav li a').removeClass('act');
//		$(this).addClass('act');
//	});
	
	// sub nav fixed
	if($('.sub-cont').length > 0){
		
		$(window).scroll(function(){
			var sct = $(this).scrollTop(), nav = $('.nav-wr'),
				ost = $('.sub-cont').offset().top,
				wh = $(window).height() * .6,
				f_ost = $('.footer-wr').offset().top,
				hh = $('#header').outerHeight(true) * 1.6 ;

			if( sct >= ost - hh && sct <= f_ost - wh ){
				nav.addClass('fixed');
				nav.removeClass('end');				
			} else if (sct > f_ost - wh){
				if(!$('body').hasClass("no-scroll-end")){
					nav.addClass('end');			
					nav.removeClass('fixed');
				}
			} else {				
				nav.removeClass('end fixed');
			}
		});
	}
	
	// mo nav
	if( $('body').hasClass('mo-ver') ){
		var $this = $('.nav-wr');
		var timer = null;
		clearTimeout(timer);
		timer = setTimeout(function(){
			navAdd();
		}, 300);
		// click
		$this.on('click', $this, function(){
			if(!$this.hasClass('open')){
				$this.addClass('open');
				$this.find('ul.nav').slideDown();
			} else {
				$this.removeClass('open');
				$this.find('ul.nav').slideUp();				
			}
		})
	}
	$(window).on('resize', function(){
		var timer = null;
		clearTimeout(timer);
		timer = setTimeout(function(){
			if( $('body').hasClass('mo-ver') ){ //mo
				navAdd();
				$('.nav-wr .nav').hide();
				$('.nav-wr').find('.tit').eq(0).show().siblings('.tit').remove();
			} else { //pc
				$('.nav-wr .nav').show();
				$('.nav-wr .tit').hide();			
			}
		}, 300);
	});
	
	// .tit add / change
	function navAdd(){
		var $this = $('.nav-wr'),
			$li = $this.find('ul li');
		$this.prepend('<span class="tit">' + $this.find('ul li a.act').text().replace($('ul li a.act span').text(),'') + '</span>');
		$li.on('click', $li, function(){ // 숫자 삭제
			var $span = $(this).find('a span').text(),
				$text = $('ul li a.act').text(),
				$text2 = $text.replace($span, '');
			$('.nav-wr > span').empty().text($text2);
		})
	}
})