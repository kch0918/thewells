<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/js/ckeditor/ckeditor.js"></script>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<script>
//추가 삭제 카운트 전역변수
var innerIdx = 0;

$(document).ready(function(){
  	var today = new Date();

  	var year = today.getFullYear();
  	var month = ('0' + (today.getMonth() + 1)).slice(-2);
  	var day = ('0' + today.getDate()).slice(-2);

  	var now_submit_date = year + month + day;
	
	CKEDITOR.replace('conts', {
		filebrowserUploadUrl : '/admin/ckeditor_upload'
	});
	
    // idx가 존재할시 init 호출
	if(nullChk('${idx}') != "")
	{
		init();
		$("#submit_date").val('${data.submit_date2}');
	}
	else
	{
	  	$("#submit_date").val(now_submit_date);
	}
  	
	var length = $('.fileLists').find(".input-file").length;
	$('.file-idx').text('');
	$('.file-idx').append(length);
   
});


//datepicker
$(function() {
	$(".datepicker").datepicker({
		dateFormat : 'yymmdd'
	});
}); 

// admin.js 클릭이벤트 참고
var fin_idx = "";

// 저장
function fncSubmit()
{
  	var vValue = $("#submit_date").val(); 
	var vValue_Num = vValue.replace(/[^0-9]/g, ""); 

	if (_fnToNull(vValue_Num) == "") 
	{ 
		alert("날짜를 입력 해 주세요."); 
		return false; 
	}
	
	//8자리가 아닌 경우 false 
	if (vValue_Num.length != 8) 
	{ 
		alert("날짜를 20220101 형식으로 입력 해 주세요."); 
		return false; 
	}

	//8자리의 yyyymmdd를 원본 , 4자리 , 2자리 , 2자리로 변경해 주기 위한 패턴생성을 합니다.
	var rxDatePattern = /^(\d{4})(\d{1,2})(\d{1,2})$/; 
	var dtArray = vValue_Num.match(rxDatePattern); 
	if (dtArray == null) 
	{ 
		return false; 
	}

	//0번째는 원본 , 1번째는 yyyy(년) , 2번재는 mm(월) , 3번재는 dd(일)
	dtYear = dtArray[1];
	dtMonth = dtArray[2]; 
	dtDay = dtArray[3]; 
	
	//yyyymmdd 체크 
	if (dtMonth < 1 || dtMonth > 12)
	{ 
		alert("존재하지 않은 월을 입력하셨습니다. 다시 한번 확인 해주세요"); 
		return false; 
	} 
	else if (dtDay < 1 || dtDay > 31) 
	{ 
		alert("존재하지 않은 일을 입력하셨습니다. 다시 한번 확인 해주세요");
		return false; 
	}
	else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31) 
	{ 
		alert("존재하지 않은 일을 입력하셨습니다. 다시 한번 확인 해주세요");
		return false; 
	} 
	else if (dtMonth == 2) 
	{ 
		var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0)); 
		if (dtDay > 29 || (dtDay == 29 && !isleap)) 
		{
			alert("존재하지 않은 일을 입력하셨습니다. 다시 한번 확인 해주세요"); 
			return false; 
		} 
	} 
	
	// 관련파트너사 검색어 
	var link_part_search = $("#part_result").text();

	// 관련파트너사 part_idx
	$("#fin_part_idx").val(fin_idx);
	
	$("#link_part").val(link_part_search);

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
	
	var imgNm="";
	$('.imgNm').each(function(){ 
		imgNm+=$(this).val()+"|";
	})
	
	 $('#imgNm').val(imgNm);
	
	// CKEDITOR 업데이트
	CKEDITOR.instances.conts.updateElement(); 	
	
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
	     			location.href = '/admin/news/news_list';
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
	
	var inner2 = "";
	var innerIdx2 = 0;
	var inner3 = "";
	$("#idx").val(nullChk('${data.idx}'));
	$("#submit_date").val('${data.submit_date2}');
	$("#cate_idx").val('${data.cate_idx}');
	$("#title").val(repWord(nullChk('${data.title}'))); 
	$("#conts").val(repWord(nullChk('${data.conts}')));
	$('#file').val('${data.file}');
	$("#url").val('${data.url}');
	$("#part_result").html('${data.link_part}');
	$("#part_idx").val('${data.link_part}');
	$("input:radio[name='expo_yn']:radio[value='${data.expo_yn}']").prop('checked', true);
	
	  if( '${data.top_yn}' == "Y")
	    {
		 	$("input[name='top_yn']").prop('checked', true);
		}
	var temp2 = '${data.file_ori}';
	var arr2 = temp2.split('|');
	

	for (var i = 0; i < arr2.length-1; i++) {

       inner2 = '<span id="filecont_'+(Number(i+2))+'" class="input-file inb">';
       inner2 += '	<input class="hide fileList " id="file_'+(Number(i+2))+'" type="file" name="file_upload_'+(Number(i+2))+'">';
       inner2 += '	<input class="hide filename imgNm" id="file_'+(Number(i+2))+'" type="text" name="file_upload_'+(Number(i+2))+' onchange="checkFile(this)" placeholder="파일 업로드" value="'+arr2[i]+'">';
       inner2 += '	<button type="button" class="mid-btn btn_d_type delete-btn inb" onclick="del_file('+(Number(i+2))+');"></button>';
       inner2 += '</span>';
       
       $('#fileLists').append(inner2);
		
	}
	
}

