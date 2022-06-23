<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<script>
$(document).ready(function(){
	// 전체체크
	$("#chk_all").change(function() {
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", false);
		}
	});

	// 리스트
	getList();
 
});

function getList() 
{
	$.ajax({
		type : "POST", 
		url : "/admin/aboutus/getHisList",
		dataType : "text",
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<ul>';
					inner += '<li class="list">';
					inner += '<div class="date"><span><input type="checkbox" id="chk_'+result.list[i].idx+'" class="chk_cnt" name="chk_val" value="" onclick="get_chk_cnt();"><label for="chk_'+result.list[i].idx+'"></label></span>';
					inner += '<p>'+result.list[i].year+'년<br/>'+result.list[i].month+'월</p>';
					inner += '</div>';
					inner += '<div class="ko_cont">';
					inner += '	<p class="tit">국문</p>';
					inner += '	<p class="txt">'+result.list[i].conts_ko+'</p>';
					inner += '</div>';
					inner += '<span class="bar"></span>';
					inner += '<div class="ko_cont">';
					inner += '	<p class="tit">영문</p>';
					inner += '	<p class="txt">'+result.list[i].conts_en+'</p>';
					inner += '</div>';
					inner += '<div class="list_btn">';
					inner += '	<a href="#"><img src="/img/admin/list_icon.png" alt="" onclick="javascript:location.href=\'./history_upload?idx='+result.list[i].idx+'\'"/></a>';
					inner += '</div>';
					inner += '</li>';
					inner += '</ul>';
				}
			}
			
			$(".cont02").html(inner);
			$('#totalNum').text("0"+result.listCnt+"개");
		}
	});	
}

//메인베너삭제
function delHistoryList()
{
	var chkIdx = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkIdx += '\''+$(this).attr("id").replace("chk_", "")+"\',";
		}
	});
	if(chkIdx == "")
	{
		alert("선택된 항목이 없습니다.");
		return;
	}
	
	if(confirm("정말 삭제하시겠습니까?"))
	{
		$.ajax({
			type : "POST", 
			url : "/admin/aboutus/delHistoryList",
			dataType : "text",
			async : false,
			data : 
			{
				idx : chkIdx,
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			getList();
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});	
	}
}

function get_chk_cnt(all){
	var chk_cnt=0;
	if (nullChk(all)=='') 
	{
		$('.chk_cnt').each(function(){ 
			if ($(this).prop('checked')===true) 
			{
				chk_cnt++;
			}
		})
	}
	else if( $('#chk_all').prop('checked')===true) 
	{
		chk_cnt = $('.chk_cnt').length;			
	}
	
	$('#selNum').text( chk_cnt < 10 ? "0"+chk_cnt : chk_cnt);
}

</script>
<div id="container" class="sub_page his_list scroll">
	<div class="sub_page_inner">
		<div class="info_txt">
			<ul>
				<li class="inb"><a href="/admin/aboutus/history_list">About Us</a></li>
				<span class="divider">></span>
				<li class="inb"><a href="/admin/aboutus/history_list">History 관리</a></li>
			</ul>
			<p>* 마지막 수정 : <span class="time">${list_one[0].edit_date2}</span></p>
		</div>
		<div class="contwrap">
			<div class="wrap_inner scroll">
				<div class="contbox">
					<div class="cont01">
						<span class="result">
							<input type="checkbox" id="chk_all" name="chk_all" class="regular-radio" value="chk_val" onclick="get_chk_cnt('all');"/><label for="chk_all"></label>
						</span>
						<span id="selNum" class="inb">00</span><span class="inb">/</span><span id="totalNum" class="inb"></span>
					</div>
					<div class="cont02">
					
						<ul>
							<li class="list">
								<div class="date">
									<span>
										<input type="checkbox" id="check" />
										<label for="check"></label>
									</span>
									<p>
										2021년<br />
										2월
									</p>
								</div>
								<div class="ko_cont">
									<p class="tit">
										국문
									</p>
									<p class="txt">
										솔루션 캐피탈 제 3호 투자조합 결성<br />
										더웰스-클레어보이언트IP기술사업화 투자조합 결성
									</p>
								</div>
								<span class="bar"></span>
								<div class="en_cont">
									<p class="tit">
										영문
									</p>
									<p class="txt">
									Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod<br />
									tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. 
									</p>
								</div>
								<div class="list_btn">
									<a href="#"><img src="/img/admin/list_icon.png" alt="" /></a>
								</div>
							</li>
						</ul>
						
					</div>
				</div>
			</div>
			<div class="cont03">
				<div class="del_btn inb">
					<a onclick="delHistoryList();">선택 삭제</a>
				</div>
				<div class="btn his_btn">
					<a href="/admin/aboutus/history_upload">연혁 등록</a>
				</div>
			</div>
		</div>
	</div>
</div>