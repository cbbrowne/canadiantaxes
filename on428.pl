%% -*- Prolog -*-
% $Id: on428.pl,v 1.7 2005/04/04 13:32:42 cbrowne Exp $
% Inferences for Ontario ON428

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

rawline(TAXPAYER, _YEAR, 'ON428', 1, INC):-
  line(TAXPAYER, _YEAR, 'T1', 260, INC).

rawline(TAXPAYER, _YEAR, 'ON428', 2, INC) :-
  line(TAXPAYER, _YEAR, 'ON428', 1, INC).

rawline(TAXPAYER, _YEAR, 'ON428', 3, SUB) :-
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion', M1),
  INC < M1,
  SUB is 0;
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion', M1),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion', M2),
  I is integer(INC),
  between(M1, M2, I),
  SUB is M1;
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion', M2),
  INC > M2,
  SUB is M2.

rawline(TAXPAYER, _YEAR, 'ON428', 4, PORTION_AT_MARGINAL_RATE):-
  difflines_min_zero(TAXPAYER, _YEAR, 'ON428', 2, 3, PORTION_AT_MARGINAL_RATE).

rawline(TAXPAYER, _YEAR, 'ON428', 5, SUB) :-
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion', M1),
  INC < M1,
  SUB is 605;
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion', M1),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion', M2),
  I is integer(INC),
  between(M1, M2, I),
  SUB is 915;
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion', M2),
  INC > M2,
  SUB is 1116.

rawline(TAXPAYER, _YEAR, 'ON428', 6, AMTATRATE) :-
  line(TAXPAYER, _YEAR, 'ON428', 5, RATE),
  line(TAXPAYER, _YEAR, 'ON428', 4, INCOME),
  AMTATRATE is (RATE * INCOME / 10000).

rawline(TAXPAYER, _YEAR, 'ON428', 7, SUB):-
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion', I1),
  INC < I1,
  SUB is 0;
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion', M1),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion', M2),
  I is integer(INC),
  between(M1, M2, I),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Lower Marginal Portion Tax', SUB);
  line(TAXPAYER, _YEAR, 'ON428', 1, INC),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion', M2),
  INC > M2,
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Higher Marginal Portion Tax', SUB).

rawline(TAXPAYER, _YEAR, 'ON428', 8, OTAX):-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [6,7], OTAX).

rawline(TAXPAYER, _YEAR, 'ON428', 9, AMT) :-
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Personal Credit', AMT).

rawline(TAXPAYER, _YEAR, 'ON428', 5804, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 9, V).

rawline(TAXPAYER, _YEAR, 'ON428', 10, AGEAMT) :-
  taxfact(TAXPAYER, _YEAR, 'Ontario Age Amount', AGEAMT).

rawline(TAXPAYER, _YEAR, 'ON428', 5808, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 10, V).

rawline(TAXPAYER, _YEAR, 'ON428', 11, SPOUSAL_CREDIT) :-
   taxfact(TAXPAYER, _YEAR, 'Spouse', SPOUSE_SIN),
   line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Spousal Credit', SPOUSAL_CREDIT),
   line(SPOUSE_SIN, 'T1', 150, SPOUSAL_INCOME),
   SPOUSAL_CREDIT is max(0, SPOUSAL_CREDIT - SPOUSAL_INCOME).

rawline(TAXPAYER, _YEAR, 'ON428', 5812, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 11, V).

rawline(TAXPAYER, _YEAR, 'ON428', 12, DEPEND) :-
   taxfact(TAXPAYER, _YEAR, 'Ontario Dependent', DEPEND).

rawline(TAXPAYER, _YEAR, 'ON428', 5816, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 12, V).

rawline(TAXPAYER, _YEAR, 'ON428', 5820, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 12, V).

rawline(TAXPAYER, _YEAR, 'ON428', 14, CPP) :- 
  line(TAXPAYER, _YEAR, 'Schedule 1', 308, CPP).

rawline(TAXPAYER, _YEAR, 'ON428', 5824, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 14, V).

rawline(TAXPAYER, _YEAR, 'ON428', 15, QPP) :- 
  line(TAXPAYER, _YEAR, 'Schedule 1', 310, QPP).

