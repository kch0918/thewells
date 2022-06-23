<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common_admin/admin_header.jsp"/>
<jsp:include page="/WEB-INF/pages/common_admin/admin_lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<style>
.ui-datepicker-calendar 
{
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

	
  $("#cate").change(function() { 
	  var sel_cate_val = $("#cate").val();
	  
	  if(sel_cate_val == "main")
	  {
		goMainExpo();
	  }
	  else 
	  {
	  	goCate(sel_cate_val);
	  }  
	  });
	
	 //리스트
	
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
    
    // 순서변경
    active_drag();
    
    $("#search_init").click(function () {
    	delCookie();
      });
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

// 메인파트너스목록 
function getList() 
{

	setCookie('partners_search_name',$('#search_name').val()); 
	setCookie('partners_cate_cookie',$('#cate').val());     
	 
	$.ajax({
		type : "POST", 
		url : "/admin/partners/getPtnrList",
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
					inner += '	<td>'+nullChk(result.list[i].part_nm_ko)+'/'+nullChk(result.list[i].part_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].inv_year)+'/'+nullChk(result.list[i].inv_month)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					if(nullChk(result.list[i].return_yn == "Y"))
					{
						inner += '	<td>회수완료</td>';
					}
					else
					{
						inner += '	<td>-</td>';
					}
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_expo == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./partners_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
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

//메인파트너스목록 
var return_yn ='';
var expo_yn   ='';
var main_yn   ='';
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
	
	// 둘다체크
	if($("#show").is(":checked") && $("#noshow").is(":checked"))
	{
		expo_yn = "";
	}
	
	if($("#show_Y").is(":checked"))
	{
		main_yn = "Y";
	}
	else if($("#show_N").is(":checked"))
	{
		main_yn = "N";
	}
	
	// 둘다체크
	if($("#show_Y").is(":checked") && $("#show_N").is(":checked"))
	{
		main_yn = "";
	}
	
	setCookie('partners_search_name',$('#search_name').val());
	setCookie('partners_cate_cookie',$('#cate').val());  
	setCookie('search_type_cookie',$('#search_type').val());
	setCookie('detail_search_name',$('#detail_search_name').val());
	setCookie('start_date_cookie',$('#start_date').val().replace(/-/gi, ""));     
	setCookie('finish_date_cookie',$('#finish_date').val().replace(/-/gi, ""));     
	setCookie('return_yn_cookie',return_yn);     
	setCookie('expo_yn_cookie',expo_yn);     
	setCookie('main_yn_cookie',main_yn);     
	
	$.ajax({
		type : "POST", 
		url : "/admin/partners/getPtnrList_detail",
		dataType : "text",
	 	data : 
		{
	 		search_type :  $("#search_type").val(),
			search_name :  $("#detail_search_name").val(),
 			start_date  :  $("#start_date").val().replace(/-/gi, ""),
			finish_date :  $("#finish_date").val().replace(/-/gi, ""), 
			return_yn 	:  return_yn,
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
					
					inner+='<tr id="order_'+result.list[i].idx+'" class="order_no" >';
					inner += '	<td>';
					inner += '		<span class="input-chkbox noMargin"><input type="checkbox" id="chk_'+result.list[i].idx+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].idx+'"></label>';
					inner += '		<input type="hidden" id="idx_'+result.list[i].idx+'" name="idxs"></span>';
					inner += '	</td>';
					inner += '	<td>'+[i+1]+'</td>';
					inner += '	<td>'+nullChk(result.list[i].part_nm_ko)+'/'+nullChk(result.list[i].part_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].inv_year)+'/'+nullChk(result.list[i].inv_month)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					if(nullChk(result.list[i].return_yn == "Y"))
					{
						inner += '	<td>회수완료</td>';
					}
					else
					{
						inner += '	<td>-</td>';
					}
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_expo == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./partners_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
					inner += '</tr>';		
				}
			}
			else
			{
				inner += '<ul>';
				inner += '	<li style="width: max-content;text-align: center;padding: 10px;">검색결과가 없습니다.</li>';
				inner += '</ul>';
			}	
			
			if ($("#detail_search_name").val()=='' && main_yn == '' && expo_yn == '' && return_yn == '' && $("#start_date").val() == '' && $("#finish_date").val() == '') 
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
function delPtnrList()
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
			url : "/admin/partners/delPtnrList",
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
			url : "/admin/partners/upExpo_sel",
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
			url : "/admin/partners/upMain_sel",
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

//선택노출설정
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
			url : "/admin/partners/upCate_sel",
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
	
 	var com_nm_Arr = new Array();
 	var invest_Arr = new Array();
 	var cate_Arr = new Array();
 	var return_yn_Arr = new Array();
 	var show_yn_Arr = new Array();
 	var main_yn_Arr = new Array();
	
	$("[name='chk_val']").each(function() 
	{
		var checkbox = $(this).prop("checked") == true;
		if( checkbox )
		{
			com_nm_Arr.push($(this).parent().parent().next().next().text());
			invest_Arr.push($(this).parent().parent().next().next().next().text());
			cate_Arr.push($(this).parent().parent().next().next().next().next().text());
			return_yn_Arr.push($(this).parent().parent().next().next().next().next().next().text());
			show_yn_Arr.push($(this).parent().parent().next().next().next().next().next().next().text());
			main_yn_Arr.push($(this).parent().parent().next().next().next().next().next().next().next().text());
		}
	});
	
	var inner = ""; 
	for ( i = 0; i < com_nm_Arr.length; i++) {
	 inner += '<tr>';
	 inner += '	 <td>'+com_nm_Arr[i]+'</td>';
	 inner += '	 <td>'+invest_Arr[i]+'</td>';
	 inner += '	 <td>'+cate_Arr[i]+'</td>';
	 inner += '	 <td>'+return_yn_Arr[i]+'</td>';
	 inner += '	 <td>'+show_yn_Arr[i]+'</td>';
	 inner += '	 <td>'+main_yn_Arr[i]+'</td>';
	 inner += '</tr>';
	}
	
	$("#list_target").html(inner); 

	
 	var filename = "파트너스  엑셀 다운로드";
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
		url : "/admin/partners/upOrder",
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

// 메인노출 
function goMainExpo() 
{
 	$.ajax({
		type : "POST", 
		url : "/admin/partners/goMainExpo",
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
					inner += '	<td>'+nullChk(result.list[i].part_nm_ko)+'/'+nullChk(result.list[i].part_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].inv_year)+'/'+nullChk(result.list[i].inv_month)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					if(nullChk(result.list[i].return_yn == "Y"))
					{
						inner += '	<td>회수완료</td>';
					}
					else
					{
						inner += '	<td>-</td>';
					}
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_expo == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./partners_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
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

//메인파트너스목록 
function goCate(idx) 
{
	setCookie('partners_search_name',$('#search_name').val()); 
	setCookie('partners_cate_cookie',$('#cate').val());     
	
	$.ajax({
		type : "POST", 
		url : "/admin/partners/getPtnrList",
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
					inner += '	<td>'+nullChk(result.list[i].part_nm_ko)+'/'+nullChk(result.list[i].part_nm_en)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].inv_year)+'/'+nullChk(result.list[i].inv_month)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].get_cate_nm)+'</td>';
					if(nullChk(result.list[i].return_yn == "Y"))
					{
						inner += '	<td>회수완료</td>';
					}
					else
					{
						inner += '	<td>-</td>';
					}
					if(nullChk(result.list[i].expo_yn == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}	
					if(nullChk(result.list[i].main_expo == "Y"))
					{
						inner += '	<td>노출</td>';
					}
					else
					{
						inner += '	<td>미노출</td>';
					}		
					inner += '	<td><button type="button" class="small-btn btn_a_type edit-btn" onclick="javascript:location.href=\'./partners_upload?idx='+result.list[i].idx+'\'"><img src="/img/admin/list_icon.png" alt="수정" ></td>'
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
	
/* function delCookie() {
	setCookie('search_name',"",-1);
	setCookie('cate_cookie',"",-1);
} */

/* // 뒤로가기 시 이벤트
window.onpageshow = function (event)
{
	if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) 
	{
		location.reload();

	}
}  */

</script>
<div id="container" class="sub_page partners_list his_upload scroll">
	<div class="sub_page_inner">
		<div class="top_cont">
			<div class="top_cont_inner">
				<div class="info_txt">
					<ul>
						<li class="inb"><a href="/admin/partners/partners_cate">Partners</a></li>
						<span class="divider">></span>
						<li class="inb"><a href="/admin/partners/partners_list">파트너사 리스트 관리</a></li>
					</ul>
					<p>* 마지막 수정 : <span class="time">${ptnr_update[0].edit_date2}</span></p>
				</div>
				<div class="cate_box inb">
					<div class="af_icon">
		 			    <select id="cate" name="cate" de-data="선택하세요.">
							<option value="">전체</option>
							<option value="main">메인노출</option>
							 <c:forEach var="i" items="${ptnr_cate_list}" varStatus="loop">
								<option value="${i.idx}">${i.cate_nm}</option>
		 					 </c:forEach>
						</select> 					
					</div>
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
								<div class="inb">
									<select id="search_type" name="search_type">
										<option value="">전체</option>
										<option value="part_nm_ko">기업명</option>
										<option value="corp_nm_ko">회사소개</option>
									</select>
								</div>
								<input type="text" id="detail_search_name" name="detail_search_name" class="detail_search_name" placeholder="여기에 검색어를 입력하세요.">
							</div>
						</div>
						<div class="contbox cont02">
							<div class="lt">
								투자시기
							</div>
							<div class="rt">
	                            <div class="date-select">
	                                <div class="date_box"><input type="text" id="start_date" name="" class="datepicker input-calendar" autocomplete="off" placeholder="YY-MM"/></div>
	                                <div class="period-bar">-</div>
	                                <div class="date_box"><input type="text" id="finish_date" name="" class="datepicker input-calendar" autocomplete="off" placeholder="YY-MM"/></div>
	                            </div>
							</div>
						</div>
						<div class="contbox cont03">
							<div class="lt">
								회수정보
							</div>
							<div class="rt">
								<span class="inb re_check_box">
									<input type="checkbox" id="check" value="Y" checked>
									<label for="check"></label>
									<span class="inb txt">회수완료</span>
								</span>
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
										<input type="checkbox" id="show_Y" value="Y" checked>
										<label for="show_Y"></label>
										<span class="inb txt">노출</span>
									</li>
									<li class="inb">
										<input type="checkbox" id="show_N" value="Y">
										<label for="show_N"></label>
										<span class="inb txt">미노출</span>
									</li>
								</ul>
							</div>
						</div>
						<div class="btn_wrap">
							<button type="reset" class="btn" onclick="reset();">재설정</button>
							<a href="#" class="btn search_btn" onclick="javascript:getList_detail();">검색하기</a>
						</div>
					</div>
				</div>
				<div class="info_box">
		            <span class="serch_cont_txt"><strong>결과 <span id="searchNum"></span>개</strong> / 전체 <span id="totalNum"></span>개</span>
		           	<span class="dis-no"><img src="/img/es_check.png"><span class="es_select">선택한 게시글</span><a onclick="delPtnrList();" class="del_bt"><img src=""/>선택 삭제</a></span>
			    </div>
			    <div class="filedown_box">
			    	<a class="txt inb" onclick="javascript:excelDown();">선택 엑셀 다운</a>
			    </div>
			    <div class="top-float btn">
					<a href="/admin/partners/partners_upload" class="btn_a_type">게시글 추가</a>
				</div>
					<!-- <input type="button" id="search_init" onclick="location.href='/admin/partners/partners_list'" value="초기화"/> -->
			</div>
		</div>
		<div class="contwrap">
			<div class="wrap_inner scroll ">
				<div class="contbox">
			        <div class="search_con_wrap">
			        	<div class="list-container">        	    
				            <div class="list-table default">
					            <table id="lists">
					            	<colgroup>
					            		<col style="width:2%;">
					            		<col style="width:6%;">
					            		<col style="width:32%;">
					            		<col style="width: 8%;">
					            		<col style="width:20%;">
					            		<col style="width: 11%;">
					            		<col style="width: 8%;">
					            		<col style="width: 8%;">
					            		<col style="width: 5%;">
					            	</colgroup>
					                <thead class="t_hd">
						                <tr>
						                    <th><span class="input-chkbox noMargin"><input type="checkbox" id="chk_all" name="chk_all" class="regular-radio" value="chk_val"/><label for="chk_all"></label></span></th>
						                    <th>번호</th>
						                    <th>기업명</th>
						                    <th>투자시기</th>
						                    <th>카테고리</th>
						                    <th>회수여부</th>
						                    <th>노출여부</th>
						                    <th>메인노출</th>
						                    <th></th>
						                </tr>
					                </thead>
									<tbody  id="list_area" class="tb_div">
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
					<button type="button" onclick="delPtnrList();" class="btn btn_c_type list-delete-btn">선택 삭제</button>
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
									 <c:forEach var="i" items="${ptnr_cate_list}" varStatus="loop"> 
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
					<th>기업명</th>
					<th>투자시기</th>
					<th>카테고리</th>
					<th>회수여부</th>
					<th>노출여부</th>
					<th>메인여부</th>
				</tr>
			</thead>
			<tbody id="list_target">
			</tbody>
		</table>
	</div>
</div>

<script>
$(document).ready(function() {

	getCookie('partners_search_name') 	!= '' ? $('#search_name').val(getCookie('partners_search_name')) 	 	 :  $('#search_name').val(); 
	getCookie('detail_search_name')  	!= '' ? $('#detail_search_name').val(getCookie('detail_search_name')) 	 :  $('#detail_search_name').val();
	getCookie('partners_cate_cookie') 	!= '' ? $('#cate').val(getCookie('partners_cate_cookie')) 			     :  $('#cate').val();
	getCookie('search_type_cookie') 	!= '' ? $('#search_type').val(getCookie('search_type_cookie')) 	 	 	 :  $('#search_type').val();
	getCookie('start_date_cookie') 	 	!= '' ? $('#start_date').val(getCookie('start_date_cookie')) 		 	 :  $('#start_date').val().replace(/-/gi, "");
	getCookie('finish_date_cookie')  	!= '' ? $('#finish_date').val(getCookie('finish_date_cookie'))   		 :  $('#finish_date').val().replace(/-/gi, "");
	if(nullChk(getCookie("return_yn_cookie")) != "") { return_yn = nullChk(getCookie("return_yn_cookie")); }
	if(nullChk(getCookie("expo_yn_cookie"))   != "") { expo_yn = nullChk(getCookie("expo_yn_cookie")); }
	if(nullChk(getCookie("main_yn_cookie"))   != "") { main_yn = nullChk(getCookie("main_yn_cookie")); }
	
	if (
			getCookie('search_type_cookie') ==''  &&
			getCookie('detail_search_name') =='' &&
			getCookie('start_date_cookie')  ==''  &&
			getCookie('finish_date_cookie') =='' &&
			nullChk(getCookie("return_yn_cookie")) == '' &&
			nullChk(getCookie("expo_yn_cookie")) == '' &&
			nullChk(getCookie("main_yn_cookie")) == ''
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