<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<script>
//추가 삭제 카운트 전역변수
var innerIdx = 0;

$(document).ready(function(){
	
    // idx가 존재할시 init 호출
	if(nullChk('${idx}') != "")
	{
		init();
	}
    
	// 파일 업로드	
	$(".filebox .txtbox").append("<div class='file_del inb'></div>");	// 파일 삭제 버튼 생성
	$(".file_del").hide();									// 삭제버튼 숨기기
	$("input[type=file]").on("change",function(){
		$(".file_del").show();								// 삭제버튼 보이기
		$(".upload_name").addClass('active');	
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} 
		else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}
		$(this).parents(".filebox").find(".upload_name").val(filename);
	});
	
	// 파일 삭제
	$(".file_del").on("click",function(){
		$("#upload").val("");
		$(".upload_name").val("");
		$(".file_del").hide();	
	});
    
	// 노출여부 미노출 시 메인노출여부 N 
    $("#noshow").change(function(){
    	$("#show_N").prop('checked', true);
    });
	
    $("#show_Y").on('click',function(){
    	if($('#noshow').prop("checked"))
    	{
    		alert("노출여부 값을 변경해주세요");
    		return false;
    	}
    })
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
	
	var cate_len = $(".cate_box").length;
	var cate_sel_idx = "";
	var cate_sel_one = $("#cate_idx").val();
	
	if(cate_len > 1)
	{	
		for(var i=0; i < document.fncForm.cate_idx.length; i++)
		{
			cate_sel_idx += document.fncForm.cate_idx[i].value + "|";
		}
		
		$("#cate_idx_arr2").val(cate_sel_idx);
	}
	else
	{
		$("#cate_idx_arr2").val($("#cate_idx1").val());

	}
 	
	if($('#check').is(':checked'))
	{
		$("#ret_yn").val("Y");
	}
	else
	{
		$("#ret_yn").val("N");
	}
	
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
	    			location.href='/admin/partners/partners_list';
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
	$("#part_nm_ko").val(repWord(nullChk('${data.part_nm_ko}')));
	$("#part_nm_en").val('${data.part_nm_en}');
	// 카테고리 조회
	var temp = '${data.cate_idx}';
	var arr = temp.split('|');
	innerIdx = 0;
	if (arr.length > 1) 
	{
		$('#cate_idx').val(arr[0]);
		
		var inner='';
		var chk_flag="";
		for (var i = 0; i < arr.length; i++) {
			if (nullChk(arr[i])!='') 
			{
				innerIdx++;
			    inner += '<div id="cate_box_'+innerIdx+'" class="cate_box">';
			    inner += '	<span class="af_icon inb">';
			    inner += '		<select id="cate_idx'+innerIdx+'" name="cate_idx" class="cate" de-data="선택하세요." value='+arr[i]+'>';
			    inner += '			<c:forEach var="i" items="${partner_cate_list}" varStatus="loop">';
			    if ("${i.idx}"==arr[i]) 
			    {
			    	chk_flag='selected';
			    }
			    else
			    {
			    	chk_flag='';
			    }
			    inner += '				<option value="${i.idx}" '+chk_flag+'>${i.cate_nm}</option>';
			    inner += '			</c:forEach>';
			    inner += '		</select>';
			    inner += '	</span>';
			    inner += '	<div class="add_box inb">';
			    if (i==0) 
			    {					
					inner +='<a class="add_btn" onclick="javascript:addCate();">+ 추가</a>';
			    }
			    else
			    {
			    	inner += '		<a class="add_btn del_btn" onclick="javascript:delCate('+innerIdx+');">- 삭제</a>';
			    	
			    }
			    
			    inner += '	</div>';
			    inner += '</div>';
			   	
			}
		}
		$('.rt_cate').html(inner);
	}
	else
	{
		$('#cate_idx1').val('${data.cate_idx}');
	}
	
	$("#test").val('${data.logo_img}'); 
	$("#url").val('${data.url}');
	$("#inv_year").val('${data.inv_year}');
	$("#inv_month").val('${data.inv_month}');
    if( '${data.return_yn}' == "Y")
    {
	 	$("input[name='return_yn']").prop('checked', true);
	}
    
    $("#corp_nm_ko").val(repWord(nullChk('${data.corp_nm_ko}'))); 
    $("#corp_nm_en").val(repWord(nullChk('${data.corp_nm_en}'))); 
	$("input:radio[name='expo_yn']:radio[value='${data.expo_yn}']").prop('checked', true);
	$("input:radio[name='main_expo']:radio[value='${data.main_expo}']").prop('checked', true);
}


