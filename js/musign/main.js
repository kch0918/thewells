//$(function(){
//	// sec01 scroll
//	$(window).scroll(function () {
//	  $(".section").each(function () {
//	    $(this).bind("scroll touchmove mousewheel DOMMouseScroll", function (e) {
//		    var delta = 0, _this = $(this), header = $('#header'),
//		       sct = $(window).scrollTop(), ost = $('.sec02').offset().top;
//		       moveTop = null,
//		       ost03 = $('.sec03').offset().top;
//		       
//		    // delta 값 설정
//		    if (!event) event = window.event;
//		    if (event.wheelDelta) {
//		        delta = event.wheelDelta / 120;
//		        if (window.opera) delta = -delta;
//		    } else if (event.detail) delta = -event.detail / 3;
//		    
//		    if (sct > ost03) $('.sec03').addClass('sec03-act');
//		    else $('.sec03').removeClass('sec03-act');
//		    
//		    // 영역에 따라 스크롤값 변화
//		    if (delta < 0) { // down
////		    	console.log('true')
//		    	header.addClass('down black'); header.removeClass('up');    	  
//		  		if (_this.hasClass('mian-v') ) {
//		  			e.preventDefault();
//		  			moveTop = ost; move();
////		  			console.log('true-true')
//		  		} else if (_this.hasClass('sec03-act') ) {
//		  			e.preventDefault();
//		  			moveTop = _this.next().offset().top; move();
//		  		} else if (_this.hasClass('sec04')) {
//		  			e.preventDefault();
//		  			moveTop = _this.next().offset().top; move();
//		        } else {/*_this.off('scroll touchmove mousewheel DOMMouseScroll'); console.log('true-else')*/}
//		    } else { // up
//		    	header.removeClass('down'); header.addClass('up'); 
////		    	console.log('else')
//		        if (sct < ost && _this.prev().hasClass('mian-v') || sct < ost && _this.hasClass('mian-v')) {
//		        	e.preventDefault();
//		        	moveTop = 0; move(); header.removeClass('black'); 
////		        	console.log('else-true')
//		        } else if (_this.prev().hasClass('sec03') || _this.hasClass('sec04')){	
//		        	e.preventDefault();
//		        	moveTop = _this.prev().offset().top; move();
//		        } else if (_this.prev().hasClass('sec04') || _this.hasClass('sec05')){	
//		        	e.preventDefault();
//		        	moveTop = _this.prev().offset().top; move();
//		    	} else {
////		        	_this.off('scroll touchmove mousewheel DOMMouseScroll'); 
//		        	header.addClass('black');
////		        	console.log('else-else')
//		        }
//		    }
//		    
//		    // 스크롤 움직이도록 하는 함수
//		    function move (){
//			    $("html,body").stop().animate({
//			        scrollTop: moveTop + 'px'}, 1000);
//		    }
//	    });
//	  });
//	})
//})


$(function(){
	// resize 새로고침
	var delta = 300; 
	var timer = null; 
	$(window).on('resize', function() { 
		clearTimeout(timer); 
		timer = setTimeout(resizeDone, delta); 
	} ); 
	function resizeDone(){
		location.reload();
//		mo_ver();		
	}
	
	// full page
	if(!$('#fullpage').hasClass('en')){
		$("#fullpage").fullpage({
			fixedElements: '#header, footer',
			menu: '#header',
			scrollingSpeed: 1000,
			anchors:['main', 'about', 'partners', 'team', 'news',''],
			setLockAnchors:true,
			animateAnchor:false,
			autoScrolling:true,
			onLeave: function(origin, destination, direction){
				if( direction == 'up' && destination == 1 ){
					$("#header").removeClass("down");
					$("#header").addClass("up white");
				} else if( direction == 'up' ){
					$("#header").removeClass("down white");
					$("#header").addClass("up");
					if(destination == 2){counter();};
				}else{
					$("#header").removeClass("up white");
					$("#header").addClass("down");
					if(destination == 2){counter();};
				}},
		});
	} else { // en 
		$('.sec05').remove();
		$("#fullpage").fullpage({
			fixedElements: '#header, footer',
			menu: '#header',
			scrollingSpeed: 1000,
			anchors:['main', 'about', 'partners', 'team',''],
			setLockAnchors:true,
			animateAnchor:false,
			autoScrolling:true,
			onLeave: function(origin, destination, direction){
				if( direction == 'up' && destination == 1 ){
					$("#header").removeClass("down");
					$("#header").addClass("up white");
				} else if( direction == 'up' ){
					$("#header").removeClass("down white");
					$("#header").addClass("up");
					if(destination == 2){counter();};
				}else{
					$("#header").removeClass("up white");
					$("#header").addClass("down");
					if(destination == 2){counter();};
				}},
		});
	}
	
	// contact us 팝업 클릭 시 풀페이지 스크롤 불가능
	$('.contact-it').click(function(){
		$.fn.fullpage.setAllowScrolling(false);
	});
	$(".close, .bg").click(function(){
		$.fn.fullpage.setAllowScrolling(true);		
	})
	
	
	// main header white.ver
	if($('body').hasClass('fp-viewing-main')){
		$('#header').addClass('white');
	}
});