rawline(TAXPAYER, _YEAR, 'ON428', 16, EIC) :- 
  line(TAXPAYER, _YEAR, 'Schedule 1', 312, EIC).

rawline(TAXPAYER, _YEAR, 'ON428', 21, INTEREST) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 319, INTEREST).

rawline(TAXPAYER, _YEAR, 'ON428', 26, MEDDEDUCT) :-
  line(TAXPAYER, _YEAR, 'T1', 236, INCOME),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Maximum Medical Amount', AMT),
  MEDDEDUCT is min(AMT, INCOME * 3/100).

rawline(TAXPAYER, _YEAR, 'ON428', 27, CREDIT) :-
  line(TAXPAYER, _YEAR, 'ON428', 25, EXP),
  line(TAXPAYER, _YEAR, 'ON428', 26, DED),
  CREDIT is max(0, EXP - DED).

rawline(TAXPAYER, _YEAR, 'ON428', 29, CREDIT) :-
  line(TAXPAYER, _YEAR, 'ON428', 27, EXP),
  line(TAXPAYER, _YEAR, 'ON428', 28, DED),
  CREDIT is max(0, EXP - DED).

rawline(TAXPAYER, _YEAR, 'ON428', 30, CREDITS) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,29], CREDITS).

rawline(_TAXPAYER, _YEAR, 'ON428', 31, CREDITRATE) :-
  CREDITRATE is 605.

rawline(TAXPAYER, _YEAR, 'ON428', 32, CREDIT) :-
  line(TAXPAYER, _YEAR, 'ON428', 30, CREDITS),
  line(TAXPAYER, _YEAR, 'ON428', 31, RATE),
  CREDIT is (CREDITS * RATE / 10000).

rawline(TAXPAYER, _YEAR, 'ON428', 33, DON1) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 345, AMT),
  line(TAXPAYER, _YEAR, 'ON428', 31, RATE),
  DON1 is (AMT * RATE / 10000).

rawline(TAXPAYER, _YEAR, 'ON428', 34, DON2) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 347, AMT),
  DON2 is (AMT * 1116 / 10000).
  
rawline(TAXPAYER, _YEAR, 'ON428', 35, DONCREDIT) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [33, 34], DONCREDIT).

rawline(TAXPAYER, _YEAR, 'ON428', 36, CREDIT) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [32, 35], CREDIT).

rawline(TAXPAYER, _YEAR, 'ON428', 37, TAX) :-
  line(TAXPAYER, _YEAR, 'ON428', 8, TAX).

rawline(TAXPAYER, _YEAR, 'ON428', 38, TAX) :-
  line(TAXPAYER, _YEAR, 'T1206', 'total', TAX).

rawline(TAXPAYER, _YEAR, 'ON428', 39, TTAX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [37, 38], TTAX).

rawline(TAXPAYER, _YEAR, 'ON428', 40, CREDITS) :-
  line(TAXPAYER, _YEAR, 'ON428', 36, CREDITS).

rawline(TAXPAYER, _YEAR, 'ON428', 41, DTC) :-
  line(TAXPAYER, _YEAR, 'T1', 120, DIVS),
  DTC is (DIVS * 513 / 10000).

rawline(TAXPAYER, _YEAR, 'ON428', 42, OETC) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 426, TAX),
  OETC is (TAX * 385 / 1000).

rawline(TAXPAYER, _YEAR, 'ON428', 43, AMT) :-
  line(TAXPAYER, _YEAR, 'T1219-ON', 'total', AMT).

rawline(TAXPAYER, _YEAR, 'ON428', 44, AMT) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [40, 41, 42, 43], AMT).

rawline(TAXPAYER, _YEAR, 'ON428', 45, TX) :-
  line(TAXPAYER, _YEAR, 'ON428', 39, TAX),
  line(TAXPAYER, _YEAR, 'ON428', 44, CR),
  TX is max(0, TAX - CR).

rawline(TAXPAYER, _YEAR, 'ON428', 46, TX) :-
  line(TAXPAYER, _YEAR, 'T691', 95, V),
  TX is (V * 3781 / 10000).

