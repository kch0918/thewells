<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<style>
.ui-datepicker-calendar {
    display: none;
    }​
</style>
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
	 
	
   $(".datepicker").datepicker({
        dateFormat: 'mm yy',
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).val($.datepicker.formatDate('yy-mm', new Date(year, month, 1)));
           
        }
    });

    $(".datepicker").focus(function () {
        $(".ui-datepicker-calendar").hide();
        $("#ui-datepicker-div").position({
            my: "center top",
            at: "center bottom",
            of: $(this)
        });
    });
      
    $("#cate").change(function() { 
  	  var sel_cate_val = $("#cate").val();
    	getList(sel_cate_val);
	   if(sel_cate_val == "main")
	  	  {
	  		goMainExpo();
	  	  }
	  	  else 
	  	  {
	  	  	goCate(sel_cate_val);
	  	  }  
  	  });
    // 순서변경
    active_drag();
});

function active_drag(){
	$(".tb_div").sortable({
		update:function(event,ui){
			$(this).children().each(function(index){
				/* $(this).find('td').first().html(index+1); */
			});
		}
	});
}

// 팀 목록 
function getList(idx) 
{
	setCookie('team_cate_cookie',$('#cate').val());  
	
	$.ajax({
		type : "POST", 
		url : "/admin/team/getTeamList",
		dataType : "text",
		data : 
		{
			search_name  :  $("#search_name").val(),
 			cate_idx 	 :  $("#cate").val()
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
					inner += '	<td>'+nullChk(result.list[i].team_nm_ko)+'/'+nullChk(result.list[i].team_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].level_ko)+'</td>';
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./team_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
			
			if ($("#search_name").val()=='') 
			{
				active_drag();
			}
			else
			{
				$('#list_area').remove();
				$('#lists').append("<tbody id='list_area' class='tb_div'></tbody>");
			}
			
			$(".tb_div").html(inner);
		}
	});	
}

//팀목록 
function getList_detail() 
{
	$("#check").is(":checked")?return_yn = "Y":return_yn = "N";

	if($("#show").is(":checked"))
	{
		expo_yn = "Y";
	}
	else if($("#noshow").is(":checked"))
	{
		expo_yn = "N";
	}
	
	if($("#show_Y").is(":checked"))
	{
		main_yn = "Y";
	}
	else if($("#show_N").is(":checked"))
	{
		main_yn = "N";
	}
	
	setCookie('team_cate_cookie',$('#cate').val());  
	setCookie('team_search_type_cookie',$('#search_type').val()); 
	setCookie('team_detail_search_name',$('#detail_search_name').val());
	setCookie('team_expo_yn_cookie',expo_yn);     
	setCookie('team_main_yn_cookie',main_yn);   
	
	$.ajax({
		type : "POST", 
		url : "/admin/team/getTeamList_detail",
		dataType : "text",
	 	data : 
		{
	 		search_type :  $("#search_type").val(),
	 		search_name :  $("#detail_search_name").val(),
			expo_yn 	:  expo_yn,
			main_yn 	:  main_yn
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
					inner += '	<td>'+nullChk(result.list[i].team_nm_ko)+'/'+nullChk(result.list[i].team_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].level_ko)+'</td>';

					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./team_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
			
			if ($("#detail_search_name").val()=='' && main_yn == '' && expo_yn == '') 
			{
				active_drag();
			}
			else
			{
				$('#list_area').remove();
				$('#lists').append("<tbody id='list_area' class='tb_div'></tbody>");
			}
			
			$(".tb_div").html(inner);
		}
	});	
}

// 메인베너삭제
function delTeamList()
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
			url : "/admin/team/delTeamList",
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
	$("#search_type").val("전체");
	$("#check").prop("checked",true);
	$("#show").prop("checked",true);
	$("#show_Y").prop("checked",true);
}