function part_search()
{
	var part_txt = $('#part_idx').val();
	
 	$.ajax({
		type : "POST", 
		url : "/admin/news/getSearchpart",
		dataType : "text",
		async : false,
		data : 
		{
			part_txt : part_txt
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					//inner += '<option value="'+result.list[i].idx+'">'+result.list[i].part_nm_ko+'</option>';
					inner += '<li id="link_part_name" class="partname" value="'+result.list[i].idx+'">'+result.list[i].part_nm_ko+'</li>';
				}
			}
			else
			{
				inner += '<option>검색결과가 없습니다.</option>';
			}
			
			$('#part_search2').html(inner);
			$('#result').html(inner);
			
		}
	}); 
	
}

var innerIdx = 0;
//상세이미지 항목 추가
function add_file(){
	
       innerIdx++;

       var inner = '';
   
       inner = '<span id="filecont_'+innerIdx+'" class="input-file inb">';
       inner += '	<input class="hide fileList " id="file_'+innerIdx+'" type="file" name="file_upload_'+innerIdx+'">';
       inner += '	<input class="hide filename imgNm" id="file_'+innerIdx+'" type="text" name="file_upload_'+innerIdx+' onchange="checkFile(this)" placeholder="파일 업로드">';
       inner += '	<button type="button" class="mid-btn btn_d_type delete-btn inb" onclick="del_file('+innerIdx+');"></button>';
       inner += '</span>';
       
       $('#fileLists').append(inner);
       $('#file_'+innerIdx+'').click();
}

// 파일업로드시 파일명
	$(document).on('change', 'input[type=file]', function(){
		$(".filename").addClass('active');	
		if(window.FileReader){  // modern browser
			var filename = $(this)[0].files[0].name;
		} 
		else {  // old IE
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}
		console.log(filename);
		$(this).next(".filename.active").val(filename);
	});
	
	
// 파일 5개 이상 업로드시 얼럿
$(function(){
	$('.addFile').on('click', function () {
		if(document.querySelectorAll(".input-file").length >= 5){
			alert("5개 이상 업로드할 수 없습니다.");
			return false;
		}
		add_file();
	});	
})

//파일첨부 숫자 반영 (증가)
$(document).on('click', '.addFile', function(){ 
	
	var length = $('.fileLists').find(".input-file").length;
		$('.file-idx').text('');
		$('.file-idx').append(length);
})

// 파일 삭제 및 파일첨부 숫자 반영 (감소)
function del_file(idx){

	$('#filecont_'+idx).remove();
	
	var length = $('.fileLists').find(".input-file").length;
	$('.file-idx').text('');
	$('.file-idx').append(length);
}

