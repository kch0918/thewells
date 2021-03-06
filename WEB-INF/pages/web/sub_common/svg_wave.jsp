<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.1/TweenMax.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/wavify@1.0.0/wavify.js"></script>
<script src="https://cdn.jsdelivr.net/npm/wavify@1.0.0/jquery.wavify.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/85188/jquery.wavify.js"></script>
<script>
	$(window).load(function(){
		
		$('.svg-wr').addClass('on');
		var wave1 = $('.wave1 path'),
			wave2 = $('.wave2 path'),
			ww = $(window).width();
		
		// 물결 웨이브
			if (ww > 1200) {
				wave1.wavify({
					height: 50,
					bones: 4,
					amplitude: 55,
					speed: .4,
				});
				wave2.wavify({
					height: 50,
					bones: 4,
					amplitude: 70,
					speed: .3,
				});
			} else if (ww <= 1200 && ww > 768) {
				wave1.wavify({
					height: 25,
					bones: 4,
					amplitude: 20,
					speed: .4,
				});
				wave2.wavify({
					height: 25,
					bones: 4,
					amplitude: 40,
					speed: .3,
				});
			} else if (ww <= 768){
				wave1.wavify({
					height: 7,
					bones: 4,
					amplitude: 18,
					speed: .4,
				});
				wave2.wavify({
					height: 7,
					bones: 4,
					amplitude: 23,
					speed: .3,
				});
			}
		
		$(window).on('resize', function(){
			wave1.reboot;
			wave2.reboot;
		})
	})
</script>

