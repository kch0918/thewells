<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<script>
$(document).ready(function(){
	getList();
	
	// 카테고리 순서 드래그 & 드랍
	$(".tb_div").sortable({
		update:function(event,ui){
			$(this).children().each(function(index){
				/* $(this).find('td').first().html(index+1); */
			});
		}
	});
});

var A = new Array();

function getList(){
	$.ajax({
		type : "POST", 
		url : "/admin/news/getNewsCateList",
		dataType : "text",
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			var inner2 = "";
			if(result.list.length > 0)
			{
				$("#depth_area").empty();
				$("#target_area").empty();
				var cate_cnt=0;
				var chk_flag_y="";
				var chk_flag_n="";
				var temp="";
				for(var i = 0; i < result.list.length; i++)
				{
					
					if (i==0) 
					{
						temp = result.list[i].idx;
					}
					
					cate_cnt=result.list[i].cate_cnt;
					cate_cnt < 10?cate_cnt='0'+cate_cnt:cate_cnt;
					
				    inner += '<div id="dep_target_'+result.list[i].idx+'" class="category_dep order_no">';
				    inner += '	<div id="cnt_'+result.list[i].idx+'" onclick="selCate(\''+result.list[i].idx+'\')" class="cate_icon"><img src="/img/admin/cate_icon.png"><span class="num">'+cate_cnt+'</span></div>';
					inner += '	<div class="dep_wrap">';
					inner += '		<div id="dep_'+result.list[i].idx+'_kor">'+result.list[i].cate_nm+'</div>';
					inner += '	</div>';
					inner += '</div>'; 
					
					
					chk_flag_y='';
					chk_flag_n='';
					
					result.list[i].show_yn=='Y'?chk_flag_y='checked':'';
					result.list[i].show_yn=='N'?chk_flag_n='checked':'';

					
					inner2 +='<div id="target_div_'+result.list[i].idx+'" class="target_div" style="display:none;">';
					inner2 +='	<div><span class="tit">국문 카테고리명</span> <input type="text" id="cate_kr_'+result.list[i].idx+'" value="'+result.list[i].cate_nm+'" class="cate_kr notEmpty" placeholder="카테고리명을 입력해주세요 " data-name="한글 카테고리명" onkeyup="javascript:cateTyping(\''+result.list[i].idx+'\');"></div>';
					inner2 +='	<div class="custom"><span class="tit">노출 여부</span> <ul class="inb">	<li class="inb mr">	<input type="radio" id="show_y_'+result.list[i].idx+'" name="show_yn_'+result.list[i].idx+'" value="Y" '+chk_flag_y+'><label for= "show_y_'+result.list[i].idx+'"><span class="txt">노출</span></label></li><li class="inb"><input type="radio" id="show_n_'+result.list[i].idx+'" name="show_yn_'+result.list[i].idx+'" value="N" '+chk_flag_n+'><label for= "show_n_'+result.list[i].idx+'"><span class="txt">미노출</span></label></li></ul></div>';	
					inner2 += '	<div class="del_btnwrap">';	
					inner2 += '		<input type="button" value="카테고리 삭제" class="del_btn" onclick="delNewsCate(\''+result.list[i].idx+'\')">';
					inner2 += '	</div>';
					inner2 +='</div>';
					
					A.push(result.list[i]);
					console.log(A);
				}
				
				$("#depth_area").html(inner);
				$("#target_area").html(inner2);
			

				$('#target_div_'+temp).show();
				
			}
		}
	});	 
}

//카테고리 추가
function insNewsCate()
{
	$.ajax({
		type : "POST", 
		url : "/admin/news/insNewsCate",
		dataType : "text",
		async : false,
		data : 
		{
			show_yn : "N",
			sort_no : $('.category_dep').length
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			getList();
			$("#cate_nm").val('');
			$("#cate_nm_en").val('');
			$('.cata_length').text('0/10자'); 	
		}
	});	 
}

