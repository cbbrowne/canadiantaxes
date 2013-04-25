%% -*- Prolog -*-
% $Id: on479.pl,v 1.4 2005/04/04 13:32:42 cbrowne Exp $
% Inferences for Ontario ON79

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

rawline(TAXPAYER, _YEAR, 'ON479', 1, NET_INCOME) :-
   line(TAXPAYER, _YEAR, 'T1', 236, NET_INCOME).

% line 2 is spouse's net income...
rawline(TAXPAYER, _YEAR, 'ON479', 2, SPOUSAL_INCOME) :-
   taxfact(TAXPAYER, _YEAR, 'Spouse', SPOUSE_SIN),
   line(SPOUSE_SIN, 'T1', 236, SPOUSAL_INCOME).

rawline(TAXPAYER, _YEAR, 'ON479', 3, CREDIT_INCOME) :-
   sumoflines(TAXPAYER, _YEAR, 'ON479', [1,2], CREDIT_INCOME).

rawline(TAXPAYER, _YEAR, 'ON479', 4, RENT_MULT) :-
  taxfact(TAXPAYER, _YEAR, 'Rent', RENT),
  RENT_MULT is (RENT / 5).

rawline(TAXPAYER, _YEAR, 'ON479', 6110, R) :- 
  line(TAXPAYER, _YEAR, 'ON479', 4, R).

rawline(TAXPAYER, _YEAR, 'ON479', 5, PTAX) :-
  taxfact(TAXPAYER, _YEAR, 'Property Taxes', PTAX).

rawline(TAXPAYER, _YEAR, 'ON479', 6112, R) :- 
  line(TAXPAYER, _YEAR, 'ON479', 5, R).

rawline(TAXPAYER, _YEAR, 'ON479', 6, STUDENT_CLAIM) :-
  taxfact(TAXPAYER, _YEAR, 'Tuition', _TUITION_EXISTS),
  STUDENT_CLAIM is 25.

rawline(TAXPAYER, _YEAR, 'ON479', 6114, R) :-
  line(TAXPAYER, _YEAR, 'ON479', 6, R).

rawline(TAXPAYER, _YEAR, 'ON479', 7, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [4,5,6], TTL).

rawline(TAXPAYER, _YEAR, 'ON479', '8base', BASE) :-
  taxfact(TAXPAYER, _YEAR, 'Age', AGE),
  AGE > 65,
  BASE is 500;
  BASE is 250.

rawline(TAXPAYER, _YEAR, 'ON479', 8, AMT) :-
  line(TAXPAYER, _YEAR, 'ON479', '8base', BASE),
  line(TAXPAYER, _YEAR, 'ON479', 7, PAID),
  AMT is min(PAID, BASE).

rawline(TAXPAYER, _YEAR, 'ON479', 9, SEVENBY10):-
  line(TAXPAYER, _YEAR, 'ON479', 7, BASE),
  SEVENBY10 is (BASE / 10).

rawline(TAXPAYER, _YEAR, 'ON479', 10, PTC) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [8,9], PTC).

rawline(_TAXPAYER, _YEAR, 'ON479', 11, BASIC) :-
  BASIC is 100.

rawline(TAXPAYER, _YEAR, 'ON479', 6033, V) :-
  line(TAXPAYER, _YEAR, 'ON479', 11, V).

rawline(TAXPAYER, _YEAR, 'ON479',12, SPOUSE) :-
  taxfact(TAXPAYER, _YEAR, 'Spouse', _),
  SPOUSE is 100.

rawline(TAXPAYER, _YEAR, 'ON479', 6035, V):-
  line(TAXPAYER, _YEAR, 'ON479', 12, V).

rawline(TAXPAYER, _YEAR, 'ON479', 13, KIDS_CREDIT) :-
  taxfact(TAXPAYER, _YEAR, 'Dependent Children', NUM),
  KIDS_CREDIT is NUM * 50.

rawline(TAXPAYER, _YEAR, 'ON479', 6099, V):-
  line(TAXPAYER, _YEAR, 'ON479', 13, V).

rawline(TAXPAYER, _YEAR, 'ON479', 14, SALES_TAX_CREDIT) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [11, 12, 13], SALES_TAX_CREDIT).

rawline(TAXPAYER, _YEAR, 'ON479', 15, ONT_CREDIT) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [10, 14], ONT_CREDIT).

rawline(TAXPAYER, _YEAR, 'ON479', 16, INC_BASE) :-
  taxfact(TAXPAYER, _YEAR, 'Age', A),
  A < 65,
  line(TAXPAYER, _YEAR, 'ON479', 3, INCOME),
  INC_BASE is max((INCOME - 4000) / 50 , 0);
  line(TAXPAYER, _YEAR, 'ON479', 3, INCOME),
  INC_BASE is max((INCOME - 22000) / 25, 0).

rawline(TAXPAYER, _YEAR, 'ON479', 17, AMT) :-
  line(TAXPAYER, _YEAR, 'ON479', 15, ONT_CREDIT),
  line(TAXPAYER, _YEAR, 'ON479', 16, DEDUCT),
  AMT is max(0, ONT_CREDIT - DEDUCT).

