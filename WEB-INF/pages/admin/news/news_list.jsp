<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>

<script>
$(document).ready(function(){
	
	/* setSearchDate('1y'); */
	
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
	
    $("#cate").change(function() { 
    	  var sel_cate_val = $("#cate").val();
    	 
  	  	  	goCate(sel_cate_val);
  	  	  
   	  });
	
   $(".datepicker").datepicker({
        dateFormat: 'yy-mm-dd',
        changeDate: true,
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).val($.datepicker.formatDate('yy-mm-dd', new Date(year, month, date)));
           
        }
    });


    $(".datepicker").focus(function () {
//         $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });
    });
});

// 메인파트너스목록 
function getList(order) 
{
	setCookie('cate_cookie_admin',$('#cate').val());     
	setCookie("page", page);
	setCookie("order_by", order_by);
	
	var order = 'desc';
	
	if (nullChk(order)!='') 
	{
		order_by = $("#order_by").val();
	}
	
	$.ajax({
		type : "POST", 
		url : "/admin/news/getNewsList",
		dataType : "text",
		data : 
		{
			search_name  :  $("#search_name").val(),
 			cate_idx 	 :  $("#cate").val(),
 			page 	 	 :  page,
			order_by 	 :  order_by,
			listSize 	 :  "20",
		}, 
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$('#searchNum').text(result.listCnt);
			$('#totalNum').text(result.listCnt_all);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner+='<tr id="order_'+result.list[i].idx+'" class="order_no">';
					inner += '	<td>';
					inner += '		<span class="input-chkbox noMargin"><input type="checkbox" id="chk_'+result.list[i].idx+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].idx+'"></label>';
					inner += '		<input type="hidden" id="idx_'+result.list[i].idx+'" name="idxs"></span>';
					inner += '	</td>';
					inner += '	<td>'+[i+1]+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					
					if(nullChk(result.list[i].top_yn == "Y"))
					{
						inner += '	<td><span class="fixed_top">상단고정</span><span class="tit">'+nullChk(result.list[i].title)+'</span></td>';
					}
					else
					{
						inner += '	<td><span class="tit ml">'+nullChk(result.list[i].title)+'</span></td>';
					}
					inner += '	<td>'+nullChk(result.list[i].link_part)+'</td>';
					inner += '	<td>'+nullChk(cutDate(result.list[i].submit_date))+'</td>';
					
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}			
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./news_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
					
			listSize = result.listSize;
			
			$(".tb_div").html(inner);
			$(".paging").html(makePaging4(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}

//메인파트너스목록
function getList_detail(order) 
{
	
	if (nullChk(order)!='') 
	{
		order_by = $("#order_by").val();
	}
	
	$("#check").is(":checked")?return_yn = "Y":return_yn = "N";

	if($("#show").is(":checked"))
	{
		expo_yn = "Y";
	}
	else if($("#noshow").is(":checked"))
	{
		expo_yn = "N";
	}
	
	// 둘다체크
	if($("#show").is(":checked") && $("#noshow").is(":checked"))
	{
		expo_yn = "";
	}
	
	if($("#show_Y").is(":checked"))
	{
		top_yn = "Y";
	}
	else if($("#show_N").is(":checked"))
	{
		top_yn = "N";
	}
	
	// 둘다체크
	if($("#show_Y").is(":checked") && $("#show_N").is(":checked"))
	{
		top_yn = "";
	}

/* 	setCookie('search_name',$('#search_name').val()); */
	setCookie('cate_cookie_admin',$('#cate').val());  
	setCookie('news_search_type_cookie',$('#search_type').val());
	setCookie('news_detail_search_name',$('#detail_search_name').val());
	setCookie('news_start_date_cookie',$('#start_date').val().replace(/-/gi, ""));     
	setCookie('news_finish_date_cookie',$('#finish_date').val().replace(/-/gi, ""));     
	setCookie('news_expo_yn_cookie',expo_yn);     
	setCookie('news_top_yn_cookie',top_yn);   
	
	
	$.ajax({
		type : "POST", 
		url : "/admin/news/getNewsList_detail",
		dataType : "text",
	 	data : 
		{
	 		search_type :  $("#search_type").val(),
			search_name :  $("#detail_search_name").val(),
 			start_date  :  $("#start_date").val().replace(/-/gi, ""),
			finish_date :  $("#finish_date").val().replace(/-/gi, ""), 
			expo_yn 	:  expo_yn,
			top_yn	 	:  top_yn,
			page 	 	:  page,
			order_by    :  order_by,
			listSize 	:  "20"
		}, 
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$('#searchNum').text(result.listCnt);
			$('#totalNum').text(result.listCnt_all);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr id="order_'+result.list[i].idx+'" class="order_no">';
					inner += '	<td>';
					inner += '		<span class="input-chkbox noMargin"><input type="checkbox" id="chk_'+result.list[i].idx+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].idx+'"></label>';
					inner += '		<input type="hidden" id="idx_'+result.list[i].idx+'" name="idxs"></span>';
					inner += '	</td>';
					inner += '	<td>'+[i+1]+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					if(nullChk(result.list[i].top_yn == "Y"))
					{
						inner += '	<td><span class="fixed_top">상단고정</span><span class="tit">'+nullChk(result.list[i].title)+'</span></td>';
					}
					else
					{
						inner += '	<td><span class="tit ml">'+nullChk(result.list[i].title)+'</span></td>';
					}
					inner += '	<td>'+nullChk(result.list[i].link_part)+'</td>';
					inner += '	<td>'+nullChk(cutDate(result.list[i].submit_date))+'</td>';
					
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}			
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./news_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
		
			listSize = result.listSize;
			
			$(".tb_div").html(inner);
			$(".paging").html(makePaging2(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}

// 메인베너삭제
function delNewsList()
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
			url : "/admin/news/delNewsList",
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

// 검색 초기화
function reset()
{
	$("#detail_search_name").val("");
	$("#search_type").val("");
	$("#start_date").val("");
	$("#finish_date").val("");
	$("#check").prop("checked",true);
	$("#show").prop("checked",true);
	$("#show_Y").prop("checked",true);
}

//선택노출설정
function upExpo_sel()
{
	var chkIdx = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkIdx += '\''+$(this).attr("id").replace("chk_", "")+"\',";
			chkIdx2 = chkIdx.replace(/,\s*$/, "");
		}
	});
	
	if(chkIdx == "")
	{
		alert("선택된 항목이 없습니다.");
		return;
	}
	
	var sel_expo = $("#sel_expo").val();
	
	if(sel_expo == "")
	{
		 alert("노출 상태를 설정해주세요.");
		 return false;
	}

	if(confirm("정말 변경하시겠습니까?"))
	{
		$.ajax({
			type : "POST", 
			url : "/admin/news/upExpo_sel",
			dataType : "text",
			async : false,
			data : 
			{
				idx : chkIdx2,
				sel_expo : sel_expo
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

//메인노출설정
function upMain_sel()
{
	var chkIdx = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkIdx += '\''+$(this).attr("id").replace("chk_", "")+"\',";
			chkIdx2 = chkIdx.replace(/,\s*$/, "");
		}
	});
	
	if(chkIdx == "")
	{
		alert("선택된 항목이 없습니다.");
		return;
	}
	
	var sel_main = $("#sel_main").val();
	
	if(sel_main == "")
	{
		 alert("노출 상태를 설정해주세요.");
		 return false;
	}

	if(confirm("정말 변경하시겠습니까?"))
	{
		$.ajax({
			type : "POST", 
			url : "/admin/news/upMain_sel",
			dataType : "text",
			async : false,
			data : 
			{
				idx : chkIdx2,
				sel_main : sel_main
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

// 선택노출설정
function upCate_sel()
{
	var chkIdx = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkIdx += '\''+$(this).attr("id").replace("chk_", "")+"\',";
			chkIdx2 = chkIdx.replace(/,\s*$/, "");
		}
	});
	
	if(chkIdx == "")
	{
		alert("선택된 항목이 없습니다.");
		return;
	}
	
	var sel_cate = $("#sel_cate").val();
	
	if(sel_cate == "")
	{
		 alert("변경할 카테고리를 설정해주세요.");
		 return false;
	}
	
	if(confirm("정말 변경하시겠습니까?"))
	{
		$.ajax({
			type : "POST", 
			url : "/admin/news/upCate_sel",
			dataType : "text",
			async : false,
			data : 
			{
				idx : chkIdx2,
				sel_cate : sel_cate
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

// 엑셀다운
function excelDown()
{
	var chkIdx = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkIdx += '\''+$(this).attr("id").replace("chk_", "")+"\',";
			chkIdx2 = chkIdx.replace(/,\s*$/, "");
		}
	});
	
	if(chkIdx == "")
	{
		alert("선택된 항목이 없습니다.");
		return;
	}
	
 	var cate_Arr = new Array();
 	var title_Arr = new Array();
 	var ptnr_Arr = new Array();
 	var submit_Arr = new Array();
 	var expo_yn_Arr = new Array();
	
	$("[name='chk_val']").each(function() 
	{
		var checkbox = $(this).prop("checked") == true;
		if( checkbox )
		{
			cate_Arr.push($(this).parent().parent().next().next().text());
			title_Arr.push($(this).parent().parent().next().next().next().text());
			ptnr_Arr.push($(this).parent().parent().next().next().next().next().text());
			submit_Arr.push($(this).parent().parent().next().next().next().next().next().text());
			expo_yn_Arr.push($(this).parent().parent().next().next().next().next().next().next().text());
		}
	});
	
	var inner = ""; 
	for ( i = 0; i < cate_Arr.length; i++) {
	 inner += '<tr>';
	 inner += '	 <td>'+cate_Arr[i]+'</td>';
	 inner += '	 <td>'+title_Arr[i]+'</td>';
	 inner += '	 <td>'+ptnr_Arr[i]+'</td>';
	 inner += '	 <td>'+submit_Arr[i]+'</td>';
	 inner += '	 <td>'+expo_yn_Arr[i]+'</td>';
	 inner += '</tr>';
	}
	
	$("#list_target").html(inner); 

	
 	var filename = "팀  엑셀 다운로드";
	var table = "excelTable";

    exportExcel(filename, table); 

}

//메인파트너스목록 
function goCate(idx) 
{
	
	setCookie('cate_cookie_admin',$('#cate').val());     
	setCookie("page", page);
	setCookie("order_by", order_by);  

    var order = "desc";
    
	if (nullChk(order)!='') 
	{
		order_by = $("#order_by").val();
	}
	
	$.ajax({
		type : "POST", 
		url : "/admin/news/getNewsList",
		dataType : "text",
		data : 
		{
			search_name  :  $("#search_name").val(),
 			cate_idx 	 :  idx,
 			page 	 	 :  page,
			order_by 	 :  order_by,
			listSize 	 :  "20",
		}, 
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$('#searchNum').text(result.listCnt);
			$('#totalNum').text(result.listCnt_all);
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner+='<tr id="order_'+result.list[i].idx+'" class="order_no">';
					inner += '	<td>';
					inner += '		<span class="input-chkbox noMargin"><input type="checkbox" id="chk_'+result.list[i].idx+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].idx+'"></label>';
					inner += '		<input type="hidden" id="idx_'+result.list[i].idx+'" name="idxs"></span>';
					inner += '	</td>';
					inner += '	<td>'+[i+1]+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					
					if(nullChk(result.list[i].top_yn == "Y"))
					{
						inner += '	<td><span class="fixed_top">상단고정</span><span class="tit">'+nullChk(result.list[i].title)+'</span></td>';
					}
					else
					{
						inner += '	<td><span class="tit ml">'+nullChk(result.list[i].title)+'</span></td>';
					}
					inner += '	<td>'+nullChk(result.list[i].link_part)+'</td>';
					inner += '	<td>'+nullChk(cutDate(result.list[i].submit_date))+'</td>';
					
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}			
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./news_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
			
			listSize = result.listSize;
			
			$(".tb_div").html(inner);
			$(".paging").html(makePaging4(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}

//쿠키세팅 
function setCookie(cname,cvalue) {

	  var d = new Date();
	  var exdays = 1;
	  d.setTime(d.getTime() + (60*60*24));

	  var expires = "expires="+ d.toUTCString();

	  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";

	} 

function getCookie(cname) {

	  var name = cname + "=";

	  var decodedCookie = decodeURIComponent(document.cookie);

	  var ca = decodedCookie.split(';');

	  for(var i = 0; i <ca.length; i++) {

	    var c = ca[i];

	    while (c.charAt(0) == ' ') {

	      c = c.substring(1);

	    }

	    if (c.indexOf(name) == 0) {

	      return c.substring(name.length, c.length);

	    }

	  }

	  return "";

	} 

window.onpageshow = function (event)
{
	if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) 
	{
		location.reload();
		$("#search_name").val("");
	}
} 

</script>
<div id="container" class="sub_page partners_list news_list scroll">
	<div class="sub_page_inner">
		<div class="top_cont">
			<div class="top_cont_inner">
				<div class="info_txt">
					<ul>
						<li class="inb"><a href="/admin/news/news_cate">News</a></li>
						<span class="divider">></span>
						<li class="inb"><a href="/admin/news/news_list">게시글 관리</a></li>
					</ul>
					<p>* 마지막 수정 : <span class="time">${news_update[0].edit_date2}</span></p>
				</div>
				<div class="cate_box inb">
					<span class="af_icon">
		 			    <select id="cate" name="cate" de-data="선택하세요.">
							<option value="">전체</option>
							 <c:forEach var="i" items="${news_cate_list}" varStatus="loop">
								<option value="${i.idx}">${i.cate_nm}</option>
		 					 </c:forEach>
						</select> 					
					</span>
				</div>
				<div class="search_input">
					<input type="text" class="search_box" id="search_name" name="search_name" placeholder="여기에 검색어를 입력하세요."  onkeypress="javascript:pagingReset(); excuteEnter(getList);">
					<span class="detail_btn inb">
						<img src="/img/admin/h_down_arr.png">
						<span class="txt">상세</span>
					</span>
					<div class="drop_box">
						<div class="contbox">
							<div class="lt">
								검색어
							</div>
							<div class="rt">
								<span class="af_icon">
									<select id="search_type" name="search_type">
										<option value="">전체</option>
										<option value="title">제목</option>
										<option value="link_part">관련파트너사</option>
									</select>
								</span>
								<input type="text" id="detail_search_name" name="detail_search_name" class="detail_search_name" placeholder="여기에 검색어를 입력하세요.">
							</div>
						</div>
						<div class="contbox cont02">
							<div class="lt">
								등록일
							</div>
							<div class="rt">
	                            <div class="date-select">
	                                <div class="date_box"><input type="text" id="start_date" name="" class="datepicker input-calendar" autocomplete="off" placeholder="YY-MM-DD"/></div>
	                                <div class="period-bar">-</div>
	                                <div class="date_box"><input type="text" id="finish_date" name="" class="datepicker input-calendar" autocomplete="off" placeholder="YY-MM-DD"/></div>
	                            </div>
							</div>
						</div>
						<div class="contbox cont03">
							<div class="lt"></div>
							<div class="rt radio_box">
								<div class="search-right">
			                         <div class="search-input">
			                            <div class="check_box custom">
			                                <span class="input-radio" onclick="setSearchDate('');"><input type="radio" id="allChk" name="during" value="" checked=""><label for="allChk"><span class="txt">전체</span></label></span>
			                                <span class="input-radio ml" onclick="setSearchDate('7d');"><input type="radio" id="radio-1-2" name="during" value=""><label for="radio-1-2"><span class="txt">7일</span></label></span>
			                                <span class="input-radio ml" onclick="setSearchDate('2w');"><input type="radio" id="radio-1-3" name="during" value=""><label for="radio-1-3"><span class="txt">15일</span></label></span>
			                                <span class="input-radio ml" onclick="setSearchDate('1m');"><input type="radio" id="radio-1-4" name="during" value=""><label for="radio-1-4"><span class="txt">1개월</span></label></span>
			                                <span class="input-radio ml" onclick="setSearchDate('3m');"><input type="radio" id="radio-1-5" name="during" value=""><label for="radio-1-5"><span class="txt">3개월</span></label></span>
			                             </div>
			                         </div>
		                         </div>
							</div>
						</div>
						<div class="contbox">
							<div class="lt">
								노출여부
							</div>
							<div class="rt radio_box">
								<ul>
									<li class="inb mr">
										<input type="checkbox" id="show" value="Y" name="expo_yn" checked>
										<label for="show"></label>
										<span class="inb txt">노출</span>
									</li>
									<li class="inb">
										<input type="checkbox" id="noshow"  value="N" name="expo_yn">
										<label for="noshow"></label>
										<span class="inb txt">미노출</span>
									</li>
								</ul>
							</div>
						</div>
						<div class="contbox cont05">
							<div class="lt">
								상단고정
							</div>
							<div class="rt radio_box">
								<ul>
									<li class="inb mr">
										<input type="checkbox" id="show_Y" value="Y" name="top_yn" checked>
										<label for="show_Y"></label>
										<span class="inb txt">고정</span>
									</li>
									<li class="inb">
										<input type="checkbox" id="show_N" value="N" name="top_yn">
										<label for="show_N"></label>
										<span class="inb txt">비고정</span>
									</li>
								</ul>
							</div>
						</div>
						<div class="btn_wrap">
							<button type="reset" class="btn" onclick="reset();">재설정</button>
							<a class="btn search_btn" onclick="javascript:getList_detail('order');">검색하기</a>
						</div>
					</div>
				</div>
				<div class="info_box">
		            <span class="serch_cont_txt"><strong>결과 <span id="searchNum"></span>개</strong> / 전체 <span id="totalNum"></span>개</span>
		           	<span class="dis-no"><img src="/img/es_check.png"><span class="es_select">선택한 게시글</span><a onclick="delNewsList();" class="del_bt"><img src=""/>선택 삭제</a></span>
			    </div>
			    <select id="order_by" class="serch_cont_sort" onchange="getList('order');">
					 <option value="desc">최신 등록 순</option>
			         <option value="asc">오래된 순</option>
				</select>	
			    <div class="top-float btn">
					<a href="/admin/news/news_upload" class="btn_a_type">게시글 추가</a>
				</div>
			</div>
		</div>
		<div class="contwrap">
			<div class="wrap_inner scroll">
				<div class="contbox">
			        <div class="search_con_wrap">
			        	<div class="list-container">        	    
				            <div class="list-table default">
					           <table id="lists">
					            	<colgroup>
					            		<col style="width:2%;">
					            		<col style="width:6%;">
					            		<col style="width:13%;">
					            		<col style="width:40%;">
					            		<col style="width:16%;">
					            		<col style="width:10%;">
					            		<col style="width:10%;">
					            		<col style="width:3%;">
					            	</colgroup>
					                <thead class="t_hd">
						                <tr>
						                    <th><span class="input-chkbox noMargin"><input type="checkbox" id="chk_all" name="chk_all" class="regular-radio" value="chk_val"/><label for="chk_all"></label></span></th>
					                        <th>번호</th>
						                    <th>카테고리</th>
						                    <th>제목</th>
						                    <th>관련 파트너사</th>
						                    <th>등록일</th>
						                    <th>노출여부</th>
						                    <th></th>
						                </tr>
					                </thead>
									<tbody id="list_area" class="tb_div">
									</tbody>
								</table>
						   </div>
			        	</div>
			        </div>				
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/pages/common_admin/paging.jsp"/>
		<div class="list-btn">
			<div class="inner_box scroll">
				<div class="lt_cont">
					<button type="button" onclick="delNewsList();" class="btn btn_c_type list-delete-btn">선택 삭제</button>
				</div>
				<div class="rt_cont">
					<div class="cont">
						<div class="cate_box inb">
							<div class="af_icon">
				 			    <select id="sel_expo" name="sel_expo" de-data="선택하세요.">
									<option value="">선택노출</option>
									<option value="Y">노출</option>
									<option value="N">미노출</option>
								</select> 					
							</div>
						</div>
						<div class="inb">
							<a class="btn inb" onclick="javascript:upExpo_sel();">설정</a>
						</div>
					</div>
					<div class="cont">
						<div class="cate_box inb">
							<div class="af_icon">
				 			    <select id="sel_main" name="sel_main" de-data="선택하세요.">
									<option value="">상단고정</option>
									<option value="Y">고정</option>
									<option value="N">미고정</option>
								</select> 					
							</div>
						</div>
						<div class="inb">
							<a class="btn inb" onclick="javascript:upMain_sel();">설정</a>
						</div>
					</div>
					<div class="cont">
						<div class="cate_box inb">
							<div class="af_icon">
				 			    <select id="sel_cate" name="sel_cate" de-data="선택하세요.">
									<option value="">선택 카테고리</option>
									 <c:forEach var="i" items="${news_cate_list}" varStatus="loop"> 
	 									<option value="${i.idx}">${i.cate_nm}</option> 
				 					 </c:forEach> 
								</select> 					
							</div>
						</div>
						<div class="inb">
							<a class="btn inb" onclick="javascript:upCate_sel();">일괄 이동</a>
						</div>
					</div>
				</div>
	   		</div>
	   	</div>
		<table id="excelTable" class="board" style="display:none;"> 
			<thead>
				<tr>
					<th>카테고리</th>
					<th>제목</th>
					<th>관련 파트너사</th>
					<th>등록일</th>
					<th>노출여부</th>
				</tr>
			</thead>
			<tbody id="list_target">
			</tbody>
		</table>
	</div>		
</div>
<script>
$(document).ready(function(){
	
	getCookie('cate_cookie_admin')  != '' ? $('#cate').val(getCookie('cate_cookie_admin')) 	 :  $('#cate').val();
	getCookie('news_search_type_cookie')  != '' ? $('#search_type').val(getCookie('news_search_type_cookie')) 	 	 :  $('#search_type').val();
	getCookie('news_detail_search_name')  != '' ? $('#detail_search_name').val(getCookie('news_detail_search_name')) 	 :  $('#detail_search_name').val();
	getCookie('news_start_date_cookie') 	 != '' ? $('#start_date').val(getCookie('news_start_date_cookie')) 		 	 :  $('#start_date').val().replace(/-/gi, "");
	getCookie('news_finish_date_cookie')  != '' ? $('#finish_date').val(getCookie('news_finish_date_cookie'))   		 :  $('#finish_date').val().replace(/-/gi, "");
	
	if(nullChk(getCookie("news_expo_yn_cookie")) != "") { expo_yn = nullChk(getCookie("news_expo_yn_cookie")); }
	if(nullChk(getCookie("news_top_yn_cookie")) != "") { top_yn = nullChk(getCookie("news_top_yn_cookie")); }

	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	
	if (
			getCookie('news_search_type_cookie')==''  &&
			getCookie('news_detail_search_name')=='' &&
			getCookie('news_start_date_cookie')==''  &&
			getCookie('news_finish_date_cookie')=='' &&
			nullChk(getCookie("news_expo_yn_cookie")) == '' &&
			nullChk(getCookie("news_top_yn_cookie")) == ''
		) 
	{
		getList();		
	}
	else
	{
		getList_detail();
	}	

});
</script>
    