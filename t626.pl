%% -*- Prolog -*-
% $Id: t626.pl,v 1.8 2005/04/04 13:32:42 cbrowne Exp $
% Inferences for T626

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

rawline(TAXPAYER, _YEAR, 'T626', 1, DAYS_OVERSEAS) :-
  taxfact(TAXPAYER, _YEAR, 'Days Working Overseas', DAYS_OVERSEAS).

rawline(TAXPAYER, _YEAR, 'T626', 6770, DAYS_OVERSEAS) :-
  line(TAXPAYER, _YEAR, 'T626', 1, DAYS_OVERSEAS).

rawline(TAXPAYER, _YEAR, 'T626', 'E', PORTION_OF_80K) :-
  line(TAXPAYER, _YEAR, 'T626', 1, DAYS_OVERSEAS),
  PORTION_OF_80K = 80000 * DAYS_OVERSEAS / 365.

rawline(TAXPAYER, _YEAR, 'T626', 2, EMP_INCOME) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [101,104], EMP_INCOME).

rawline(TAXPAYER, _YEAR, 'T626', 3, PROFFEES) :-
  line(TAXPAYER, _YEAR, 'T1', 212, PROFFEES).

rawline(TAXPAYER, _YEAR, 'T626', 4, RPP) :-
  line(TAXPAYER, _YEAR, 'T1', 207, RPP).

rawline(TAXPAYER, _YEAR, 'T626', 5, EMP_EXP) :-
  line(TAXPAYER, _YEAR, 'T1', 229, EMP_EXP).

rawline(TAXPAYER, _YEAR, 'T626', 6, DEDUCTIONS) :-
  sumoflines(TAXPAYER, _YEAR, 'T626', [3,4,5], DEDUCTIONS).

rawline(TAXPAYER, _YEAR, 'T626', 7, NET_EMP_INCOME) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T626', 2, 6, NET_EMP_INCOME).

rawline(TAXPAYER, _YEAR, 'T626', 'F', APPORTIONMENT) :-
  line(TAXPAYER, _YEAR, 'T626', 7, NET_INCOME),
  APPORTIONMENT = NET_INCOME * 4 / 5.

rawline(TAXPAYER, _YEAR, 'T626', 8, NET_INCOME) :-
  line(TAXPAYER, _YEAR, 'T1', 236, NET_INCOME).

rawline(TAXPAYER, _YEAR, 'T626', 9, LOANDEDN) :-
  line(TAXPAYER, _YEAR, 'T1', 248, LOANDEDN).

rawline(TAXPAYER, _YEAR, 'T626', 10, SHAREDEDN) :-
  line(TAXPAYER, _YEAR, 'T1', 249, SHAREDEDN).

rawline(TAXPAYER, _YEAR, 'T626', 11, NETCAPLOSS) :-
  line(TAXPAYER, _YEAR, 'T1', 253, NETCAPLOSS).

rawline(TAXPAYER, _YEAR, 'T626', 12, CAPGAINS) :-
  line(TAXPAYER, _YEAR, 'T1', 254, CAPGAINS).

rawline(TAXPAYER, _YEAR, 'T626', 13, DEDNS) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [250, 256], DEDNS).

rawline(TAXPAYER, _YEAR, 'T626', 14, TOT_DEDNS) :-
  sumoflines(TAXPAYER, _YEAR, 'T626', [9,10,11,12,13], TOT_DEDNS).
  
rawline(TAXPAYER, _YEAR, 'T626', 'G', NET) :-
  line(TAXPAYER, _YEAR, 'T626', 8, V1),
  line(TAXPAYER, _YEAR, 'T626', 14, V2),
  NET is V1 - V2.

rawline(TAXPAYER, _YEAR, 'T626', 15, FEDTAX) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 8, FEDTAX).

rawline(TAXPAYER, _YEAR, 'T626', 16, CREDITS) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 350, CREDITS).

rawline(TAXPAYER, _YEAR, 'T626', 'H', NETTAX) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T626', 15, 16, NETTAX).

rawline(TAXPAYER, _YEAR, 'T626', 17, RESULT) :-
  line(TAXPAYER, _YEAR, 'T626', 'E', E),
  line(TAXPAYER, _YEAR, 'T626', 'F', F),
  line(TAXPAYER, _YEAR, 'T626', 'G', G),
  line(TAXPAYER, _YEAR, 'T626', 'H', H),
  RESULT is min(E, F) / (G * H).

formatting(_YEAR, 'T626',
	[dl(1, "Days in Qualifying Period"),
	 dl('E', "$80K prorated over year"), 
	 dl(2, "Employment Income"),
	 dl(3, "Union/Professional Dues"), 
	 dl(4, "RPP Contributions"), 
	 dl(5, "Other Employment Expenses"), 
	 dl(6, "Total Employment Deductions"),
	 dl(7, "Net Employment Income"), 
	 dl('F', "80% of Net Employment Income"), 
	 dl(8, "Net Income for Year"), 
	 dl(9, "Home Relocation Loan Deduction"), 
	 dl(10, "Amount for shares deductible on line 249"), 
	 dl(11, "Net capital losses of other years"),
	 dl(12, "Capital Gains Deduction"),
	 dl(13, "Deductions - T1 lines 250, 256"),
	 dl(14, "Total Deductions"),
	 dl('G', "Net Income"),
	 dl(15, "Federal Tax"),
	 dl(16, "Nonrefundable tax credits"),
	 dl('H', "Net Federal Tax"),
	 dl(17, "Apportioned credits")
	 ]).
