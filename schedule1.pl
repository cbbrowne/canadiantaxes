%% -*- Prolog -*-
% $Id: schedule1.pl,v 1.8 2005/04/05 12:09:57 cbrowne Exp $
% Inferences for Schedule 1
% 2003 Rules Prepared by
% Christopher B. Browne
% cbbrowne Computing Inc
% cbbrowne@acm.org


%Copyright (c) Christopher B. Browne, cbbrowne Computing Inc.
%All rights reserved.

%Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions
%are met:
%1. Redistributions of source code must retain the above copyright
%   notice, this list of conditions and the following disclaimer.
%2. Redistributions in binary form must reproduce the above copyright
%   notice, this list of conditions and the following disclaimer in the
%   documentation and/or other materials provided with the distribution.
%3. Neither the name of the Company nor the names of its contributors
%   may be used to endorse or promote products derived from this software
%   without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COMPANY AND CONTRIBUTORS ``AS IS''
%AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
%THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
%PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
%BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
%BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
%WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
%OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
%IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%LURID DISCLAIMER:  START

%Note that I Am Not A Lawyer, and provide neither legal advice nor
%advice about managing your taxes.  If your use of this software leads
%to your getting audited, or to you paying either too little or too
%much tax, just remember that I denied that I was offering tax or legal
%advice.

%Imagine further lurid warnings like "Contains live plague bacteria.
%Beware the Rabid Hippopotami.  May cause bleeding at the eyes.

%LURID DISCLAIMER:  END

rawline(TAXPAYER, _YEAR, 'Schedule 1', 1, TINC) :-
  line(TAXPAYER, _YEAR, 'T1', 260, TINC).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 2, TINC) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, TINC).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 3, BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 2, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Lowest Marginal Portion', M1),
  AMT < M1 + 1,
  !,
  BASE is 0.

rawline(TAXPAYER, _YEAR, 'Schedule 1', 3, BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 2, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Lowest Marginal Portion', M1),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Middle Marginal Portion', M2),
  AMT > M1,
  AMT < M2,
  !,
  BASE is M1.

rawline(TAXPAYER, _YEAR, 'Schedule 1', 3, BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 2, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Middle Marginal Portion', M2),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Top Marginal Portion', M3),
  M2 < AMT,
  AMT < M3,
  !,
  BASE is M2.
rawline(TAXPAYER, _YEAR, 'Schedule 1', 3, BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 2, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Top Marginal Portion', M3),
  M3 < AMT,
  !,
  BASE is M3.

rawline(TAXPAYER, _YEAR, 'Schedule 1', 4, AMT_AT_TOP_MARGINAL_RATE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 2, TOTAL_INCOME),
  line(TAXPAYER, _YEAR, 'Schedule 1', 3, MARGIN),
  AMT_AT_TOP_MARGINAL_RATE is TOTAL_INCOME - MARGIN.

rawline(TAXPAYER, _YEAR, 'Schedule 1', 5, RATE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Lowest Marginal Portion', M1),
  AMT < M1 + 1,
  !,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base Tax Rate', RATE);
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Lowest Marginal Portion', M1),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Middle Marginal Portion', M2),
  AMT > M1,
  AMT < M2 + 1,
  !,
  RATE is 22;
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Middle Marginal Portion', M2),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Top Marginal Portion', M3),
  AMT > M2,
  AMT < M3 + 1,
  !,
  RATE is 26;
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, AMT),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Top Marginal Portion', M3),
  AMT > M3,
  !,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Top Tax Rate', RATE).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 6, TAX_AT_TOP_MARGIN) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 4, AMT_AT_TOP_RATE),
  line(TAXPAYER, _YEAR, 'Schedule 1', 5, RATE),
  RAW_AMT is AMT_AT_TOP_RATE * RATE,