rawline(TAXPAYER, _YEAR, 'ON428', 47, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [45, 46], TX).

rawline(TAXPAYER, _YEAR, 'ON428', 48, SURTAX) :-
  line(TAXPAYER, _YEAR, 'ON428', 47, TAX),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Surtax - First Chunk', PORTION),
  SURTAX is max(0, (TAX - PORTION) /5).

rawline(TAXPAYER, _YEAR, 'ON428', 49, SURTAX) :-
  line(TAXPAYER, _YEAR, 'ON428', 47, TAX),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Ontario Surtax - Second Chunk', PORTION),
  SURTAX is max(0, ((TAX - PORTION) * 36) / 100).

rawline(TAXPAYER, _YEAR, 'ON428', 50, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [48, 49], TX).

rawline(TAXPAYER, _YEAR, 'ON428', 51, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [47, 50], TX).

rawline(TAXPAYER, _YEAR, 'ON428', 52, TX) :-
  line(TAXPAYER, _YEAR, 'T2036', 'ontario', TX).

rawline(TAXPAYER, _YEAR, 'ON428', 53, TX) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'ON428', 51, 52, TX).

rawline(TAXPAYER, _YEAR, 'ON428', 57, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [54,55,56], TX).

rawline(TAXPAYER, _YEAR, 'ON428', 58, RED) :-
  line(TAXPAYER, _YEAR, 'ON428', 57, TX),
  RED is (TX * 2).

rawline(TAXPAYER, _YEAR, 'ON428', 59, TX) :-
  line(TAXPAYER, _YEAR, 'ON428', 53, TX).

rawline(TAXPAYER, _YEAR, 'ON428', 60, REDAMT) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'ON428', 58, 59, REDAMT).

rawline(TAXPAYER, _YEAR, 'ON428', 61, AFTERRED) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'ON428', 53, 60, AFTERRED).

rawline(TAXPAYER, _YEAR, 'ON428', 62, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'LSIF', [2, 4], LSIF),
  TX is min(750, (LSIF * 15) / 200).
	
rawline(TAXPAYER, _YEAR, 'ON428', 63, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'LSIF', [3, 5], ROIF),
  TX is min(250, ROIF / 20).

rawline(TAXPAYER, _YEAR, 'ON428', 64, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'LSIF', [9, 11], EO),
  TX is min(4150, EO).

rawline(TAXPAYER, _YEAR, 'ON428', 66, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [64, 65], TX).

rawline(TAXPAYER, _YEAR, 'ON428', 67, TX) :-
  sumoflines(TAXPAYER, _YEAR, 'ON428', [62, 63, 66], TX).

rawline(TAXPAYER, _YEAR, 'ON428', 68, TX) :-
  line(TAXPAYER, _YEAR, 'ON428', 61, T1),
  line(TAXPAYER, _YEAR, 'ON428', 67, T2),
  TX is T1 - T2.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   TAXABLE_INCOME < 0,
   HEALTH_TAX is 0.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   TAXABLE_INCOME < 0,
   HEALTH_TAX is 0.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(20000, 25000, I),
   OHP is (TAXABLE_INCOME - 20000) * 0.06,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.


rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(25000, 36000, I),
   OHP is 300,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(38500, 48000, I),
   OHP is 450,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(48600, 72000, I),
   OHP is 600,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(72600, 200000, I),
   OHP is 750,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   TAXABLE_INCOME > 200600,
   OHP is 900,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(20000, 25000, I),
   OHP is (TAXABLE_INCOME - 20000) * 0.06,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(36000, 38500, I),
   OHP is (TAXABLE_INCOME - 36000) * 0.06 + 300,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(48000, 48600, I),
   OHP is (TAXABLE_INCOME - 48000) * 0.25 + 450,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(72000, 72600, I),
   OHP is (TAXABLE_INCOME - 72000) * 0.25 + 600,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 69, HEALTH_TAX) :-
   YEAR > 2003,   % Only applies to 2004 and later
   line(TAXPAYER, YEAR, 'T1', 260, TAXABLE_INCOME),
   I is integer(TAXABLE_INCOME),
   between(200000, 200600, I),
   OHP is (TAXABLE_INCOME - 200000) * 0.25 + 750,
   line(TAXPAYER, YEAR, 'Annual Rates', 'Share of Ontario Health Premium',  RATE),
   HEALTH_TAX is OHP * RATE.

