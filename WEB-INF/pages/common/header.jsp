<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="ko"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="X-UA-Compatible" content="IE=9;IE=10;IE=Edge,chrome=1"/>
	<meta name="description" content="The Wells Investment, 벤처캐피탈/사모펀드 전문회사"/>
	<meta name="robots" content="noodp">
	<meta name="NaverBot" content="All">
	<meta name="NaverBot" content="index, follow">
	<meta name="Yeti" content="All">
	<meta name="Yeti" content="index, follow">
	<meta property="og:locale" content="ko_KR">
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="">
	<meta property="og:title" content="더웰스인베스트먼트"/>
	<meta property="og:site_name" content="The Wells Investment"/>
	<meta property="og:description" content="The Wells Investment, 벤처캐피탈/사모펀드 전문회사"/>
	<meta property="og:image:width" content="1200"/>
	<meta property="og:image:height" content="630"/>
	<meta property="og:image" content="/img/logo-b.svg"/>
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="더웰스인베스트먼트">
	<meta name="twitter:description" content="The Wells Investment, 벤처캐피탈/사모펀드 전문회사"/>
	<meta name="twitter:image" content="/img/logo-b.svg"/>
	<meta name="_globalsign-domain-verification" content="Ppxt_OF1PzBIhKOayQIx9XPM8V9aoAw9GlxlQh34oO" />
	<link rel="icon" href="/img/icon/favicon.png" sizes="16x16"/>
	<link rel="apple-touch-icon-precomposed" href="/img/icon/favicon.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/img/icon/favicon.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/img/icon/favicon.png">
	<title>The Wells Investment</title>		
	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/musign.css"/>
	<script src="/js/jquery.js"></script>
	<!-- vertical reverse 추가된 slick -->
	<script src="/js/slick_min.js"></script>
	<script src="/js/function.js"></script>
	<script src="/js/musign/musign.js"></script>
	<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
