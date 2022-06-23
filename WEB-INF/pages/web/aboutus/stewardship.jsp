<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<script src="/js/musign/aboutus.js"></script>
<div id="aboutus" class="stewardship">
	<div class="inner">
		<!-- <div class="sub-cont"> -->
			<!-- <div class="sub-cont-inner"> -->
		<div class="sub-tit-wr">
			<jsp:include page="../sub_common/svg_wave.jsp"/>
			<p class="sub-tit">About Us</p>
			<p class="sub-txt"></p>
		</div>
		<!-- //sub-tit-wr -->
		
		<div class="sub-cont">
			<div class="sub-cont-inner">
				<div class="nav-wr">
					<ul class="nav">
						<li class="nav-it n1"><a href="philosophy">Philosophy</a></li>
						<li class="nav-it n2"><a href="history">History</a></li>
						<li class="nav-it n3"><a href="stewardship">Stewardship Code</a></li>
					</ul>
				</div>
				<div class="cont-wr">
					<div class="notice-wr">
						<p class="notice ko-txt">
							더웰스인베스트먼트 주식회사(이하 “당사”)는 한국기업지배구조원(CGS)의 스튜어드십 코드 제정위원회가 제정하여 공표한 한국 스튜어드십 코드『기관투자자의 수탁자 책임에 관한 원칙』에 의거하여 다음과 같이 스튜어드십 코드를 시행합니다.  
						</p>
					</div><!-- //notice-wr -->
					<div class="part1">
						<h3>I. 수탁자 책임에 관한 기본입장</h3>
						<div class="cont">
							<p>타인 자산의 관리와 운용에 있어서 제반 책임을 충실히 이행하고, 투자대상 회사의 가치제고를 위해 최선을 다한다.</p>
						</div>
					</div>
					<h3>II. 세부 원칙별 이행계획</h3>
					<ul class="tab-wr">
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 1</p>
								<p class="tit">
									기관투자자는 고객, 수익자 등 타인 자산을 관리ㆍ운영하는 수탁자로서 책임을 충실히 이행하기 위한 명확한 정책을 마련해 공개해야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사는 출자자로부터 부여 받은 책임을 충실히 이행하기 위하여 선량한 관리자의 주의의무를 다하고, 관련 법령과 정관 및 규약에 따라 수탁자로서의 책임을 수행하고 있습니다.</p>
								
								<p>당사는 출자자 이익 우선 정책을 취하고 있습니다. 당사는 출자자의 이익을 최우선으로 고려하고, 모든 출자자의 이익을 동등하게 다루고 있습니다. 
								펀드의 결성, 운영 및 청산시에 합리적 이유 없이 특정 출자자를 우대하거나 차별 취급하지 아니하고 있습니다.</p>
								
								<p>당사는 수탁자로서의 책임 이행을 위하여 이해상충 문제의 예방 및 대응, 투자대상회사와의 소통 및 관리를 통한 가치 제고, 
								절차에 따른 적정한 의결권의 행사 및 관련 사항의 보고, 구성원의 역량 및 전문성 향상 등을 준수하며 직무를 성실히 수행하고 있습니다.</p>
							</div>
						</li>
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 2 </p>
								<p class="tit">
									기관투자자는 수탁자로서 책임을 이행하는 과정에서 실제 직면하거나 직면할 가능성이 있는 이해상충 문제를 어떻게 해결할지에 관해 효과적이고 명확한 정책을 마련하고 내용을 공개해야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사는 수탁자로서 책임을 이행하는 과정에서 발생할 가능성이 있는 이해상충 문제를 해결하기 위하여 이해상충방지규정을 마련하여 이를 준수하고 있습니다.</p>
								
								<p>당사는 당사와 출자자 간, 출자자 상호간 또는 펀드 상호간 등의 관계에서 이해상충 문제에 직면하거나 직면할 가능성이 있는 경우, 
								당사는 그 위험성을 충실히 검토하여 출자자에게 통지하는 절차를 거치고, 이해상충 방지 수단을 강구하여 출자자 보호 등에 문제가 발생하지 아니하도록 조치하고 있습니다.
							</div>
						</li>
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 3 </p>
								<p class="tit">
									기관투자자는 투자대상회사의 중장기적인 가치를 제고하여 투자자산의 가치를 보존하고 높일 수 있도록 투자대상회사를 주기적으로 점검해야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사는 투자대상회사의 중장기적 가치제고를 위해 주기적으로 투자대상회사의 경영진과 주요 현안에 대해서 논의하는 등 현황을 파악하고 점검하는 원칙을 준수하고 있으며,
								필요한 경우 펀드 운용인력을 투자대상회사의 이사로 등재하여 투자대상회사의 주요 의사결정에 참여하고 있습니다.</p>
								
								<p>당사는 투자대상회사별 특성에 따른 경영진/핵심인력 보강, 경영 효율성 개선, 비핵심 자산 매각, 재무구조 조정 등 다각적인 가치 제고 전략 수립을 통해 투자대상회사에 적절한 가치 제고 방안을 제시하고 있습니다.</p>
								
								<p>당사는 투자대상회사의 분∙반기부터 연간에 이르는 재무 및 자금 상황의 보고 체계를 구축하고 있으며, 그 내용을 체계적으로 관리하고 있습니다.</p>
							</div>
						</li>
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 4 </p>
								<p class="tit">
									기관투자자는 투자대상회사와의 공감대 형성을 지향하되, 필요한 경우 수탁자 책임 이행을 위한 활동 전개 시기와 절차, 방법에 관한 내부지침을 마련해야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사는 투자검토 단계부터 투자대상회사의 경영진 및 핵심인력과의 교류를 통해 신뢰를 확보하며 공감대 형성을 위하여 노력하는 한편, 
								대주주 및 경영진에 대한 Reference Check를 실시하여 도덕성, 투명성 등을 사전 검증하고 있으며, 계약서 작성 시 준법감시인을 통해 도덕적 해이를 예방하고 있습니다.</p>
								
								<p>당사는 투자대상회사의 상황을 지속적으로 점검하고 당사의 의견이 투자대상회사의 경영에 적절하게 반영되도록 노력하고 있으며, 
								필요한 경우 투자대상회사 내지 대주주와의 계약서에 대주주 및 특수관계인/계열사와의 거래, 제3자에 대한 자금 대여/담보 제공 등은 투자자의 사전동의사항으로 한다는 내용을 명시하고 있고, 
								대주주 및 경영진의 계약 위반시 매수청구 내지 손해배상 청구가 가능하도록 투자계약서에 반영하고 있습니다. 
								또한, 주주제안권 및 임시주주총회 소집청구권 등 상법상 주주권의 적극적 행사와 이사회 참여 등의 방법을 통하여 수탁자로서의 책임을 다하고 있습니다.</p>
							</div>
						</li>
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 5 </p>
								<p class="tit">
									기관투자자는 충실한 의결권 행사를 위한 지침ㆍ절차ㆍ세부기준을 포함한 의결권 정책을 마련해 공개해야 하며, 의결권 행사의 적정성을 파악할 수 있도록 의결권 행사의 구체적인 내용과 그 사유를 함께 공개해야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사는 투자대상회사의 주주총회 및 이사회에서 펀드 및 출자자의 이익을 우선으로 하여 의결권을 행사함을 기본 원칙으로 삼고 있으며, 
								의결권은 사안별로 이해관계 및 필요성의 관점에서 판단하여 행사방향을 결정하는 것을 원칙으로 하고 있습니다.</p>
								
								<p>당사의 투자대상회사에 대한 의결권 행사는 투자대상회사 담당 심사역이 제안한 후 내부 협의를 거쳐 당사 내부 의결권자들의 승인에 의하여 결정하며, 
								그 내역은 ERP에 보관 및 관리하고, 추후 정해진 절차에 따라 출자자 등에게 보고하고 있습니다.</p>
							</div>
						</li>
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 6 </p>
								<p class="tit">
									기관투자자는 의결권 행사와 수탁자 책임 이행 활동에 관해 고객과 수익자에게 주기적으로 보고해야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사는 의결권 행사를 포함한 펀드 및 투자대상회사에 관한 주요 사항 등 수탁자로서의 책임 이행을 기록하여 일정 기간 보존하며, 주기적으로 출자자들에게 보고하고 있습니다.</p>
								
								<p>반기 및 연간단위로 투자보고회를 개최하여 투자대상회사의 현황 및 사후관리 내용 등을 보고하고 있습니다.</p>
							</div>
						</li>
						<li class="tab-it cur-on">
							<div class="tab-tit">
								<p class="tit-num">원칙 7 </p>
								<p class="tit">
									기관투자자는 수탁자 책임의 적극적이고 효과적인 이행을 위해 필요한 역량과 전문성을 갖추어야 한다.
								</p>
							</div>
							<div class="tab-cont dot" style="display:none;">
								<p>당사의 투자본부는 각 분야별 전문성을 갖춘 인력으로 구성되어 있습니다. 
								산업 전문가 및 투자 분야 경험이 풍부한 투자심사역을 중심으로 투자 산업에 따른 전문성을 높이고 수탁자 책임을 다하기 위해 직무능력 관련 교육개발 프로그램의 참여 및 산업 전문가 과정 등을 적극적으로 지원하여, 
								투자대상회사의 가치 제고와 출자자 이익 도모에 힘쓰고 있습니다.</p>
								
								<p>당사는 투자본부와 독립된 리스크관리실 및 경영지원실을 운용하며, 전담인력을 통하여 조합운용, 투자, 
								사후관리 등의 과정에서 발생할 수 있는 리스크를 관리하고 제반 법규 및 선량한 관리자의 주의의무를 준수할 수 있도록 노력하고 있습니다.</p>
							</div>
						</li>
					</ul><!-- //tab-wr -->
					<p class="manager dn">담당자 : 박성하실장 <a class="en-txt" href="mailTo:shpark@investwells.com">shpark@investwells.com </a></p>
				</div>
			</div>
		</div>
		<!-- //sub-cont -->
	</div>	
</div>

<script>
	$(function(){
		var tabBtn = $('.stewardship .tab-wr .tab-it .tab-tit');
		tabBtn.click(function(e, i){
			var tabIt = $(this).closest($('.tab-it'));
			$(this).siblings($('.tab-cont')).slideToggle(500);
// 			$('.stewardship .tab-wr .tab-it').removeClass('on')
			
			if( tabIt.hasClass('on') ){
				tabIt.removeClass('on');
			} else{
				tabIt.addClass('on')				
			}
		})
	})
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>