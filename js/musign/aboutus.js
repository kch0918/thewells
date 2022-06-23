$(function(){
	
	// aboutus 모든 페이지 nav end 클래스 X
	$('body').addClass('no-scroll-end');
	
	// 필로소피
	if ($('#aboutus').hasClass('philosophy') ){
		$('body').addClass('philosophy');
	}
	if( !$('body').hasClass('mo-ver') && $('#aboutus').hasClass('philosophy') ){
		$(window).scroll(function () {
			var sct = $(window).scrollTop(), scrollWr = $('.scroll-wr').offset().top,
				wh = $(window).height(), ww = $(window).width();
			
			if( $('html').attr('lang') == 'ko' ){ // ko
				var ost1 = scrollWr - (wh * 0.6),
					ost2 = scrollWr * 0.947,
					ost3 = scrollWr * 1.414;
			} else { // en
				var ost1 = scrollWr - (wh * 0.6),
					ost2 = scrollWr * 0.9,
					ost3 = scrollWr * 1.7;
			}
			
			
			if ( sct < ost1){
				$('.fixed-wr').addClass('set');
				$('.fixed-wr').removeClass('abs fix end');
				$('.cont-wr').removeClass('pos');
			} else if ( sct > ost1 && sct < ost2 ){
				$('.fixed-wr').addClass('abs');
				$('.fixed-wr').removeClass('set fix end');				
				$('.cont-wr').removeClass('pos');
			} else if ( sct > ost2 && sct < ost3 ){
				$('.fixed-wr').addClass('fix');
				$('.fixed-wr').removeClass('set abs end');				
				$('.cont-wr').removeClass('pos');
			} else if ( sct > ost3 ){
				$('.fixed-wr').addClass('end');
				$('.fixed-wr').removeClass('set abs fix');		
				$('.cont-wr').addClass('pos');
			} 
		});
	}
	if( $('body').hasClass('mo-ver') ){
		$('.fixed-wr .circle-box').appendTo($('.scroll-wr'));
	}
	
	// 히스토리
	var scrollPos = 0;
	window.addEventListener('scroll', function(){
		$(".history .cont-it").each(function () {
			var $this = $(this), ost = $this.offset().top,
		    	sct = $(window).scrollTop() + ( $(window).height() * 0.4 );
			if ((document.body.getBoundingClientRect()).top > scrollPos){
//				console.log('up')
				if ( $(window).scrollTop() == 0){
					scrollPos = 0;		
					$('.cont-it').removeClass('ani-load-u ani');
					$(".history .cont-it:first-of-type").addClass('ani');
				} else if (sct > ost){
					$('.cont-it').removeClass('ani-load-u ani');
					$(this).addClass('ani'); $(this).removeClass('ani-load');
					$(this).prevAll().addClass('ani-load-u');		
				} else {
					$(this).removeClass('ani');			
				}
			} else {
//				console.log('down')
				if (sct > ost){
					$('.cont-it').removeClass('ani-load-u ani');	
					$(this).addClass('ani'); $(this).removeClass('ani-load');
					$(this).prevAll().addClass('ani-load');
				} else {
					$(this).removeClass('ani');				
				}
				scrollPos = (document.body.getBoundingClientRect()).top;
			}
		});
	});
	$(window).scroll(function () {
		if($('.history .cont-it:last-of-type').hasClass('ani')){
			$('.history .sub-cont').addClass('s-end')
		} else {
			$('.history .sub-cont').removeClass('s-end')			
		}
	})
})