</head>
<body>
	<div class="cursor"></div>
	<div id="wrap">
		<header id="header" class="">
			<div class="header-wr fz0">
				<div class="logo inb rel">
					<a href="/">
						<span class="f-header abs">
							<img src="/img/logo-f.svg" alt="The Wells Investment" />
						</span>
						<span class="b-header abs">
							<img src="/img/logo-b.svg" alt="The Wells Investment" />
						</span>
					</a>
				</div>
				<!-- //logo -->
				<div id="gnb" class="gnb inb">
					<div class="gnb-wr fz0">
						<div class="gnb-box inb fz0 pc">
							<ul class="dep1">
								<li>
									<a href="/aboutus/philosophy" class="anchor-ab"><span>About Us</span></a>
									<ul class="dep2-wr pc">
										<li class="dep2"><a href="/aboutus/philosophy">Philosophy</a></li>
										<li class="dep2"><a href="/aboutus/history">History</a></li>
										<li class="dep2"><a href="/aboutus/stewardship">Stewardship Code</a></li>
									</ul>
								</li>
								<li class="short">
									<a href="/partners/all" class="anchor-pa"><span>Partners</span></a>
									<ul class="dep2-wr pc dn">
										<li class="dep2"><a href="/partners/all">All</a></li>
										<c:forEach items="${ptnr_cate}" var="i">
										<li class="dep2"><a href="/partners/all">${i.cate_nm} </a></li>
										</c:forEach>
									</ul>
								</li>
								<li class="short">
									<a href="/team/all" class="anchor-te"><span>Team</span></a>
									<ul class="dep2-wr pc dn">
										<li class="dep2"><a href="/team/all">All </a></li>
										<c:forEach items="${team_cate}" var="i">
										<li class="dep2"><a href="/team/all">${i.cate_nm}</a></li>
										</c:forEach>
									</ul>
								</li>
								<li class="short">
									<a href="/news/all" class="anchor-ne"><span>News</span></a>
									<ul class="dep2-wr pc dn">
										<li class="dep2"><a href="/news/all">All</a></li>
										<c:forEach items="${news_cate}" var="i">
										<li class="dep2"><a href="/news/all">${i.cate_nm}</a></li>
										</c:forEach>
									</ul>
								</li>
							</ul>
							<!-- //gnb-side -->
						</div>
						<!-- //gnb-box -->
						<div class="gnb-side inb fz0">
							<div class="lang-box rel inb cur-on">
								<span class="tit rel">KOR
									<span class="f-header abs">
										<img src="/img/header/pc_arrow.png" alt="The Wells Investment" />
									</span>
									<span class="b-header abs">
										<img src="/img/header/pc_arrow_b.png" alt="The Wells Investment" />
									</span>
								</span>
								<ul class="sel-box">
									<li data-lang="ko"><a href="/">KOR</a></li>
									<li data-lang="en"><a href="/_en">EN</a></li>
								</ul>
							</div>
							<!-- //lang-box -->
						</div>
						<button type="button" class="menu inb cf">
							<span class="n1"></span>
							<span class="n2"></span>
						</button>
					</div>
				</div>
				<!-- //gnb -->
				<div id="lnb">
					<div class="lnb-wr">
						<div class="bg"></div>
						<jsp:include page="../web/sub_common/svg_wave.jsp"/>
						<div class="float-wr">
							<div class="float-1 float">
								<div class="float-mask">
									<div class="float-2 float">
										<div class="float-img">
											<img class="aboutus" src="/img/header/lnb-aboutus.png" alt="aboutus" />
											<img class="team" src="/img/header/lnb-team.png" alt="team" />
											<img class="partners" src="/img/header/lnb-partners.png" alt="partners" />
											<img class="news" src="/img/header/lnb-news.png" alt="news" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<ul class="nav dep1-wr">
							<li class="dep1 aboutus" data-img="/img/header/lnb-aboutus.png">
								<a href="/aboutus/philosophy">
									<span class="num">01</span>
									<span class="tit">About Us</span>
								</a>
								<ul class="dep2-wr">
									<li class="dep2"><a href="/aboutus/philosophy">Philosophy</a></li>
									<li class="dep2"><a href="/aboutus/history">History</a></li>
									<li class="dep2"><a href="/aboutus/stewardship">Stewardship Code</a></li>
								</ul>
							</li>
							<li class="dep1 team" data-img="/img/header/lnb-team.png">
								<a href="/team/all">
									<span class="num">02</span>
									<span class="tit">Team</span>
								</a>
								<ul id="team_cate" class="dep2-wr">
										<li class="dep2"><a href="/team/all">All </a></li>
									<c:forEach items="${team_cate}" var="i">
										<li class="dep2"><a href="/team/all?cate_idx=${i.idx}">${i.cate_nm}</a></li>
									</c:forEach>
								</ul>
							</li>
							<li class="dep1 partners" data-img="/img/header/lnb-partners.png">
								<a href="/partners/all">
									<span class="num">03</span>
									<span class="tit">Partners</span>
								</a>
								<ul class="dep2-wr">
									<li class="dep2"><a href="/partners/all">All</a></li>
									<c:forEach items="${ptnr_cate}" var="i">
										<li class="dep2"><a href="/partners/all?cate_idx=${i.idx}">${i.cate_nm} </a></li>
									</c:forEach>
								</ul>
							</li>
							<li class="dep1 news" data-img="/img/header/lnb-news.png">
								<a href="/news/all">
									<span class="num">04</span>
									<span class="tit">News</span>
								</a>
								<ul class="dep2-wr">
										<li class="dep2"><a href="/news/all">All</a></li>
									<c:forEach items="${news_cate}" var="i">
										<li class="dep2"><a href="/news/all?cate_idx=${i.idx}">${i.cate_nm}</a></li>
									</c:forEach>
								</ul>
							</li>
						</ul>
					</div>
					<div class="close-btn">
						<button><img src="/img/header/lnb-close-ico.png" alt="close" /></button>
					</div>
				</div><!-- //lnb -->
			</div>
		</header>
	
		<section id="container">
		
		
		
		
		
		
		
		
		
		