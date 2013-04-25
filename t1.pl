%% -*- Prolog -*-
% $Id: t1.pl,v 1.5 2005/04/04 13:32:42 cbrowne Exp $

% Inferences for T1 form
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

rawline(TAXPAYER, _YEAR, 'T1', 101, EMPLOYMENT_INCOME) :-
  line(TAXPAYER, _YEAR, 'T4', 14, EMPLOYMENT_INCOME).

rawline(TAXPAYER, _YEAR, 'T1', 120, DIVS) :-
  line(TAXPAYER, _YEAR, 'Schedule 4', 120, DIVS).

rawline(TAXPAYER, _YEAR, 'T1', 121, INTEREST_INCOME) :-
  line(TAXPAYER, _YEAR, 'Schedule 4', 121, INTEREST_INCOME).

rawline(TAXPAYER, _YEAR, 'T1', 122, PARTNERSHIP) :-
  line(TAXPAYER, _YEAR, 'Schedule 4', 122, PARTNERSHIP).

rawline(TAXPAYER, _YEAR, 'T1', 129, RRSP_INCOME) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 7', [15,17], RRSP_INCOME).

rawline(TAXPAYER, _YEAR, 'T1', 147, TOTAL) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [144,145,146], TOTAL).

rawline(TAXPAYER, _YEAR, 'T1', 150, TOTAL_INCOME) :-
  sumoflines(TAXPAYER, _YEAR, 'T1',
	[101, 104, 113, 114, 115, 119, 120, 121, 122, 126, 127, 128, 129, 130, 135, 137, 139, 141, 143, 147],
	TOTAL_INCOME).

rawline(TAXPAYER, _YEAR, 'T1', 208, RRSP) :-   % RRSP contribution
  line(TAXPAYER, _YEAR, 'Schedule 7', 13, RRSP).

rawline(TAXPAYER, _YEAR, 'T1', 212, PROF_EXP) :-  % Professional Fees
  taxfact(TAXPAYER, _YEAR, 'Professional Fees', PFEES),
  line(TAXPAYER, _YEAR, 'T4', 32, UNION_DUES),
  PROF_EXP is PFEES + UNION_DUES;
  taxfact(TAXPAYER, _YEAR, 'Professional Fees', PROF_EXP);
  line(TAXPAYER, _YEAR, 'T4', 32, PROF_EXP).
  
rawline(TAXPAYER, _YEAR, 'T1', 221, CARRYING) :-
  line(TAXPAYER, _YEAR, 'Schedule 4', 221, CARRYING).

rawline(TAXPAYER, _YEAR, 'T1', 222, PERSCPP) :-
  line(TAXPAYER, _YEAR, 'Schedule 8', 11, PERSCPP).

rawline(TAXPAYER, _YEAR, 'T1', 233, DEDUCTIONS) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [229, 231, 232, 207, 208, 209, 212, 214, 215, 217, 219, 220, 221, 222, 224], DEDUCTIONS).

rawline(TAXPAYER, _YEAR, 'T1', 234, NET_INCOME) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T1', 150, 233, NET_INCOME).

rawline(TAXPAYER, _YEAR, 'T1', 236, NET_INCOME) :- 
  difflines_min_zero(TAXPAYER, _YEAR, 'T1', 234, 235, NET_INCOME).

rawline(TAXPAYER, _YEAR, 'T1', 257, TOTAL248TO256):-
  sumoflines(TAXPAYER, _YEAR, 'T1', [248, 249, 250, 251, 252, 253, 254, 255, 256], TOTAL248TO256).

rawline(TAXPAYER, _YEAR, 'T1', 260, TAXABLE_INCOME) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T1', 236, 257, TAXABLE_INCOME),
  !.

rawline(TAXPAYER, _YEAR, 'T1', 420, FEDTAX) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 19, FEDTAX).

rawline(TAXPAYER, _YEAR, 'T1', 428, ONTTAX) :-
  line(TAXPAYER, _YEAR, 'ON428', 70, ONTTAX).

rawline(TAXPAYER, _YEAR, 'T1', 435, TOTAL_PAYABLE) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [420, 421, 422, 428], TOTAL_PAYABLE).

rawline(TAXPAYER, _YEAR, 'T1', 437, SOURCETAX) :-
  line(TAXPAYER, _YEAR, 'T4', 22, SOURCETAX).

rawline(TAXPAYER, _YEAR, 'T1', 448, OVERPAID) :-
  line(TAXPAYER, _YEAR, 'T2204', 6, OVERPAID).

rawline(TAXPAYER, _YEAR, 'T1', 479, PROVCREDITS) :-
  line(TAXPAYER, _YEAR, 'ON479', 35, ONTCREDITS),
  PROVCREDITS is ONTCREDITS.

rawline(TAXPAYER, _YEAR, 'T1', 482, TOTAL_CREDITS) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [437, 440, 448, 450, 452, 454, 456, 457, 476, 479], TOTAL_CREDITS).