// 선택노출설정
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
			url : "/admin/team/upExpo_sel",
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
			url : "/admin/team/upMain_sel",
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
			url : "/admin/team/upCate_sel",
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
	
 	var team_nm_Arr = new Array();
 	var cate_Arr = new Array();
 	var level_Arr = new Array();
 	var show_yn_Arr = new Array();
 	var main_yn_Arr = new Array();
	
	$("[name='chk_val']").each(function() 
	{
		var checkbox = $(this).prop("checked") == true;
		if( checkbox )
		{
			team_nm_Arr.push($(this).parent().parent().next().next().text());
			cate_Arr.push($(this).parent().parent().next().next().next().text());
			level_Arr.push($(this).parent().parent().next().next().next().next().text());
			show_yn_Arr.push($(this).parent().parent().next().next().next().next().next().text());
			main_yn_Arr.push($(this).parent().parent().next().next().next().next().next().next().text());
		}
	});
	
	var inner = ""; 
	for ( i = 0; i < team_nm_Arr.length; i++) {
	 inner += '<tr>';
	 inner += '	 <td>'+team_nm_Arr[i]+'</td>';
	 inner += '	 <td>'+cate_Arr[i]+'</td>';
	 inner += '	 <td>'+level_Arr[i]+'</td>';
	 inner += '	 <td>'+show_yn_Arr[i]+'</td>';
	 inner += '	 <td>'+main_yn_Arr[i]+'</td>';
	 inner += '</tr>';
	}
	
	$("#list_target").html(inner); 

	
 	var filename = "팀  엑셀 다운로드";
	var table = "excelTable";

    exportExcel(filename, table); 

}