rawline(TAXPAYER, _YEAR, 'ON479', 18, CREDIT) :-
  line(TAXPAYER, _YEAR, 'ON479', 17, BC),
  CREDIT is min(BC, 1000).

rawline(TAXPAYER, _YEAR, 'ON479', 19, POLITICAL) :-
  taxfact(TAXPAYER, _YEAR, 'Ontario Political Contributions', POLITICAL).

rawline(TAXPAYER, _YEAR, 'ON479', 6310, P) :-
  line(TAXPAYER, _YEAR, 'ON479', 19, P).

rawline(TAXPAYER, _YEAR, 'ON479', 20, POLTAX):-
  taxfact(TAXPAYER, _YEAR, 'Ontario Political Credits', POLTAX).

rawline(TAXPAYER, _YEAR, 'ON479', 21, OHOSPINCOME) :-
  taxfact(TAXPAYER, _YEAR, 'Spouse', _SPOUSE),
  line(TAXPAYER, _YEAR, 'ON479', 3, INC),
  OHOSPINCOME = INC / 2,
  line(TAXPAYER, _YEAR, 'ON428', 5816, V),
  V > 0,
  line(TAXPAYER, _YEAR, 'ON479', 3, INC),
  OHOSPINCOME = INC / 2,
  line(TAXPAYER, _YEAR, 'ON479', 3, OHOSPINCOME).

rawline(TAXPAYER, _YEAR, 'ON479', 6315, V) :-  
 line(TAXPAYER, _YEAR, 'ON479', 21, V).

rawline(TAXPAYER, _YEAR, 'ON479', 22, V) :-
  taxfact(TAXPAYER, _YEAR, 'OHOSP Contributions', VALUE),
  V is min(2000, VALUE).

rawline(TAXPAYER, _YEAR, 'ON479', 6236, V) :-  
 line(TAXPAYER, _YEAR, 'ON479', 22, V).

rawline(TAXPAYER, _YEAR, 'ON479', 23, V) :-
  taxfact(TAXPAYER, _YEAR, 'OHOSP Spousal Contributions', VALUE),
  V is min(2000, VALUE).

rawline(TAXPAYER, _YEAR, 'ON479', 6237, V) :-  
 line(TAXPAYER, _YEAR, 'ON479', 23, V).

rawline(TAXPAYER, _YEAR, 'ON479', 24, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [22,23], TTL).

rawline(TAXPAYER, _YEAR, 'ON479', 25, RATE) :-
  taxfact(TAXPAYER, _YEAR, 'OHOSP Tax Credit Factor', RATE).

rawline(TAXPAYER, _YEAR, 'ON479', 26, OHOSP_CREDIT) :-
  line(TAXPAYER, _YEAR, 'ON479', 24, TTL),
  line(TAXPAYER, _YEAR, 'ON479', 25, RATE),
  OHOSP_CREDIT is (TTL * RATE / 100).

rawline(TAXPAYER, _YEAR, 'ON479', 27, FLOWTHRU) :-
  line(TAXPAYER, _YEAR, 'T1221', 'total', EXPENSES),
  FLOWTHRU is (EXPENSES / 20).

rawline(TAXPAYER, _YEAR, 'ON479', 28, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [18, 20, 26, 27], TTL).

rawline(TAXPAYER, _YEAR, 'ON479', 35, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'ON479', [28, 29, 30, 31, 32, 33, 34], TTL).

formatting(_YEAR, 
	'ON479', 
                    [dl(1, "Net Income"),
	             dl(2, "Spousal Income"),
		     tl(3, "Income for Ontario Credits"),
		     dl(4, "Rent x 20%"),
		     dl(5, "Property Taxes"),
		     dl(6, "Student residence claim"),
		     tl(7, "Claims"),
		     dl(8, "Lesser of claim and base"),
		     dl(9, "10% of Claims"),
		     tl(10, "Property tax credit"),
		     dl(11, "Basic sales tax credit"),
		     dl(12, "Spousal credit"),
		     dl(13, "Dependent credits"),
		     tl(14, "Total Sales tax credit"),
		     tl(15, "Credits"),
		     dl(16, "Factored Income"),
		     dl(17, "Net Credit"),
		     tl(18, "Admissible Credit (max $1000)"),
		     dl(19, "Ontario political contributions"),
		     tl(20, "Political contribution credit"),
		     dl(21, "OHOSP Income"),
		     dl(22, "OHOSP Contributions"),
		     dl(23, "Spousal OHOSP Contributions"),
		     tl(24, "Total Contributions"),
		     dl(25, "OHOSP Credit Factor"),
		     tl(26, "Resulting OHOSP Credit"),
		     dl(27, "T1221 Flowthrough share tax credit"),
		     tl(28, "Total Credits"),
		     dl(29, "Ontario co-operative education tax credit"),
		     dl(30, "Ontario graduate transitions tax credit"),
		     dl(31, "Ontario workplace child care tax credit"),
		     dl(32, "Ontario workplace accessibility tax credit"),
		     dl(33, "Ontario educational technology tax credit"),
		     dl(34, "Ontario school bus safety tax credit"),
		     tl(35, "Ontario Credits")]).