%  TAX_AT_TOP_MARGIN is round(RAW_AMT / 100).
  TAX_AT_TOP_MARGIN is round(RAW_AMT / 100).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 7, TAX_ON_BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, INCOME),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Lowest Marginal Portion', M1),
  INCOME < M1,
  !,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base - Lowest', TAX_ON_BASE).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 7, TAX_ON_BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, INCOME),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Lowest Marginal Portion', M1),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Middle Marginal Portion', M2),
  INCOME > M1,
  INCOME < M2,
  !,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base - Low', TAX_ON_BASE).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 7, TAX_ON_BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, INCOME),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Middle Marginal Portion', M2),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Top Marginal Portion', M3),
  INCOME > M2,
  INCOME < M3,
  !,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base - Medium', TAX_ON_BASE).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 7, TAX_ON_BASE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 1, INCOME),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Top Marginal Portion', M3),
  INCOME > M3,
  !,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base - Top', TAX_ON_BASE).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 8, FED_TAX) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 6, MARGIN),
  line(TAXPAYER, _YEAR, 'Schedule 1', 7, BASE),
  !,
  FED_TAX is BASE + MARGIN;
  line(TAXPAYER, _YEAR, 'Schedule 1', 6, FED_TAX).

rawline(_TAXPAYER, _YEAR, 'Schedule 1', 300, AMT) :- 
  line(_TAXPAYER, _YEAR, 'Annual Rates', 'Federal Basic Personal Amount', AMT).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 301, AGEAMT) :-
  taxfact(TAXPAYER, _YEAR, 'Age', AGE),
  AGE > 65,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Age Amount', AGEAMT).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 303, SPOUSAL_AMT) :-
  taxfact(TAXPAYER, _YEAR, 'Spouse', SPOUSE_SIN),
  line(SPOUSE_SIN, 'T1', 150, SPOUSE_INCOME),
  line(TAXPAYER, _YEAR, 'Federal Spousal Income Amount', SPAMT),
  line(TAXPAYER, _YEAR, 'Federal Maximum Spousal Credit', SPCR),
  SPOUSAL_AMT is min(SPCR, max(0, SPAMT - SPOUSE_INCOME)).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 305, DEPS) :-
  line(TAXPAYER, _YEAR, 'Schedule 5', 305, DEPS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 306, DEPS) :-
  line(TAXPAYER, _YEAR, 'Schedule 5', 306, DEPS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 308, CPPQPP) :-
  sumoflines(TAXPAYER, _YEAR, 'T4', [16, 17], AMT),
  line(_TAXPAYER, _YEAR, 'Annual Rates', 'Federal Maximum CPP', MAXCPP),
  CPPQPP is min(AMT, MAXCPP).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 310, PERSCPP) :-
  line(TAXPAYER, _YEAR, 'Schedule 8', 11, PERSCPP).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 312, UIC) :-
  line(TAXPAYER, _YEAR, 'T4', 18, UIC).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 315, DEPS) :-
  line(TAXPAYER, _YEAR, 'Schedule 5', 315, DEPS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 335, DEDNS) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [300, 301, 303, 305, 306, 308, 310, 312, 314, 315, 316, 318, 
			  319, 323, 324, 326, 332], DEDNS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 338, DEDNCREDIT) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 335, DEDNS),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base Tax Rate', RATE),
  DEDNCREDIT is (DEDNS * RATE / 100).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 349, DONATIONS) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 9, DONATIONS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 350, TOTAL_CREDITS) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [338, 349], TOTAL_CREDITS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 9, X) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 8, X).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 10, X) :-
  line(TAXPAYER, _YEAR, 'T1206', 4, X).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 11, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [9, 10], TTL).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 425, DIVTAXCREDIT) :-
  line(TAXPAYER, _YEAR, 'T1', 120, DIVS),
  DIVTAXCREDIT is (DIVS * 2 / 15).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 426, OVERSEAS) :-
  line(TAXPAYER, _YEAR, 'T626', 17, OVERSEAS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 12, TAXES) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [350, 425, 426, 427], TAXES).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 13, BASIC_FED_TAX) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'Schedule 1', 11, 12, BASIC_FED_TAX).

rawline(_TAXPAYER, _YEAR, 'Schedule 1', 14, 0).
% Simplified FTC away...

rawline(TAXPAYER, _YEAR, 'Schedule 1', 15, FED_TAX) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'Schedule 1', 13, 14, FED_TAX).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 413, LSIFCOST) :-
  sumoflines(TAXPAYER, _YEAR, 'LSIF', [2, 4], LSIFCOST).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 414, LSIFCREDIT) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 413, LSIFCOST),
  LSIFCREDIT is (LSIFCOST * 15) / 100.

