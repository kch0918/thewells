<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<script>
$(document).ready(function(){
	
    // idx가 존재할시 init 호출
	if(nullChk('${idx}') != "")
	{
		init();
	}
});

// 저장
function fncSubmit()
{
	// 유효성
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
	     			location.href = '/admin/aboutus/history_list';
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});    
	}
}

// 조회,수정
function init() {
	
	$("#idx").val(nullChk('${data.idx}'));
	$("#year").val('${data.year}');
	$("#month").val('${data.month}');
	$("#conts_ko").val(repWord(nullChk('${data.conts_ko}')));
	$("#conts_en").val(repWord(nullChk('${data.conts_en}')));
	$("#edit_date").val('${data.edit_date2}');
}

</script>

<div id="container" class="sub_page his_upload">
	<div class="info_txt">
		<ul>
			<li class="inb"><a href="/admin/aboutus/history_list">About Us</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/aboutus/history_list">History 관리</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/aboutus/history_upload">연혁 등록/수정</a></li>
		</ul>
		<c:choose>  
			<c:when test="${idx eq null}"> 
				<p>* 마지막 수정 : <span id="" class="time">2021-00-00 00:00:00</span></p>
			</c:when> 
			<c:otherwise> 
				<p>* 마지막 수정 : <span id="edit_date" class="time">${data.edit_date2}</span></p>
			</c:otherwise> 
		</c:choose>
	</div>
	<form id="fncForm" name="fncForm" action="/admin/aboutus/history_upload_proc" method="post">
	<div class="contwrap">
		<div class="wrap_inner">
			<div class="contbox">
				<div class="cont">
					<div class="lt">
						<p class="tit">연도/월</p>
					</div>
					<div class="rt">
						<span><input type="number"  id="year" name="year" class="notEmpty" placeholder="숫자로 연도를 입력해 주세요." onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" data-name="연도"></span>
						<div class="inb">
							<select id="month" name="month">
								<option value="1">1월</option>
								<option value="2">2월</option>
								<option value="3">3월</option>
								<option value="4">4월</option>
								<option value="5">5월</option>
								<option value="6">6월</option>
								<option value="7">7월</option>
								<option value="8">8월</option>
								<option value="9">9월</option>
								<option value="10">10월</option>
								<option value="11">11월</option>
								<option value="12">12월</option>
							</select>
						</div>
					</div>
				</div>
				<div class="cont cont02">
					<div class="lt mt">
						<p class="tit">내용 (국)</p>
					</div>
					<div class="rt">
						<p class="txt"><textarea id="conts_ko" name="conts_ko" placeholder="내용을 입력해 주세요."></textarea></p>
					</div>
				</div>
				<div class="cont cont02 en">
					<div class="lt mt">
						<p class="tit">내용 (영)</p>
					</div>
					<div class="rt">
						<p class="txt"><textarea id="conts_en" name="conts_en" placeholder="내용을 입력해 주세요."></textarea></p>
					</div>
				</div>
			</div>
		</div>
		<div class="btnset">
			<div class="btn his_btn">
				<a href="/admin/aboutus/history_list">목록</a>
			</div>
			<div class="btn his_btn blue">
				<a onclick="javascript:fncSubmit();" class="bt_cont bt_c">저장</a>
			</div>
		</div>
	</div>
	<input type="hidden" id="idx" name="idx" value=""/>
	</form>
</div>