rawline(TAXPAYER, YEAR, 'ON428', 70, TOTAL_TAX) :-
   sumoflines(TAXPAYER, YEAR, 'ON428', [68, 69], TOTAL_TAX).

rawline(TAXPAYER, _YEAR, 'ON428', 5828, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 15, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5832, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 16, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5836, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 17, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5840, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 18, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5844, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 19, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5848, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 20, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5852, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 21, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5856, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 22, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5860, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 23, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5864, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 24, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5868, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 25, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5872, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 28, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5876, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 29, V).
rawline(TAXPAYER, _YEAR, 'ON428', 5880, V) :-
  line(TAXPAYER, _YEAR, 'ON428', 30, V).

formatting(_YEAR, 'ON428',
       [d1(1, "Taxable Income"), 
	dl(2, "Income"), 
	dl(3, "Margin Level"),
	dl(4, "Portion at top rate"),
	dl(5, "Top tax rate"), 
	dl(6, "Taxes at top rate"), 
	dl(7, "Base tax"), 
	dl(8, "Ontario Tax on taxable income"),
	dl(9, "Basic Personal Amount"),
	dl(10, "Age Amount"),
	dl(11, "Spousal Amount"),
	dl(12, "Dependent Amount"),
	dl(13, "Amount for infirm dependents"),
	dl(14, "CPP"),
	dl(15, "QPP"),
	dl(16, "EIC"),
	dl(17, "Pension income"),
	dl(18, "Caregiver amount"),
	dl(19, "Disability amount"),
	dl(20, "Disability amount from dependent"),
	dl(21, "Interest on student loans"),
	dl(22, "Tuition/Education Amounts"),
	dl(23, "Tuition/Education Amounts from Children"),
	dl(24, "Amounts transfered from spouse"),
	dl(25, "Medical Expenses"),
	dl(26, "Allowable portion"),
	dl(27, "Creditable Med Expenses"),
	dl(28, "Med exp adjustment"),
	tl(29, "Net Med Expenses"),
	tl(30, "Total Credits"),
	dl(31, "Tax Credit Rate"),
	dl(32, "Credit"),
	dl(33, "Donation Credit 1"),
	dl(34, "Donation Credit 2"),
	tl(35, "Donation Credit"),
	tl(36, "Nonrefundable tax credits"),
	dl(37, "Ontario Tax"),
	dl(38, "Tax on Split Income"),
	tl(39, "Ont Taxes"),
	dl(40, "Nonrefundable credits"),
	dl(41, "Ontario dividend tax credit"),
	dl(42, "Ontario overseas employment tax credit"),
	dl(43, "Ontario minimum tax carryover"),
	tl(44, "Additional credits"),
	dl(45, "Net tax"),
	dl(46, "Ontario AMT"),
	tl(47, "Taxes with AMT"),
	dl(48, "Ontario Surtax 1"),
	dl(49, "Ontario Surtax 2"),
	tl(50, "Total surtax"),
	tl(51, "Total"),
	tl(52, "Ontario FTC - T2036"),
	dl(53, "Net Tax"),
	dl(55, "Dependent children reduction"),
	dl(56, "Disabled dependents reduction"),
	tl(57, "Dependent Amounts"),
	dl(58, "Doubled Reduction"),
	dl(59, "Net Tax"),
	dl(60, "Ontario tax reduction"),
	t1(61, "Reduced Taxes"),
	dl(62, "LSIF Credits"),
	dl(63, "ROIF Credits"),
	dl(64, "Current EO Credits"),
	dl(65, "Unused past EO credits"),
	tl(66, "EO Credits"),
	tl(67, "LSIF/EO tax credits"),
        tl(68, "Subtotal of Ontario Taxes"),
	dl(69, "Ontario Health Premium"),
        tl(70, "Ontario Taxes")
    ]).
