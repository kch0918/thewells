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
	
    // 썸네일 이미지 업로드	
	$(".filebox.team_img .txtbox").append("<div class='file_del inb'></div>");	// 파일 삭제 버튼 생성
	$(".filebox.team_img .file_del").hide();									// 삭제버튼 숨기기
	$(".filebox.team_img input[type=file]").on("change",function(){
		$(".filebox.team_img .file_del").show();								// 삭제버튼 보이기
		$(".filebox.team_img .upload_name").addClass('active');	
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} 
		else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}
		$(this).parents(".filebox.team_img").find(".upload_name").val(filename);
	});
	// 파일 삭제
	$(".filebox.team_img .file_del").on("click",function(){
		$("#upload01").val("");
		$(".filebox.team_img .upload_name").val("");
		$(".filebox.team_img .file_del").hide();	
	});
   
	// 게시글 이미지 업로드	
	$(".filebox.logo_img .txtbox").append("<div class='file_del inb'></div>");
	$(".filebox.logo_img .file_del").hide();									// 삭제버튼 숨기기
	$(".filebox.logo_img input[type=file]").on("change",function(){
		$(".filebox.logo_img .file_del").show();								// 삭제버튼 보이기
		$(".filebox.logo_img .upload_name").addClass('active');	
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} 
		else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}
		$(this).parents(".filebox.logo_img").find(".upload_name").val(filename);
	});
	
	// 파일 삭제
	$(".filebox.logo_img .file_del").on("click",function(){
		$("#upload02").val("");
		$(".filebox.logo_img .upload_name").val("");
		$(".filebox.logo_img .file_del").hide();	
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
	     			location.href = '/admin/team/team_list';
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
	$("#team_nm_ko").val(repWord(nullChk('${data.team_nm_ko}')));
	$("#team_nm_en").val('${data.team_nm_en}');
	$("#thumb_img").val('${data.thumb_img}'); 
	$("#team_img").val('${data.team_img}'); 
	$('#cate_idx').val('${data.cate_idx}');
	$("#level_ko").val('${data.level_ko}');
	$("#level_en").val('${data.level_en}');
	$("#intro_ko").val('${data.intro_ko}');
	$("#intro_en").val('${data.intro_en}');
	$("#career_ko").val(repWord('${data.career_ko}'));
	$("#career_en").val(repWord('${data.career_en}'));
	$("#edu_ko").val(repWord('${data.edu_ko}'));
	$("#edu_en").val(repWord('${data.edu_en}'));
	$("input:radio[name='expo_yn']:radio[value='${data.expo_yn}']").prop('checked', true);
	$("input:radio[name='main_yn']:radio[value='${data.main_yn}']").prop('checked', true);
}

</script>
<div id="container" class="sub_page his_upload ptn_upload team_upload">
	<div class="info_txt">
		<ul>
			<li class="inb"><a href="/admin/team/team_cate">Our Team</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/team/team_list">팀원 리스트 관리</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/team/team_upload">팀원 등록/수정</a></li>
		</ul>
		<p>* 마지막 수정 : <span class="time">${data.edit_date2}</span></p>
	</div>
	<form id="fncForm" name="fncForm" action="/admin/team/team_upload_proc" method="post" enctype="multipart/form-data">
	<div class="contwrap scroll">
		<div class="wrap_inner">
			<div class="contbox">
				<div class="cont cont01">
					<div class="lt">
						<p class="tit kr">팀원 명 (국)*</p>
						<p class="tit en">팀원 명 (영)*</p>
					</div>
					<div class="rt">
						<p class="txtbox kr"><input id="team_nm_ko" name="team_nm_ko" class="notEmpty" data-name="팀원명" placeholder="팀원명을 입력해 주세요."></input></p>
						<p class="txtbox en"><input id="team_nm_en" name="team_nm_en" class="notEmpty" data-name="팀원명" placeholder="팀원명을 입력해 주세요."></input></p>
					</div>
				</div>
				<div class="cont cont02 tp">
					<div class="lt">
						<p class="tit">썸네일 이미지*</p>
					</div>
					<div class="rt">
						<div class="filebox team_img inb">
							<div class="txtbox">
								<input type="text" name="thumb_img" id="thumb_img" onchange="checkFile(this)" class="notEmpty upload_name" data-name="썸네일 이미지" placeholder="선택된 파일이 없습니다." disabled/>
							</div>
							<label for="upload01" class="file_btn">+ 이미지 첨부</label>
							<span class="upload">
								<input type="file" name="thumb_img" id="upload01" onchange="checkFile(this)" class="" data-name="썸네일 이미지">
							</span>
						</div>
						<div class="info_txt_box inb">
							<p class="info_txt">
								* PNG 파일로 등록해 주세요.<br/>
								* 최대 5MB의 이미지 파일을 등록할 수 있습니다.<br/>
								* 썸네일 이미지(320x320)와 게시글 이미지(400x400)는 사이즈에 맞춰 등록해 주세요.
							</p>
						</div>
					</div>
					
				</div>
				<div class="cont cont02 bt">
					<div class="lt">
						<p class="tit">게시글 이미지*</p>
					</div>
					<div class="rt">
						<div class="filebox logo_img inb">
							<div class="txtbox">
								<input type="text" name="team_img" id="team_img" onchange="checkFile(this)" class="notEmpty upload_name" data-name="게시글 이미지" placeholder="선택된 파일이 없습니다." disabled/>
							</div>
							<label for="upload02" class="file_btn">+ 이미지 첨부</label>
							<span class="upload">
								<input type="file" name="team_img" id="upload02" onchange="checkFile(this)" class="" data-name="게시글 이미지">
							</span>
						</div>
					</div>
				</div>
				<div class="cont cont02 cont03">
					<div class="lt">
						<p class="tit">소속 선택*</p>
					</div>
					<div class="rt rt_cate">
						<div class="cate_box">
							<span class="af_icon inb">
							    <select id="cate_idx" name="cate_idx" class="cate" de-data="선택하세요.">
									 <c:forEach var="i" items="${team_cate_list}" varStatus="loop">
										<option value="${i.idx}">${i.cate_nm}</option>
				 					 </c:forEach>
								</select>
							</span>
						</div>
					</div>
				</div>
				<div class="cont cont01 cont02">
					<div class="lt">
						<p class="tit kr">직함 (국)*</p>
						<p class="tit en">직함 (영)*</p>
					</div>
					<div class="rt">
						<p class="txtbox kr"><input id="level_ko" name="level_ko" class="notEmpty" data-name="직함" placeholder="팀원명을 입력해 주세요."></input></p>
						<p class="txtbox en"><input id="level_en" name="level_en" class="notEmpty" data-name="직함" placeholder="팀원명을 입력해 주세요."></input></p>
					</div>
				</div>
				<div class="cont cont01 cont02 cont06">
					<div class="lt">
						<p class="tit kr">짧은 자기소개 (국)*</p>
						<p class="tit en">짧은 자기소개 (영)*</p>
					</div>
					<div class="rt">
						<p class="txtbox kr"><input id="intro_ko" name="intro_ko" class="" data-name="자기소개" placeholder=""></input></p>
						<p class="txtbox en"><input id="intro_en" name="intro_en" class="" data-name="자기소개" placeholder=""></input></p>
					</div>
				</div>
				<div class="cont cont02 cont07 kr">
					<div class="lt">
						<p class="tit">경력 (국)</p>
					</div>
					<div class="rt">
<!-- 						<p class="txt"><input id="career_ko" name="career_ko" class="notEmpty" data-name="경력" placeholder="경력을입력해 주세요."></input></p> -->
						<textarea id="career_ko" name="career_ko" class="notEmpty txt scroll" data-name="경력" placeholder="경력을입력해 주세요."></textarea>
					</div>
				</div>
				<div class="cont cont07 en">
					<div class="lt">
						<p class="tit">경력 (영)</p>
					</div>
					<div class="rt">
<!-- 						<p class="txt"><input id="career_en" name="career_en" class="notEmpty" data-name="경력" placeholder="경력을 입력해 주세요."></input></p> -->
						<textarea id="career_en" name="career_en" class="notEmpty txt scroll" data-name="경력" placeholder="경력을입력해 주세요."></textarea>
					</div>
				</div>
				<div class="cont cont02 cont07 kr">
					<div class="lt">
						<p class="tit">학력 (국)</p>
					</div>
					<div class="rt">
<!-- 						<p class="txt"><input id="edu_ko" name="edu_ko" class="notEmpty" data-name="회사소개" placeholder="학력을 입력해 주세요."></input></p> -->
						<textarea id="edu_ko" name="edu_ko" class="notEmpty txt scroll" data-name="학력" placeholder="학력을 입력해 주세요."></textarea>
					</div>
				</div>
				<div class="cont cont07 en">
					<div class="lt">
						<p class="tit">학력 (영)</p>
					</div>
					<div class="rt">
<!-- 						<p class="txt"><input id="edu_en" name="edu_en" class="notEmpty" data-name="회사소개" placeholder="학력을 입력해 주세요."></input></p> -->
						<textarea id="edu_en" name="edu_en" class="notEmpty txt scroll" data-name="학력" placeholder="학력을 입력해 주세요."></textarea>
					</div>
				</div>
				<div class="cont cont02 cont08">
					<div class="lt">
						<p class="tit">노출여부</p>
					</div>
					<div class="rt">
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
					<div class="rt">
						<ul>
							<li class="inb mr">
								<input type="radio" id="show_Y" value="Y" name="main_yn" checked>
								<label for = "show_Y">
									<span>노출</span>
								</label>
							</li>
							<li class="inb">
								<input type="radio" id="show_N" value="N" name="main_yn">
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
				<a href="/admin/team/team_list">목록</a>
			</div>
			<div class="btn his_btn blue">
				<a onclick="javascript:fncSubmit();" >저장</a>
			</div>
		</div>
	</div>
	<input type="hidden" id="idx" name="idx" value=""/>
	</form>
</div>