function isEmpty(field) {
	return (!field);
}


/* 특정 파일 업로드 */
function checkFile2(f){

	var file = f.files;

	if(!/\.(gif|jpg|jpeg|png|pdf)$/i.test(file[0].name)) alert('gif, jpg, png, pdf 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);

	else return;
	
	f.outerHTML = f.outerHTML;
}

//특수문자 유효성
function checkSpecial(str) { 
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi; 
		if(special_pattern.test(str) == true) { 
			return true; 
		} else {
			return false; 
		} 
}

//숫자 유효성
function isNotNumber(field){
	return isNaN(field);
}

function containsHS(field) {
	var str = "@_.123456890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
	for (var i = 0; i < field.length; i++) {
		if (str.indexOf(field[i]) == -1) {
			return true;
		}
	}
	return false;
}


function containsNum(field) {
	var numflag=false;
	for (var i = 0; i < field.length; i++) {
		if (!isNaN(field[i])) {
			numflag = true;
		}
	}
	return numflag;
}


function get_label(fld) {
	var id = fld;
	var labels = document.getElementsByTagName('label');
	var el = null;
	var text = '';
	for (i = 0; i < labels.length; i++) {
		if (id == labels[i].htmlFor) {
			el = labels[i];
			break;
		}
	}
	if (el != null) {
		text = el.innerHTML;
	}
	return text;
}
function excuteEnter(excuteFunc)
{
	if(event.keyCode == 13){
		excuteFunc();
		return;
	}
}
function lengthCheck(val, max)
{
	var len = $("#"+val).val().length;
	
	if(len > max)
	{
		alert(max+"자 이내로 작성해주세요.");
		var tmp = $("#"+val).val().substring(0, max);
		$("#"+val).val(tmp);
		len = $("#"+val).val().length;
	}
	$("#"+val+"_length").html(len+"/"+max+"자");
}
function nullChk(d)
{
	if(d == "" || d == null || d == 'null' || d == undefined)
	{
		return "";
	}
	else
	{
		return d;
	}
}
var setCookie = function(name, value, exp) 
{
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*1000);
	document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};
var getCookie = function(name) 
{
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
};
function trim(stringToTrim) {
    return nullChk(stringToTrim).toString().replace(/^\s+|\s+$/g,"");
}
function cutDate(dd)
{
	if(dd == "" || dd == null || dd == 'null' || dd == undefined)
	{
		return "";
	}
	else
	{
		if(trim(dd).length == 6)
		{
			var year = dd.substring(0,4);
			var month = dd.substring(4,6);
			return year+"-"+month;
		}
		else if(trim(dd).length == 8)
		{
			var year = dd.substring(0,4);
			var month = dd.substring(4,6);
			var day = dd.substring(6,8);
			return year+"-"+month+"-"+day;
		}
		else if(trim(dd).length == 14)
		{
			var year = dd.substring(0,4);
			var month = dd.substring(4,6);
			var day = dd.substring(6,8);

			return year+"-"+month+"-"+day;
		}
		else
		{
			return dd;
		}
	}
}
function comma(x) {
    return nullChkZero(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function nullChkZero(d)
{
	if(d == "" || d == null || d == 'null' || d == undefined)
	{
		return "0";
	}
	else
	{
		var ret = d.toString().replace(/,/gi, ""); 
		return ret;
	}
}
function repWord(dd)
{
	dd = dd.replace(/&amt;/gi, "&");
	dd = dd.replace(/&lt;/gi, "<");
	dd = dd.replace(/&gt;/gi, ">");
	dd = dd.replace(/&quot;/gi, "\"");
	dd = dd.replace(/&#039;/gi, "\'");
	dd = dd.replace(/<br>/gi, "\n");
	return dd;
}

//문자열 검색해서 중간 글자 *로 만들기
//2글자면 마지막 글자만
function repName(dd) {
	if (dd.length > 2) {
	 var originName = dd.split('');
	 originName.forEach(function(name, i) {
	   if (i === 0 || i === originName.length - 1) 
		   return; originName[i] = '*';
	 });
	 var joinName = originName.join();
	 return joinName.replace(/,/g, '');
	} else {
	 var pattern = /.$/; // 정규식
	 return dd.replace(pattern, '*');
	}
};

//마스킹 처리 (이메일)
function repEmail(dd) {
	
	var len = dd.split('@')[0].length-4 ;  // das****@gmail.com
	
	dd = dd.replace(new RegExp('.(?=.{0,' + len + '}@)', 'g'), '*');

	return dd;
	
}
// 마스킹 처리 (핸드폰번호) 
function repTel(dd) {
	
	dd = dd.replace(/(\d{3})(\d{4})(\d{4})/gi,'$1****$3');
	
	return dd;
}

//마스킹 처리 (핸드폰번호) 
function repTel2(dd) {
	
	dd = dd.replace(/(\d{3})-(\d{4})-(\d{4})/gi,'$1****$3');
	
	return dd;
}

/* 특정 파일 업로드 */
function checkFile(f){

	var file = f.files;

	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);

	else return;
	
	f.outerHTML = f.outerHTML;
}

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function commas(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

function unhyphen(str) {
	
	str = String(str);
	return str.replace(/-/g, '');
}

// 기간 계산
function setSearchDate(start){

    var num = start.substring(0,1);
    var str = start.substring(1,2);

    var today = new Date();
 	var year =  today.getFullYear();            
    
    var endDate = $.datepicker.formatDate('yy-mm-dd', today);
    $('#finish_date').val(endDate);
    
    if(str == 'd')
    {
        today.setDate(today.getDate() - num);
    }
    else if (str == 'w')
    {
        today.setDate(today.getDate() - (num*7));
    }
    else if (str == 'm') 
    {
        today.setMonth(today.getMonth() - num);
        today.setDate(today.getDate() + 1);
    }
    else if (str == 'y')
    {
    	today.setYear(year - num); 
    	today.setMonth(today.getMonth());
        today.setDate(today.getDate());
    }

    var startDate = $.datepicker.formatDate('yy-mm-dd', today);
    $('#start_date').val(startDate);
            
   // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
    $("#finish_date").datepicker( "option", "minDate", startDate );
    
    // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
    $("#start_date").datepicker( "option", "maxDate", endDate );
}

//datepicker
$.datepicker.setDefaults({
	dateFormat : 'yy-mm',
	prevText : '이전 달',
	nextText : '다음 달',
	monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월','10월', '11월', '12월' ],
	monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월','9월', '10월', '11월', '12월' ],
	dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	showMonthAfterYear : true,
	yearSuffix : '년'
});

function selectUlInit_one(id) {
	  $('#'+id).each(function (index, element) {
	      var this_id = $(this).attr("id");
	      var title = $(this).attr("de-data");
	      $(this).wrap("<div class='select-box "+id+"_box'></div>");
	      $(this).parent(".select-box").prepend("<div class='selectedOption "+this_id+"'></div><ul class='select-ul "+this_id+"_ul'></ul>")
	      
	      $(element).each(function (idx, elm) {
	          $('option', elm).each(function (id, el) {
	              $('.select-box ul:last').append('<li>' + el.text + '</li>');
	          });
	          $('.select-box ul').hide();
	          $('.makeMeUl').children('div.selectedOption').text("select");
	      });
	      $('.select-box:last').children('div.selectedOption').text(title);
	  });
	 
	}
function _fnToNull(data) {
	// undifined나 null을 null string으로 변환하는 함수. 
		if (String(data) == 'undefined' || String(data) == 'null') 
		{ 
			return '' 
		} 
		else 
		{ 
		return data 
		} 
	}
    