</script>
<div id="container" class="sub_page his_upload ptn_upload news_upload">
	<div class="info_txt">
		<ul>
			<li class="inb"><a href="/admin/news/news_cate">News</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/news/news_list">게시글 관리</a></li>
			<span class="divider">></span>
			<li class="inb"><a href="/admin/news/news_upload">게시글 등록/수정</a></li>
		</ul>
		<p>* 마지막 수정 : <span class="time">${data.edit_date2}</span></p>
	</div>
	<form id="fncForm" name="fncForm" action="/admin/news/news_upload_proc" method="post" enctype="multipart/form-data">
	<input type="hidden" id="link_part" name="link_part"/>
	<input type="hidden" id="fin_part_idx" name="fin_part_idx"/>
	<input type="hidden" id="imgNm" name="imgNm">
	<div class="contwrap scroll">
		<div class="wrap_inner">
			<div class="contbox">
				<div class="cont cont01">
					<div class="lt">
						<p class="tit kr">등록일</p>
					</div>
					<div class="rt">
                           <div class="date-select">
                           		<div class="date_box">
                               		<input type="text" id="submit_date" name="submit_date" class="datepicker input-calendar" autocomplete="off" data-name="등록일">
                               	</div> 
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
									 <c:forEach var="i" items="${news_cate_list}" varStatus="loop">
										<option value="${i.idx}">${i.cate_nm}</option>
				 					 </c:forEach>
								</select>
							</span>
						</div>
					</div>
				</div>
				<div class="cont cont01 cont02">
					<div class="lt">
						<p class="tit kr">제목*</p>
					</div>
					<div class="rt">
						<p class="txtbox kr"><input id="title" name="title" class="notEmpty" data-name="제목" placeholder="제목을 입력해 주세요."></input></p>
					</div>
				</div>
				<div class="cont cont02 kr">
					<div class="lt">
						<p class="tit">내용</p>
					</div>
					<div class="rt">
						<p class="txt">
							<textarea class="w_edit" id="conts" name="conts" style="width: 100%;"></textarea>
						</p>
						<div class="files">
							<div class="top inb">
								<input type="text" id="upload_name" class="upload_name file_bd" readonly="" value="파일첨부">
<!-- 								<button class="addFile" type="button" onclick="add_file();">파일첨부 <span class="file-idx">0</span>/5</button> -->
								<button class="addFile" type="button" onclick="">파일첨부 <span class="file-idx">0</span>/5</button>
							</div>
							<div id="fileLists" class="fileLists inb">
							</div>
						</div>
						<div class="info_txt_box inb">
							<p class="info_txt">
								* 최대 20MB의 파일을 등록할 수 있습니다.
							</p>
						</div>
					</div>
				</div>
				<div class="cont cont05">
					<div class="lt">
						<p class="tit">연결링크</p>
					</div>
					<div class="rt">
						<p class="txtbox"><input id="url" name="url" class="" data-name="연결링크" placeholder="URL을 입력해 주세요."></input></p>
					</div>
				</div>
				<div class="cont cont02 cont07 kr partname">
					<div class="lt">
						<p class="tit">관련 파트너사</p>
					</div>

					<div class="rt">
						<p class="txtbox inb">
							<input type="text" onkeyup="part_search()" id="part_idx" name="part_idx" class="part_search2" vlaue="" autocomplete="off">
						</p>
						<ul id="part_search2" class="scroll part_search2"></ul>
						<ul id="part_result" class="name_result inb"><span class="del_btn"></span></ul>
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
						<p class="tit">상단고정</p>
					</div>
					<div class="rt">
						<ul>
							<li class="inb mr">
								<input type="checkbox" id="show_Y" value="Y" name="top_yn">
								<label for = "show_Y">
									<span>고정</span>
								</label>
							</li>
						</ul>
					
					</div>
				</div>
			</div>
			<div class="btnset">
				<div class="btn his_btn">
					<a href="/admin/news/news_list">목록</a>
				</div>
				<div class="btn his_btn blue">
					<a onclick="javascript:fncSubmit();" >저장</a>
				</div>
			</div>
		</div>
		</div>
		<input type="hidden" id="idx" name="idx" value=""/>
	</form>
	</div>
	