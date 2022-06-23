<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>

function fncSubmit()
{
	// 품목
	var sel_cate = $(".bd").html();
	$("#cate").val(sel_cate);
	
	// 핸드폰번호
	var p1 = $("#phone1").val();
	var p2 = $("#phone2").val();
	var p3 = $("#phone3").val();
	
	var phone = p1 + "-" + p2 + "-" + p3;
	
	$("#phone").val(phone);
	
	// 메일
	var email1 = $("#mail1").val();
	var email2 = $("#mail2").val();
	var email = email1 + '@' + email2;
	
	$("#mail").val(email);
	
	// 유효성
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
	
	  if($('input:checkbox[id="check"]').is(":checked") != true ) 
	  {
		alert("개인정보 수집 동의 항목에 체크를 해주세요.");
		$('input:checkbox[id="check"]').focus(); 
		return;
	   }
	
	var validationFlag = "Y";
	
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
	    			location.href="/"; 
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
<div class="contact-form popup-wr">
	<div class="bg"></div>
	<div class="inner">
		<div class="inner-scroll scroll">
			<p class="pop-tit">Contact Us</p>
			<div class="form-wr">
				<form id="fncForm" name="fncForm" method="post" action="contact_proc" enctype="multipart/form-data">
				  	<input type="hidden" id="cate" name="cate"/>
				  	<input type="hidden" id="phone" name="phone"/>
					<input type="hidden" id="mail" name="mail"/>
					<ul class="form-ul cf">
						<li class="form-li">
							<strong>구분</strong>
							<div class="sel-wr rel">
								<button type="button" class="bd">구분</button>
	 								<div class="select-drop">
										<ul class="select-list cur-on">
											<li>투자문의</li>
											<li>채용문의</li>
											<li>기타</li>
										</ul>
									</div>
							</div>
						</li>
						<!-- //form-li -->
						<li class="form-li">
							<strong>제목</strong>
							<div class="inp-wr">
								<input class="bd" type="text" name="title" placeholder="제목을 입력하세요." class="notEmpty" data-name="제목"/>
							</div>
						</li>
						<!-- //form-li -->
						<li class="form-li inb email fl fz0">
							<strong>이메일</strong>
							<div class="inp-wr">
								<input class="bd" type="text" id="mail1" name="mail1" class="notEmpty" data-name="이메일"/>
								<span class="txt">@</span>
								<input class="bd" type="text" id="mail2" name="mail2" class="notEmpty" data-name="이메일"/>
							</div>
						</li>
						<!-- //form-li -->
						<li class="form-li inb phone fr fz0">
							<strong>연락처</strong>
							<div class="inp-wr">
								<input class="bd" type="text" id="phone1" name="phone1" class="notEmpty" data-name="연락처"/>
								<span class="txt">-</span>
								<input class="bd" type="text" id="phone2" name="phone2" class="notEmpty" data-name="연락처"/>
								<span class="txt">-</span>
								<input class="bd" type="text" id="phone3" name="phone3" class="notEmpty" data-name="연락처"/>
							</div>
						</li>
						<!-- //form-li -->
						<li class="form-li cb">
							<strong>내용</strong>
							<div class="inp-wr">
								<textarea class="bd notEmpty" name="conts" placeholder="내용을 입력하세요." data-name="내용"></textarea>
							</div>
						</li>
						<!-- //form-li -->
						<li class="form-li">
							<strong>파일첨부</strong>
							<div class="file-wr rel">
								<div class="filebox inb bd cur-on">
									<input type="text" class="bd" name="upload_name" id="upload_name" class="upload_name" placeholder="파일당 최대 10mb까지 등록할 수 있습니다." disabled>
									<label for="upload" class="addFile"></label>
									<span class="upload">
										<input type="file" id="upload" name="upload">
									</span>
								</div>
							</div>
						</li>
						<!-- //form-li -->
						<li class="form-li">
							<strong>개인정보 수집 동의</strong>
							<div class="inp-wr policy-wr">
								<div class="privacy-policy scroll">
									더웰스인베스트먼트(이하 "회사"라 합니다)는 귀하의 개인정보를 중요시하며,
									『정보통신망 이용촉진 및 정보보호 등에 관한 법률』, 『개인정보 보호법』, 『통신비밀보호법』,
									『전기통신사업법』 등 정보통신 서비스 제공자가 준수하여야 할 관련 법령상의 개인정보보호 규정을 준수하고 있습니다.
								</div>
								<input type="checkbox" id="check"/>
								<label for="check" class="cur-on">본인은 상기 언급한 개인정보의 수집 및 이용 내용에 대해 고지받았으며 위 내용을 모두 확인한 후 이에 동의합니다.</label>
							</div>
						</li>
						<!-- //form-li -->
					</ul>
				</form>
			</div>
			<div class="btn-box-wr">
				<a class="btn-box hover" onclick="javascript:fncSubmit();">
					<span class="line"></span>
					<span class="txt" >Send</span>
				</a>
			</div>
			<!-- //btn-box-wr -->
		</div>
		<!-- //form-wr -->
		<button class="close abs"><img src="/img/icon/close_btn.png" alt="close" /></button>
	</div>
</div>

<script>

	$(window).load(function(){
		
		// popup open / close 
		var popup = $('.contact-form'),
			obtn = $('#footer .contact-it'),
			cbtn = $('.close, .bg');
		
		obtn.click(function(){
			popup.addClass('on');
			$('body').addClass('popup-open');
			//if($('body').hasClass('main')){$('.main #header').css({'z-index':-1});}
		});
		cbtn.click(function(){
			popup.removeClass('on');
			$('body').removeClass('popup-open');
			//if($('body').hasClass('main')){$('.main #header').css({'z-index':999});}
		})
		
		// select box
		$('.sel-wr button').click(function(){
			if(!$('.select-list').hasClass('on')){
				$('.select-list').slideDown(500);
				$('.select-list').addClass('on')
			} else {
				$('.select-list').slideUp(500);
				$('.select-list').removeClass('on')				
			}
		})
		$('.select-list li').click(function(){
			$('.sel-wr button').text($(this).text())
			$('.select-list').slideUp(500);
			$('.select-list').removeClass('on')		
		})
		
		// 파일 업로드	
		$(".filebox").append("<div class='file_del inb'></div>");	// 파일 삭제 버튼 생성
		$(".file_del").hide();										// 삭제버튼 숨기기
		$("input[type=file]").on("change",function(){
			$(".file_del").show();									// 삭제버튼 보이기
			if(window.FileReader){  // modern browser
				var filename = $(this)[0].files[0].name;
			} 
			else {  // old IE
				var filename = $(this).val().split('/').pop().split('\\').pop();
			}
			$(this).parents(".filebox").find("#upload_name").val(filename);
		});
		
		// 파일 삭제
		$(".file_del").on("click",function(){
			$("#upload").val("");
			$("#upload_name").val("");
			$(".file_del").hide();	
		});
		
	});	
	
</script>