// fullpage 인 경우 숫자 카운팅
function counter (){
	var countWrap = $('.sec02 .count-box'),
	countitem = countWrap.find($('.count-item')),
	sct = $(window).scrollTop() + ($(window).height()/4),
	ost = $('.mian-v').offset().top;

	// sec02 숫자 카운팅
	countitem.each(function () {
		var text = $(this).find('.num');
		var rate = text.attr('data-num');
	
//		if (text.text() == '') { // 페이지 올때마다 숫자 카운팅 위해 주석
			$({ rate: 0 }).animate({ rate: rate }, {
				duration: 2000,
				progress: function () {
					var now = this.rate;
					if (text.hasClass('spot')){
						text.text(Math.ceil(now).toLocaleString());												
					} else {
						text.text(Math.ceil(now));												
					}
				}
			});
//		};
	});
};


$(window).load(function(){
	
//	$(window).scroll(function () {
//		var countWrap = $('.sec02 .count-box'),
//			countitem = countWrap.find($('.count-item')),
//			sct = $(window).scrollTop() + ($(window).height()/4),
//			ost = $('.mian-v').offset().top,
//			sec = $('.section');
//		
//		// sec02 숫자 카운팅
//		countitem.each(function () {
//			var text = $(this).find('.num');
//			var rate = text.attr('data-num');
//
//			if ((sct > ost && text.text() == '')) {
//				$({ rate: 0 }).animate({ rate: rate }, {
//					duration: 2000,
//					progress: function () {
//						var now = this.rate;
//						text.text(Math.ceil(now));
//					}
//				});
//			};
//		});
//	});
	
	// sec03 slide
	$('.sec03 .flow-box').each(function(i,el){ 
		var slick1 = $(this).find('.n1');
		var slick2 = $(this).find('.n2');
		var slick3 = $(this).find('.n3');
		sliderSet1(slick1,slick2,slick3);
	})
	
	function sliderSet1(slick1,slick2,slick3){
		slick1.slick({
			slidesToShow : 5.9,	
			slidesToScroll : 1,
			arrows: false,
			autoplay: true, 
			autoplaySpeed : 0,
			draggable: false,
			pauseOnHover : true,	
			pauseOnFocus: true,
			speed: 5000,
			cssEase: 'linear',
			infinite: true,
			responsive: [ 
				{
					breakpoint: 768, 
					settings: {
						slidesToShow:4
					} 
				},
				{
					breakpoint: 480,
					settings: {	
						slidesToShow:2.7
					} 
				}
			]
		});
		slick2.slick({
			slidesToShow : 5.9,	
			slidesToScroll : 1,
			arrows: false,
			autoplay: true, 
			autoplaySpeed : 0,
			draggable: false,
			pauseOnHover : true,	
			pauseOnFocus: true,
			speed: 5000,
			cssEase: 'linear',
			reverse: true,
			rtl: true,
			infinite: true,
			responsive: [ 
				{
					breakpoint: 768, 
					settings: {
						slidesToShow:4
					} 
				},
				{
					breakpoint: 480,
					settings: {	
						slidesToShow:2.7
					} 
				}
			]
		});
		slick3.slick({
			slidesToShow : 5.9,	
			slidesToScroll : 1,
			arrows: false,
			autoplay: true, 
			autoplaySpeed : 0,
			draggable: false,
			pauseOnHover : true,	
			pauseOnFocus: true,
			speed: 5000,
			cssEase: 'linear',
			infinite: true,
			responsive: [ 
				{
					breakpoint: 768, 
					settings: {
						slidesToShow:4
					} 
				},
				{
					breakpoint: 480,
					settings: {	
						slidesToShow:2.3
					} 
				}
				]
		});
	}
//	$('.sec03 .flow-box .cont-wr').hover(function() {
//		$(this).slick('slickSetOption', 'autoplay', false).slick('slickPause');
//	},function() {
//		$(this).slick('slickSetOption', 'autoplay', true).slick('slickPlay');
//	});
	
	
	// sec04 슬라이드
	$('.sec04 .left-box').each(function(i,el){ 
		var slick = $(this).find('.teamslide');
		var slickfor = $(this).find('.teamslide1');
		var slicknav = $(this).find('.teamslide2');
		sliderSet2(slickfor,slicknav);
	})
	
	function sliderSet2(slickfor,slicknav){
		slicknav.slick({
			infinite: true,
			vertical : true,
			slidesToShow : 3,	
			slidesToScroll : 1,
			arrows: false,
			autoplay: true, 
			autoplaySpeed : 0,
			draggable: false,
			pauseOnHover : false,	
			pauseOnFocus: false,
			verticalReverse: true,
			speed: 5000,
			cssEase: 'linear',
			responsive: [ 
				{
					breakpoint: 768, 
					settings: {
						slidesToShow:2.3
					} 
				},
				]
			
		});
		slickfor.slick({
			infinite: true,
			vertical : true,
			slidesToShow : 3,	
			slidesToScroll : 1,
			arrows: false,
			autoplay: true, 
			autoplaySpeed : 0,
			draggable: false,
			pauseOnHover : false,
			pauseOnFocus: false,
			speed: 5000,
			cssEase: 'linear',
			responsive: [ 
				{
					breakpoint: 768, 
					settings: {
						slidesToShow:2.3
					} 
				},
				]
		});
	}
	
	// sec05 slide
	$('.sec05 .news-wr').slick({
		responsive: [ 
			{
	            breakpoint: 9999,
	            settings: "unslick"
	        },
			{
				breakpoint: 768, 
				settings: {
					slidesToShow:2.3,
					slidesToScroll : 1,
					arrows: false,
					infinite: false,
				} 
			},
	        {
	        	breakpoint: 580, 
	        	settings: {
	        		slidesToShow:1.3,
	        		slidesToScroll : 1,
	        		arrows: false,
	        		infinite: false,
	        		centerMode: true,
	        		centerPadding: '0.45rem',
	        	} 
	        }
		]
	});
	
	
});