//카테고리 삭제
function delNewsCate(idx)
{
	var cnt = $("#cnt_"+idx+"").text();

	if(cnt > 0)
	{
		alert("카테고리 안에 게시물이 있어서 삭제 불가");
	}
	else
	{
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				type : "POST", 
				url : "/admin/news/delNewsCate",
				dataType : "text",
				async:false,
				data : 
				{
					idx : idx
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
		    			$('#dep_target_'+idx).remove();
		    		}
				}
			});	
		}
	}
}


//카테고리 선택
function selCate(idx)
{
	$('.target_div').hide();
	$('#target_div_'+idx).show();		
}

//저장

function fncSubmit()
{
	var isSuc = true;
 	var fin_idx = "";
	var fin_cate_kor = "";
	var fin_show_yn  = "";
	var fin_sort = "";
	
	for (var i = 0; i < A.length; i++) {
		fin_idx 	 +=  A[i].idx + "|";
		fin_cate_kor +=  $("#cate_kr_"+A[i].idx).val() + "|"; 
		$('#show_y_'+A[i].idx).prop('checked')==true?fin_show_yn+='Y'+"|":fin_show_yn+='N'+ "|";
		fin_sort 	 +=  A[i].sort + "|";
	}
	
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
		$.ajax({
			type : "POST", 
			url : "/admin/news/saveCate",
			dataType : "text",
			data : 
			{
				idx 	: fin_idx,
				cate_kr : fin_cate_kor,
				is_show : fin_show_yn, 
				sort 	: fin_sort
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
		   		if(result.isSuc != "success")
		   		{
		   			isSuc = false;
		   		}
			}
		}) 	  
	
		if(isSuc)
		{
			alert("저장되었습니다.");
			location.reload();
		}
		else
		{
			alert("오류가 발생하였습니다.");
		}
	}
}

//한글 카테고리명 타미핑시 목록
function cateTyping(idx)
{
	var tmp = $("#cate_kr_"+idx).val();
	$("#dep_"+idx+"_kor").html(tmp);
}

//양문 카테고리명 타미핑시 목록
function cateTyping2(idx)
{
	var tmp = $("#cate_en_"+idx).val();
	$("#dep_"+idx+"_eng").html(tmp);
}

//순서저장
function save_pr_cate(){
	
	var idx_arr="";
	var order_no="";
	var cnt=0;
	
	$('.order_no').each(function(){ 
		cnt++;
		idx_arr  +=	$(this).attr('id').split('_')[2]+'|';
		order_no += cnt+"|";
	})

  	$.ajax({
		type : "POST", 
		url : "/admin/news/upOrder_cate",
		dataType : "text",
		data : 
		{
			idx_arr : idx_arr,
			order_no : order_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			
			
			if($("#cate").val() == "main")
			{
				goMainExpo();
			}
			else
			{
				getList();
			}
		}
	});  
	
}


</script>
<div id="container" class="sub_page part_cate news_cate">	
	<div class="top_cont">	
		<div class="info_txt">	
			<ul>	
				<li class="inb"><a href="/admin/news/news_cate">news</a></li>	
				<span class="divider">></span>	
				<li class="inb"><a href="/admin/news/news_cate">카테고리 관리</a></li>	
			</ul>	
			<p>* 마지막 수정 : <span class="time">${cate_update[0].edit_date2}</span></p>	
		</div>	
	</div>
	<div class="contwrap scroll">	
	   	<div class="admin-cont wrap_inner">	
			<div class="cate-wrapper">	
			    <div class="cate-left inb">	
			    	<div class="category-btn">	
				         <ul>	
				         	<li class="inb">카테고리</li>	
				            <li class="inb"><button onclick="javascript:insNewsCate();" class="small-btn"></button></li>	
				        </ul>	
				    </div>	
				    <div class="category-list">	
					    <div id="depth_area" class="tb_div"></div>	
				    </div>	
		    	</div>	
				<div class="cate-right inb">	
					<div id="target_area">	
					</div>	
					 <div class="btn-wrap">	
						<button onclick="javascript:save_pr_cate();" class="btn btn_b_type">순서 저장</button>
						<button onclick="javascript:fncSubmit();" class="btn btn_b_type">변경사항 저장</button>	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