<div class="svg-box">
	<div class="svg-wr pc pc1">
		<svg version="1.1" class="wave1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="50 50 1200 129.1" style="enable-background:new 0 0 1200 129.1;" xml:space="preserve"> 
			<g>
				<path preserveAspectRatio='xMinYMin meet' class="st0" d="M-0.06,47.76c78.09,16.05,158.33,12.75,237.04,3.35c80.19-9.58,159.62-24.65,239.76-34.7
		C556.83,6.36,637.76,0.2,718.49,4.53c40.49,2.17,80.86,7.01,120.58,15.25c38.12,7.9,75.39,19.22,112.53,30.78
		c71.53,22.28,144.64,46.68,220.42,46.41c9.33-0.03,18.65-0.48,27.95-1.29c0.48-0.04,0.48-0.79,0-0.75
		c-76.57,6.65-151.43-15.03-223.77-37.49C939.2,45.95,902.3,34.02,864.66,24.8c-37.86-9.28-76.45-15.4-115.27-18.83
		c-79.66-7.05-159.89-2.97-239.26,5.76c-79.56,8.75-158.31,22.99-237.55,34.02c-80.33,11.18-162.38,18.35-243.07,6.5
		c-9.84-1.44-19.63-3.19-29.37-5.19C-0.34,46.94-0.54,47.67-0.06,47.76L-0.06,47.76z"/>
			</g>
		</svg>
		
		<svg version="1.1" class="wave2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="50 50 1200 129.1" style="enable-background:new 0 0 1200 129.1;" xml:space="preserve">
			<g>
				<path class="st0" d="M-0.1,3.11c80.82,12.36,161.64,25.71,239.71,50.63c73.87,23.58,145.94,54.74,222.87,67.38
		c77.03,12.66,153.83,0.82,228.65-18.65c77.71-20.22,153.62-46.49,232.62-61.65c81.06-15.55,163.82-22.2,246.32-19.78
		c9.98,0.29,19.95,0.73,29.92,1.28c0.48,0.03,0.48-0.72,0-0.75c-80.58-4.44-161.55-0.35-241.25,12.35
		c-40.01,6.37-79.6,14.98-118.72,25.49c-38.34,10.31-76.27,22.08-114.47,32.89c-75.85,21.46-154.42,39.42-233.74,31.89
		c-78.35-7.43-151.96-37.46-225.83-62.54c-37.95-12.88-76.36-23.94-115.5-32.61C110.56,20.2,70.23,13.33,29.84,6.99
		C19.93,5.43,10.01,3.91,0.1,2.39C-0.37,2.32-0.58,3.04-0.1,3.11L-0.1,3.11z"/>
			</g>
		</svg>
	</div>
	<div class="svg-wr pc pc2">
		<svg version="1.1" class="wave1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="50 50 1200 129.1" style="enable-background:new 0 0 1200 129.1;" xml:space="preserve"> 
			<g>
				<path preserveAspectRatio='xMinYMin meet' class="st0" d="M-0.06,47.76c78.09,16.05,158.33,12.75,237.04,3.35c80.19-9.58,159.62-24.65,239.76-34.7
		C556.83,6.36,637.76,0.2,718.49,4.53c40.49,2.17,80.86,7.01,120.58,15.25c38.12,7.9,75.39,19.22,112.53,30.78
		c71.53,22.28,144.64,46.68,220.42,46.41c9.33-0.03,18.65-0.48,27.95-1.29c0.48-0.04,0.48-0.79,0-0.75
		c-76.57,6.65-151.43-15.03-223.77-37.49C939.2,45.95,902.3,34.02,864.66,24.8c-37.86-9.28-76.45-15.4-115.27-18.83
		c-79.66-7.05-159.89-2.97-239.26,5.76c-79.56,8.75-158.31,22.99-237.55,34.02c-80.33,11.18-162.38,18.35-243.07,6.5
		c-9.84-1.44-19.63-3.19-29.37-5.19C-0.34,46.94-0.54,47.67-0.06,47.76L-0.06,47.76z"/>
			</g>
		</svg>
		
		<svg version="1.1" class="wave2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="50 50 1200 129.1" style="enable-background:new 0 0 1200 129.1;" xml:space="preserve">
			<g>
				<path class="st0" d="M-0.1,3.11c80.82,12.36,161.64,25.71,239.71,50.63c73.87,23.58,145.94,54.74,222.87,67.38
		c77.03,12.66,153.83,0.82,228.65-18.65c77.71-20.22,153.62-46.49,232.62-61.65c81.06-15.55,163.82-22.2,246.32-19.78
		c9.98,0.29,19.95,0.73,29.92,1.28c0.48,0.03,0.48-0.72,0-0.75c-80.58-4.44-161.55-0.35-241.25,12.35
		c-40.01,6.37-79.6,14.98-118.72,25.49c-38.34,10.31-76.27,22.08-114.47,32.89c-75.85,21.46-154.42,39.42-233.74,31.89
		c-78.35-7.43-151.96-37.46-225.83-62.54c-37.95-12.88-76.36-23.94-115.5-32.61C110.56,20.2,70.23,13.33,29.84,6.99
		C19.93,5.43,10.01,3.91,0.1,2.39C-0.37,2.32-0.58,3.04-0.1,3.11L-0.1,3.11z"/>
			</g>
		</svg>
	</div>
	
	<div class="svg-wr mo">
		<svg version="1.1" class="wave1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="50 50 100 129.1" style="enable-background:new 0 0 1200 129.1;" xml:space="preserve"> 
			<g>
				<path preserveAspectRatio='xMinYMin meet' class="st0" d="M-0.06,47.76c78.09,16.05,158.33,12.75,237.04,3.35c80.19-9.58,159.62-24.65,239.76-34.7
		C556.83,6.36,637.76,0.2,718.49,4.53c40.49,2.17,80.86,7.01,120.58,15.25c38.12,7.9,75.39,19.22,112.53,30.78
		c71.53,22.28,144.64,46.68,220.42,46.41c9.33-0.03,18.65-0.48,27.95-1.29c0.48-0.04,0.48-0.79,0-0.75
		c-76.57,6.65-151.43-15.03-223.77-37.49C939.2,45.95,902.3,34.02,864.66,24.8c-37.86-9.28-76.45-15.4-115.27-18.83
		c-79.66-7.05-159.89-2.97-239.26,5.76c-79.56,8.75-158.31,22.99-237.55,34.02c-80.33,11.18-162.38,18.35-243.07,6.5
		c-9.84-1.44-19.63-3.19-29.37-5.19C-0.34,46.94-0.54,47.67-0.06,47.76L-0.06,47.76z"/>
			</g>
		</svg>
		
		<svg version="1.1" class="wave2" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="50 50 100 129.1" style="enable-background:new 0 0 1200 129.1;" xml:space="preserve">
			<g>
				<path class="st0" d="M-0.1,3.11c80.82,12.36,161.64,25.71,239.71,50.63c73.87,23.58,145.94,54.74,222.87,67.38
		c77.03,12.66,153.83,0.82,228.65-18.65c77.71-20.22,153.62-46.49,232.62-61.65c81.06-15.55,163.82-22.2,246.32-19.78
		c9.98,0.29,19.95,0.73,29.92,1.28c0.48,0.03,0.48-0.72,0-0.75c-80.58-4.44-161.55-0.35-241.25,12.35
		c-40.01,6.37-79.6,14.98-118.72,25.49c-38.34,10.31-76.27,22.08-114.47,32.89c-75.85,21.46-154.42,39.42-233.74,31.89
		c-78.35-7.43-151.96-37.46-225.83-62.54c-37.95-12.88-76.36-23.94-115.5-32.61C110.56,20.2,70.23,13.33,29.84,6.99
		C19.93,5.43,10.01,3.91,0.1,2.39C-0.37,2.32-0.58,3.04-0.1,3.11L-0.1,3.11z"/>
			</g>
		</svg>
	</div>
</div>