// 순서저장
function save_pr_cate(){
	
	var idx_arr="";
	var order_no="";
	var cnt=0;
	
	$('.order_no').each(function(){ 
		cnt++;
		idx_arr  +=	$(this).attr('id').split('_')[1]+'|';
		order_no += cnt+"|";
	})

 	$.ajax({
		type : "POST", 
		url : "/admin/team/upOrder",
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

//팀 목록 
function goMainExpo(idx) 
{
	$.ajax({
		type : "POST", 
		url : "/admin/team/goMainExpo",
		dataType : "text",
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
					inner += '	<td>'+nullChk(result.list[i].team_nm_ko)+'/'+nullChk(result.list[i].team_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].level_ko)+'</td>';
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./team_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
			
			$(".tb_div").html(inner);
		}
	});	
}


//팀 목록 
function goCate(idx) 
{
	setCookie('team_cate_cookie',$('#cate').val());  
	
	$.ajax({
		type : "POST", 
		url : "/admin/team/getTeamList",
		dataType : "text",
		data : 
		{
			search_name  :  $("#search_name").val(),
 			cate_idx 	 :  idx
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
					inner += '	<td>'+nullChk(result.list[i].team_nm_ko)+'/'+nullChk(result.list[i].team_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].level_ko)+'</td>';
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./team_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: 100%;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}
			
			if ($("#search_name").val()=='') 
			{
				active_drag();
			}
			else
			{
				$('#list_area').remove();
				$('#lists').append("<tbody id='list_area' class='tb_div'></tbody>");
			}
			
			$(".tb_div").html(inner);
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
	
//뒤로가기 시 이벤트
/* window.onpageshow = function (event)
{
	if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) 
	{
		location.reload();

	}
}  */

</script>
<div id="container" class="sub_page partners_list team_list scroll">
	<div class="sub_page_inner">
	<div class="top_cont">
		<div class="top_cont_inner">
			<div class="info_txt">
				<ul>
					<li class="inb"><a href="/admin/team/team_cate">Our Team</a></li>
					<span class="divider">></span>
					<li class="inb"><a href="/admin/team/team_list">팀원 리스트 관리</a></li>
				</ul>
				<p>* 마지막 수정 : <span class="time">${team_update[0].edit_date2}</span></p>
			</div>
			<div class="cate_box inb">
				<span class="af_icon">
	 			    <select id="cate" name="cate" de-data="선택하세요.">
						<option value="">전체</option>
						<option value="main">메인노출</option>
						 <c:forEach var="i" items="${team_cate_list}" varStatus="loop">
							<option value="${i.idx}">${i.cate_nm}</option>
	 					 </c:forEach>
					</select> 					
				</span>
			</div>
			<div class="search_input">
				<input type="text" class="search_box" id="search_name" name="search_name" placeholder="여기에 검색어를 입력하세요."  onkeypress="javascript:excuteEnter(getList);">
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
									<option value="team_nm_ko">팀원명</option>
									<option value="level_ko">직함</option>
									<option value="career_ko">경력</option>
									<option value="edu_ko">학력</option>
									<option value="intro_ko">자기소개<option>
								</select>
							</span>
							<input type="text" id="detail_search_name" name="detail_search_name" class="detail_search_name" placeholder="여기에 검색어를 입력하세요.">
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
							메인 노출여부
						</div>
						<div class="rt radio_box">
							<ul>
								<li class="inb mr">
									<input type="checkbox" id="show_Y" value="Y" name="main_expo" checked>
									<label for="show_Y"></label>
									<span class="inb txt">노출</span>
								</li>
								<li class="inb">
									<input type="checkbox" id="show_N" value="Y" name="main_expo">
									<label for="show_N"></label>
									<span class="inb txt">미노출</span>
								</li>
							</ul>
						</div>
					</div>
					<div class="btn_wrap">
						<button type="reset" class="btn" onclick="reset();">재설정</button>
						<a class="btn search_btn" onclick="javascript:getList_detail();">검색하기</a>
					</div>
				</div>
			</div>
			<div class="info_box">
	            <span class="serch_cont_txt"><strong>결과 <span id="searchNum"></span>개</strong> / 전체 <span id="totalNum"></span>개</span>
	           	<span class="dis-no"><img src="/img/es_check.png"><span class="es_select">선택한 게시글</span><a onclick="delTeamList();" class="del_bt"><img src=""/>선택 삭제</a></span>
		    </div>
		    <div class="filedown_box">
		    	<a class="txt inb" onclick="javascript:excelDown();">선택 엑셀 다운</a>
		    </div>
		    <div class="top-float btn">
				<a href="/admin/team/team_upload" class="btn_a_type">게시글 추가</a>
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
				            		<col style="width:10%;">
				            		<col style="width:18%;">
				            		<col style="width:22%;">
				            		<col style="width:10%;">
				            		<col style="width:10%;">
				            		<col style="width:12%;">
				            		<col style="width:5%;">
				            	</colgroup>
				                <thead class="t_hd">
					                <tr>
					                    <th><span class="input-chkbox noMargin"><input type="checkbox" id="chk_all" name="chk_all" class="regular-radio" value="chk_val"/><label for="chk_all"></label></span></th>
					                    <th>번호</th>
					                    <th>팀원명</th>
					                    <th>카테고리</th>
					                    <th>직함</th>
					                    <th>노출여부</th>
					                    <th>메인노출</th>
					                    <th></th>
					                </tr>
				                </thead>
								<tbody id="list_area"  class="tb_div">
								</tbody>
							</table>
					   </div>
		        	</div>
		        </div>				
			</div>
		</div>
	</div>
   		<div class="list-btn">
		<div class="inner_box scroll">
			<div class="lt_cont">
				<button type="button" onclick="delTeamList();" class="btn btn_c_type list-delete-btn">선택 삭제</button>
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
								<option value="">메인노출</option>
								<option value="Y">노출</option>
								<option value="N">미노출</option>
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
								 <c:forEach var="i" items="${team_cate_list}" varStatus="loop"> 
 									<option value="${i.idx}">${i.cate_nm}</option> 
			 					 </c:forEach> 
							</select> 					
						</div>
					</div>
					<div class="inb">
						<a class="btn inb" onclick="javascript:upCate_sel();">일괄 이동</a>
					</div>
				</div>
				<div class="cont cont02">
					<div class="inb">
						<a class="btn inb" onclick="javascript:save_pr_cate();">순서 저장</a>
					</div>
				</div>
			</div>
   		</div>
   	</div>
	<table id="excelTable" class="board" style="display:none;">
		<thead>
			<tr>
				<th>팀원명</th>
				<th>카테고리</th>
				<th>직함</th>
				<th>노출여부</th>
				<th>메인노출</th>
			</tr>
		</thead>
		<tbody id="list_target">
		</tbody>
	</table>
</div>
<script>
$(document).ready(function() {

		getCookie('team_cate_cookie') 		 		 != '' ? $('#cate').val(getCookie('team_cate_cookie')) 					   	  :  $('#cate').val();
		getCookie('team_search_type_cookie')  		 != '' ? $('#search_type').val(getCookie('team_search_type_cookie')) 	 	  :  $('#search_type').val();
		getCookie('team_detail_search_name') 		 != '' ? $('#detail_search_name').val(getCookie('team_detail_search_name'))   :	$('#detail_search_name').val();
		if(nullChk(getCookie("team_expo_yn_cookie")) != "") { expo_yn = nullChk(getCookie("team_expo_yn_cookie")); }
		if(nullChk(getCookie("team_main_yn_cookie")) != "") { main_yn = nullChk(getCookie("team_main_yn_cookie")); }

		if (
				getCookie('team_search_type_cookie')==''  &&
				getCookie('team_detail_search_name')=='' &&
				nullChk(getCookie("team_expo_yn_cookie")) == '' &&
				nullChk(getCookie("team_main_yn_cookie")) == '' 
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
    