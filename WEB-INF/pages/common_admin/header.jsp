<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="classes.*" %>
<script>

<%-- var isLogin = "<%=session.getAttribute("login_id")%>"; --%>
var link = location.href;

if (isLogin == null) {
	alert("로그인 후 이용해주세요.");
	location.href = "/admin/login";
}
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<head>
		<meta charset="utf-8"/>
		<title>Estien</title>
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
		<script src="/inc/js/function.js"></script>
		<link rel="stylesheet" href="/inc/css/admin.css">
	</head>
		<body>
		    <div id="header">
				<div class="header-wrap">
					<div class="logo"><a href="/main"><img src="/img/logo.png" alt="로고" /></a></div>
					<ul class="gnb-ul">
					    <li><a href="/admin/vision_list">광고관리</a></li>
						<li><a href="/admin/depth_list">분류관리</a></li>
					</ul>
					<div class="log-btn">
						<a href="logout.php">Logout</a>
					</div>
				</div>
		    </div>
	<div class="container">