<%@ page import="classes.*" %>
<script>
 var isLogin = "<%=Utils.checkNullString(session.getAttribute("login_id"))%>"; 
 var link = location.href;

 if (isLogin == '') {
 	alert("로그인 후 이용해주세요.");
 	location.href = "/admin/users/login";
 }  
</script>
<html>
<head>
<title>The Wells Investment 관리자</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script type="text/javascript" src="/js/musign.js"></script>
<script type="text/javascript" src="/js/function.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="/js/musign/admin.js"></script>
<link rel="stylesheet" href="/css/common.css">


</head>
<body>
<script>
$(document).ready(function(){
	var scr_stat = getCookie("scr_stat");
	if(scr_stat == "ON")
	{
		$("#scr_stat").html('ON');
		$("#scr_stat").removeClass('off');
		$("#scr_stat").addClass('on');
	}
	else if(scr_stat == "OFF")
	{
		$("#scr_stat").html('OFF');
		$("#scr_stat").removeClass('on');
		$("#scr_stat").addClass('off');
	}
	else
	{
		$("#scr_stat").html('ON');
		$("#scr_stat").removeClass('off');
		$("#scr_stat").addClass('on');
		setCookie("scr_stat", "ON", 9999);
	}
	
     var path_nm = window.location.pathname;
     var cate_nm = path_nm.split('/')[2];
     var cate_nm2 = path_nm.split('/')[3];
	 var cookies = document.cookie.split(';');  // 쿠키 리스트에서 세미콜론[;]으로 각각 구분됨
	 

	 for (var i=0; i<cookies.length; i++)
	 {
		 if (trim(cookies[i].split('_')[0]) != nullChk(cate_nm)) 
		 {
			 setCookie(cookies[i].split('=')[0],"",-1);
		 }		 
		 
		 if (cate_nm2 == "partners_cate" || cate_nm2 == "team_cate" || cate_nm2 == "news_cate")
		 {
			 setCookie(cookies[i].split('=')[0],"",-1);
		 }
	 }
});


</script>
<div id="header" class="header_wrap">
    <div class="h_left">
    <a href="/admin/users/intro" class="logo inb"><img src="/img/admin/c_logo.png"></a>
    </div>
    <div class="right rel">  
    <div class="t_menu">
        <div class="menu rel">
            <img src="/img/admin/ico_admin.png" class="ico_admin">
            <span>Admin</span>
            <img src="/img/admin/h_down_arr.png" class="ico_arrow">
        </div>
        <div class="hide abs dn">
            <a href="/admin/users/logout">LOGOUT</a>
        </div>
    </div>
    </div> 
</div>