rawline(TAXPAYER, _YEAR, 'Schedule 1', 16, MORE_CREDITS) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [410, 412, 414], MORE_CREDITS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 416, MORE_CREDITS) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 16, MORE_CREDITS).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 17, NET_TAX) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'Schedule 1', 15, 16, NET_TAX).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 417, MORE) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 17, MORE).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 19, NET_FED_TAX) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [17, 18], NET_FED_TAX).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 419, NET) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 19, NET).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 431, NONBIZTAX) :-
  taxfact(TAXPAYER, _YEAR, 'Non-business foreign business tax', NONBIZTAX).

rawline(TAXPAYER, _YEAR, 'Schedule 1', 433, BIZPROP) :-
  taxfact(TAXPAYER, _YEAR, 'Non-business foreign business income', NONBIZINCOME),
  line(TAXPAYER, _YEAR, 'T1', 256, DEDUCTED_EXEMPT),
  line(TAXPAYER, _YEAR, 'T626', 'E', LINEE),
  line(TAXPAYER, _YEAR, 'T626', 'F', LINEF),
  NETFOREIGNNONINC is NONBIZINCOME - DEDUCTED_EXEMPT - min(LINEE, LINEF),
  line(TAXPAYER, _YEAR, 'T1', 256, NET_INCOME),
  sumoflines(TAXPAYER, _YEAR, 'T1', [248,249,250,253,254], TAXINC_DEDNS),
  NETINC is NET_INCOME - TAXINC_DEDNS,
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [429, 425, 426], TAXES),
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [440,441], TAX_ABATEMENTS),
  NETTAXES is TAXES - TAX_ABATEMENTS,
  BIZPROP is NETFOREIGNNONINC / (NETINC * NETTAXES).

formatting(_YEAR, 'Schedule 1',
	   [dl(1, "Taxable Income"), dl(2, "Taxable Income"), dl(3,"Base Portion"), 
	    dl(4,"Amt At Top Marginal Rate"), dl(5,"Top Rate"), dl(6,"Tax at Top Rate"), 
	    dl(7,"Tax on Base"), tl(8, "Gross Tax"), dl(300, "Basic Personal Amount"),
	    dl(301, "Age Amount"), dl(303, "Spouse amount"), dl(305, "Dependent Amount"),
	    dl(306, "Infirm Dependent"), dl(308, "CPP/QPP Deductions from employment"),
	    dl(310, "CPP/QPP Selfemployment Deductions"), dl(312, "EIC"), 
	    dl(314, "Pension Income"), dl(315, "Caregiver Amount"), dl(316, "Disability Amount"),
	    dl(318, "Disability Amount for Dependent"), dl(319, "Interest on student loans"),
	    dl(323, "Tuition and education amounts"), dl(324, "Tuition/Education Transferred"),
	    dl(326, "Amounts transferred from spouse"), dl(330, "Medical Expenses"),
	    dl(331, "Medical expenses Adjustment"), tl(332, "Medical Expense Dedn"),
	    tl(335, "Total Credits"), dl(338, "Total Credits at lowest Federal Tax Rate"),
	    dl(349, "Charitable Donations Credit"), tl(350, "Total federal nonrefundable credits"),
	    dl(9, "Federal Tax"), dl(10, "Federal Tax on split income"), 
	    tl(11, "Total Federal Tax"), dl(350, "Total nonrefundable credits"),
	    dl(425, "Federal Dividend Tax Credit"), dl(426, "Overseas employment tax credit"),
	    dl(427, "Minimum tax carryover"), tl(12, "Total Credits"),
	    tl(13, "Basic Federal Tax"), dl(14, "Federal foreign tax credit"),
	    tl(15, "Federal Tax"), dl(409, "Total federal political contributions"),
	    dl(410, "Federal political contribution tax credit"), dl(412, "Investment tax credit"),
	    dl(413, "Labour-sponsored funds tax credit: net cost"),
	    dl(414, "Labour-sponsored funds tax credit: allowable credit"),
	    tl(416, "Total of 410, 412, 414"), dl(16, "Total credits"),
	    tl(17, "Net taxes"), dl(18, "Additional tax on RESP payments"),
	    tl(19, "Net federal tax")]).	