rawline(TAXPAYER, _YEAR, 'T1', 484, REFUND) :-
  line(TAXPAYER, _YEAR, 'T1', 435, TOTAL_PAYABLE),
  line(TAXPAYER, _YEAR, 'T1', 482, TOTAL_CREDITS),
  TOTAL_CREDITS > TOTAL_PAYABLE,
  REFUND is TOTAL_CREDITS - TOTAL_PAYABLE.

rawline(TAXPAYER, _YEAR, 'T1', 485, OWING) :-
  line(TAXPAYER, _YEAR, 'T1', 435, TOTAL_PAYABLE),
  line(TAXPAYER, _YEAR, 'T1', 482, TOTAL_CREDITS),
  TOTAL_CREDITS < TOTAL_PAYABLE,
  OWING is TOTAL_PAYABLE - TOTAL_CREDITS.

formatting(_YEAR, 'T1',
	[dl(101, "Employment Income"),
	 dl(102, "Commissions"), 
	 dl(104, "Other Employment Income"),
	 dl(113, "OAS Pension"), 
	 dl(114, "CPP/QPP Benefits"), 
	 dl(152, "Disability Benefits"), 
	 dl(115, "Other pension"), 
	 dl(119, "EI Income"), 
	 dl(120, "Taxable Dividends"), 
	 dl(121, "Interest Income"), 
	 dl(122, "Net partnership income"), 
	 dl(126, "Rental Income"), 
	 dl(127, "Taxable Capital Gains"), 
	 dl(156, "Support Payments"), 
	 dl(128, "Taxable Portion"), 
	 dl(129, "RRSP Income"), 
	 dl(130, "Other Income"), 
	 dl(135, "Business income"), 
	 dl(137, "Professional income"), 
	 dl(139, "Commission income"), 
	 dl(141, "Farming income"), 
	 dl(143, "Fishing income"),
	 dl(144, "WCB"), 
	 dl(145, "Social Assistance"), 
	 dl(146, "Federal Supplements"),
	 dl(147, "Total Government Assistance"),
	 tl(150, "Total Income"),
	 dl(206, "Pension Adjustment"), 
	 dl(207, "RPP Deductions"), 
	 dl(208, "RRSP Deduction"),
	 dl(209, "Sask Pension Plan"), 
	 dl(212, "Union/Professional Dues"), 
	 dl(214, "Child Care Expenses (T778)"),
	 dl(215, "Attendant care expenses"), 
	 dl(228, "Gross Business Investment Loss"),
	 dl(217, "Allowable deduction"), 
	 dl(219, "Moving Expenses"), 
	 dl(230, "Total Support Payments"),
	 dl(220, "Support Payments - Allowable Deduction"), 
	 dl(221, "Carrying charges and interest charges"),
	 dl(222, "Deduction for CPP/QPP on self-employment earnings"), 
	 dl(224, "Exporation and development expenses"),
	 dl(229, "Other employment expenses"), 
	 dl(231, "Clergy residence deduction"),
	 dl(232, "Other deductions"), 
	 tl(233, "Total Deductions"),
	 tl(234, "Net income before adjustments"), 
	 dl(235, "Social Benefits Repayment"),
	 tl(236, "Net Income"),
	 dl(248, "Employee home relocation loan deduction"),
	 dl(249, "Stock options deductions"),
	 dl(250, "Other payments deduction"),
	 dl(251, "Limited partnership losses of other years"),
	 dl(252, "Non-capital losses of other years"),
	 dl(253, "Net capital losses of other years"),
	 dl(254, "Capital gains deduction"),
	 dl(255, "Northern Residents deductions"),  % T2222
	 dl(256, "Additional Deductions"),
	 tl(257, "Total Deductions from net income"),
	 tl(260, "Taxable Income"),
	 dl(420, "Net federal tax"),
	 dl(421, "CPP contrib on self-employment"),
	 dl(422, "Social benefits repayment"),
	 dl(428, "Provincial or territorial tax"),
	 tl(435, "Total Tax Payable"),
	 dl(437, "Total income tax deducted"),
	 dl(440, "Refundable Quebec abatement"),
	 dl(448, "CPP overpayment"),
	 dl(450, "EIC overpayment"),
	 dl(452, "Refundable medical expense supplement"),
	 dl(454, "Refund of ITC (T2038(IND))"),
	 dl(456, "Part XII.2 trust tax credit"),
	 dl(457, "Employee and partner GST/HST rebate"),
	 dl(476, "Tax paid by instalments"),
	 dl(479, "Provincial/territorial credits (Form 479)"),
	 tl(482, "Total Credits"),
	 tl(435, "Difference"),
	 tl(484, "Refund"),
	 tl(485, "Balance owing"),
	 tl(486, "Amount Enclosed")
     ]).
