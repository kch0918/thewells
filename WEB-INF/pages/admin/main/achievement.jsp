<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<script>
$(document).ready(function(){
	$("#year").val(comma('${data.year}'));
	$("#finance").val(comma('${data.finance}'));
	$("#finance_en").val(comma('${data.finance_en}'));
	$("#partners").val(comma('${data.partners}'));
	$("#team").val(comma('${data.team}'));
});
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
	    		 	alert(result.msg);
	    			location.href="/admin/main/achievement";
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
<div id="container" class="sub_page achieve">
	<div class="info_txt" id="breadcrumbs">
		<ul>
			<li class="inb"><a href="/admin/users/intro">Main</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/main/achievement">업적관리</a></li>
		</ul>
		<p>* 마지막 수정 : <span class="time">${data.submit_date2}</span></p>
	</div>
	<form id="fncForm" name="fncForm" method="post" action="./achieve_proc">
		<div class="contwrap">
			<div class="wrap_inner scroll">
				<div class="contbox">
					<div class="cont">
						<p class="tit">설립연도</p>
						<span><input type="text" id="year" name="year" class="notEmpty" placeholder="0000" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" data-name="설립연도"></input><span>년</span></span>
						<p class="txt">* 0자리 숫자를 입력해 주세요.</p>
					</div>
					<div class="cont">
						<div class="tit c_btn">
							운용자산
							<div class="add_box">
								<span class="add_btn kr inb">국문</span>
								<span class="add_btn en inb">영문</span>
							</div>
						</div>
						<span class="won"><input type="text" id="finance" name="finance" class="notEmpty" placeholder="0000" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" data-name="운용자산"></input><span>억원</span></span>
						<span class="dollar"><input type="text" id="finance_en" name="finance_en" class="notEmpty" placeholder="0000" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" data-name="운용자산"></input><span> M$</span></span>
						<p class="txt">* 0자리 숫자를 입력해 주세요.</p>
					</div>
					<div class="cont">
						<p class="tit">파트너사</p>
						<span><input type="text" id="partners" name="partners" class="notEmpty" placeholder="0000" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" data-name="파트너사"></input><span>개</span></span>
						<p class="txt">* 0자리 숫자를 입력해 주세요.</p>
					</div>
					<div class="cont">
						<p class="tit">투자전문가</p>
						<span><input type="text" id="team" name="team" class="notEmpty" placeholder="0000" value="" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" data-name="투자전문가"></input><span>명</span></span>
						<p class="txt">* 0자리 숫자를 입력해 주세요.</p>
					</div>
				</div>
				<div class="btn">
			   		<a onclick="javascript:fncSubmit();" class="">저장</a>
				</div>
			</div>
		</div>
	</form>
</div>