// 카테고리 추가
function addCate()
{
	var inner = '';
	innerIdx++;
    inner += '<div class="cate_box" id="cate_box_'+innerIdx+'">';
    inner += '	<span class="af_icon inb">';
    inner += '		<select id="cate_idx'+innerIdx+'" name="cate_idx" class="cate" de-data="선택하세요.">';
    inner += '			<c:forEach var="i" items="${partner_cate_list}" varStatus="loop">';
    inner += '				<option value="${i.idx}">${i.cate_nm}</option>';
    inner += '			</c:forEach>';
    inner += '		</select>';
    inner += '	</span>';
    inner += '	<div class="add_box inb">';
    inner += '		<a class="add_btn del_btn" onclick="javascript:delCate('+innerIdx+');">- 삭제</a>';
    inner += '	</div>';
    inner += '</div>';
    
    $('.rt_cate').append(inner);
}


// 22.03.23 금송 : 카테고리 3개 이상 추가시 얼럿 
$(function(){
	$('.add_btn').on('click', function () {
		if(document.querySelectorAll(".cate_box").length >= 3){
			alert("3개 이상 업로드할 수 없습니다.");
			return false;
		} 
		addCate();		
	});	
})


// 카테고리 삭제
function delCate(idx)
{
	$('#cate_box_'+idx).remove();
}



</script>
<div id="container" class="sub_page his_upload ptn_upload">
	<div class="info_txt">
		<ul>
			<li class="inb"><a href="/admin/partners/partners_cate">Partners</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/partners/partners_list">파트너사 리스트 관리</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/partners/partners_upload">파트너사 등록/수정</a></li>
		</ul>
		<p>* 마지막 수정 : <span class="time">${data.edit_date2}</span></p>
	</div>
	<form id="fncForm" name="fncForm" action="/admin/partners/partners_upload_proc" method="post" enctype="multipart/form-data">
	<input type="hidden" id="cate_idx_arr2" name="cate_idx_arr2" />
	<input type="hidden" id="ret_yn" name="ret_yn" />
	<div class="contwrap scroll">
		<div class="wrap_inner">
			<div class="contbox">
				<div class="cont cont01">
					<div class="lt">
						<p class="tit kr">파트너사 명 (국)*</p>
						<p class="tit en">파트너사 명 (영)*</p>
					</div>
					<div class="rt">
						<p class="txtbox kr"><input id="part_nm_ko" name="part_nm_ko" class="notEmpty" data-name="파트너사명" placeholder="파트너사 명을 입력해 주세요."></input></p>
						<p class="txtbox en"><input id="part_nm_en" name="part_nm_en" class="notEmpty" data-name="파트너사명" placeholder="파트너사 명을 입력해 주세요."></input></p>
					</div>
				</div>
				<div class="cont cont02 cont03">
					<div class="lt">
						<p class="tit">로고 이미지*</p>
					</div>
					<div class="rt">
						<div class="filebox inb">
							<div class="txtbox">
								<input type="text" name="logo_img" id="test" onchange="checkFile(this)" class="notEmpty upload_name" data-name="로고 이미지" placeholder="선택된 파일이 없습니다." disabled/>
							</div>
							<label for="upload" class="file_btn">+ 이미지 첨부</label>
							<span class="upload">
								<input type="file" name="logo_img" id="upload" onchange="checkFile(this)" class="" data-name="로고 이미지">
							</span>
						</div>
						<div class="info_txt_box inb">
							<p class="info_txt">
								* PNG 파일로 등록해 주세요.<br/>
								* 최대 500KB의 이미지 파일을 등록할 수 있습니다.<br/>
								* 이미지의 가로 사이즈는 150px 이상으로 등록해 주세요.
							</p>
						</div>
					</div>
				</div>
				<div class="cont cont02 cont03">
					<div class="lt">
						<p class="tit">카테고리 선택*</p>
					</div>
					<div class="rt rt_cate">
						<div class="cate_box">
							<span class="af_icon inb">
							    <select id="cate_idx1" name="cate_idx" class="cate" de-data="선택하세요.">
									 <c:forEach var="i" items="${partner_cate_list}" varStatus="loop">
										<option value="${i.idx}">${i.cate_nm}</option>
				 					 </c:forEach>
								</select>
							</span>
							<div class="add_box inb">
