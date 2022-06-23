<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title>The Wells Investment</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
		<!-- <link rel="stylesheet" type="text/css" href="/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="/css/mu_admin.css"/> -->
		<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
		<script type="text/javascript" src="/js/function.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
		<link rel="stylesheet" href="/css/common.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
		<script src="https://malsup.github.io/min/jquery.form.min.js"></script>
		<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
		<script>
			function enter_check_login()
			{
				if(event.keyCode == 13){
					login();
					return;
				}
			}
			
			function fncSubmit()
			{
				var validationFlag = "Y";
				$(".notEmpty").each(function() 
				{
					if ($(this).val() == "") 
					{
						alert(this.dataset.name+"을(를) 입력해주세요.");
						$(this).focus();
						validationFlag = "N";
						return false;
					}
				});
				
				if(validationFlag == "Y")
				{
					$("#fncForm").ajaxSubmit({
						success: function(data)
						{
							console.log(data);
							var result = JSON.parse(data);
				    		if(result.isSuc == "success")
				    		{
				    			alert('환영합니다')
				    			location.href="/admin/users/intro";
				    		}
				    		else
				    		{
				    			alert(result.msg);
				    		}
						}
					});
				}
			}
		</script>
	</head>
	<body>
		<div class="login_wrap">
			<div class="page_login">
				<div class="inner">
					<div class="logo"><img src="/img/admin/logo.png" /></div>
					<form id="fncForm" name="fncForm" method="post" action="/admin/users/login_proc">
						<div class="log-line">
							<input type="text" data-name="아이디" id="login_id" name="login_id" class="notEmpty btn" placeholder="아이디" />
							<input type="password" data-name="비밀번호" id="login_pw" name="login_pw" class="notEmpty btn" onkeypress="excuteEnter(fncSubmit)" placeholder="비밀번호" />
						</div>  
						<input type="button" onclick="fncSubmit()" value="로그인" class="btn_login btn"/>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>

<jsp:include page="/WEB-INF/pages/common_admin/admin_footer.jsp"/>