<!-- 								<a class="add_btn" onclick="javascript:addCate();">+ 추가</a> -->
								<a class="add_btn">+ 추가</a>
							</div>
						</div>
					</div>
				</div>
				<div class="cont cont02 cont04">
					<div class="lt">
						<p class="tit">홈페이지 링크</p>
					</div>
					<div class="rt">
						<p class="txtbox"><input id="url" name="url" placeholder="URL을 입력해 주세요." class="" data-name="URL"></input></p>
					</div>
				</div>
				<div class="cont cont02 cont05">
					<div class="lt">
						<p class="tit">투자시기</p>
					</div>
					<div class="rt">
						<span><input type="number" id="inv_year" name="inv_year" placeholder="투자 연도를 입력해 주세요." onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" class="notEmpty" data-name="투자 연도"></span>
						<span class="af_icon">
							<select id="inv_month" name="inv_month">
								<option value="투자월을 선택해 주세요.">투자월을 선택해 주세요.</option>
								<option value="1월">1월</option>
								<option value="2월">2월</option>
								<option value="3월">3월</option>
								<option value="4월">4월</option>
								<option value="5월">5월</option>
								<option value="6월">6월</option>
								<option value="7월">7월</option>
								<option value="8월">8월</option>
								<option value="9월">9월</option>
								<option value="10월">10월</option>
								<option value="11월">11월</option>
								<option value="12월">12월</option>
							</select>
						</span>
					</div>
				</div>
				<div class="cont cont02 cont06">
					<div class="lt">
						<p class="tit">회수정보</p>
					</div>
					<div class="rt">
						<span class="inb">
							<input type="checkbox" id="check" name="return_yn">
							<label for="check"></label>
						</span>
						<span class="inb txt">회수완료</span>
					</div>
				</div>
				<div class="cont cont02 cont07 kr">
					<div class="lt">
						<p class="tit">회사소개 (국)</p>
					</div>
					<div class="rt">
						<textarea id="corp_nm_ko" name="corp_nm_ko" class="notEmpty txt scroll" data-name="회사소개" placeholder="회사소개를 입력해 주세요."></textarea>
					</div>
				</div>
				<div class="cont cont07 en">
					<div class="lt">
						<p class="tit">회사소개 (영)</p>
					</div>
					<div class="rt">
						<textarea id="corp_nm_en" name="corp_nm_en" class="notEmpty txt scroll" data-name="회사소개" placeholder="회사소개를 입력해 주세요."></textarea>
					</div>
				</div>
				<div class="cont cont02 cont08">
					<div class="lt">
						<p class="tit">노출여부</p>
					</div>
					<div class="rt custom">
						<ul>
							<li class="inb mr">
								<input type="radio" id="show" value="Y" name="expo_yn" checked>
								<label for = "show">
									<span>노출</span>
								</label>
							</li>
							<li class="inb">
								<input type="radio" id="noshow" value="N" name="expo_yn">
								<label for = "noshow">
									<span>미노출</span>
								</label>
							</li>
						</ul>
					</div>
				</div>
				<div class="cont cont02 cont08 cont09">
					<div class="lt">
						<p class="tit">메인 노출여부</p>
					</div>
					<div class="rt custom">
						<ul>
							<li class="inb mr">
								<input type="radio" id="show_Y" value="Y" name="main_expo" checked>
								<label for = "show_Y">
									<span>노출</span>
								</label>
							</li>
							<li class="inb">
								<input type="radio" id="show_N" value="N" name="main_expo">
								<label for = "show_N">
									<span>미노출</span>
								</label>
							</li>
						</ul>
					
					</div>
				</div>
			</div>
		</div>
		<div class="btnset">
			<div class="btn his_btn">
				<a href="/admin/partners/partners_list">목록</a>
			</div>
			<div class="btn his_btn blue">
				<a onclick="javascript:fncSubmit();" >저장</a>
			</div>
		</div>
	</div>
	<input type="hidden" id="idx" name="idx" value=""/>
	</form>
</div>