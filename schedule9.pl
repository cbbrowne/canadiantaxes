%% -*- Prolog -*-
% $Id: schedule9.pl,v 1.4 2005/04/04 13:32:42 cbrowne Exp $
% Schedule 9

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
% Schedule 9
rawline(TAXPAYER, _YEAR, 'Schedule 9', 1, DONATIONS) :-
  taxfact(TAXPAYER, _YEAR, 'Charitable Donations', DONATIONS).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 2, NET_INCOME_TIMES_75_PERCENT) :-
  line(TAXPAYER, _YEAR, 'T1', 236, NET_INCOME),
  NET_INCOME_TIMES_75_PERCENT is (NET_INCOME * 3)/ 4.

rawline(TAXPAYER, _YEAR, 'Schedule 9', 337, GIFT_DEP) :- 
  line(TAXPAYER, _YEAR, 'Schedule 9', 3, GIFT_DEP).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 339, GIFT_CAP) :- 
  line(TAXPAYER, _YEAR, 'Schedule 9', 4, GIFT_CAP).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 5, GIFT_LIMIT) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 9', [337, 339], LIMIT_BASE),
  GIFT_LIMIT is (LIMIT_BASE / 4).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 6, DONATION_LIMIT) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 9', [2, 5], DAMT),
  sumoflines(TAXPAYER, _YEAR, 'T1', [236], INCOME),
  DONATION_LIMIT is min(DAMT, INCOME).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 340, ALLOWABLE_DONATIONS) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 1, DONATIONS),
  line(TAXPAYER, _YEAR, 'Schedule 9', 6, DONATION_LIMIT),
  ALLOWABLE_DONATIONS is min(DONATIONS, DONATION_LIMIT).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 344, ALL_GIFTS) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 9', [340, 342], ALL_GIFTS).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 345, BASE_FOR_CREDIT) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 344, DONATIONS),
  BASE_FOR_CREDIT is min(DONATIONS, 200).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 7, LOWRATE_CREDIT) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 345, LOWRATE_PORTION),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Base Tax Rate', BASERATE),
  LOWRATE_CREDIT is (LOWRATE_PORTION  * BASERATE)/100.

rawline(TAXPAYER, _YEAR, 'Schedule 9', 346, LOWRATE_CREDIT) :- 
  line(TAXPAYER, _YEAR, 'Schedule 9', 7, LOWRATE_CREDIT).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 347, REMAINING) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 344, DONATIONS),
  line(TAXPAYER, _YEAR, 'Schedule 9', 345, BASE),
  REMAINING is DONATIONS - BASE.

rawline(TAXPAYER, _YEAR, 'Schedule 9', 8, HIRATE_CREDIT) :- 
  line(TAXPAYER, _YEAR, 'Schedule 9', 347, REMAINING),
  line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Top Tax Rate', HIRATE),
  HIRATE_CREDIT is (REMAINING * HIRATE) / 100.

rawline(TAXPAYER, _YEAR, 'Schedule 9', 348, HIRATE_CREDIT) :- 
  line(TAXPAYER, _YEAR, 'Schedule 9', 8, HIRATE_CREDIT).

rawline(TAXPAYER, _YEAR, 'Schedule 9', 9, DONATION_CREDIT) :-
  line(TAXPAYER, _YEAR, 'Schedule 9', 7, LORATE_CREDIT),
  line(TAXPAYER, _YEAR, 'Schedule 9', 8, HIRATE_CREDIT),
  DONATION_CREDIT is LORATE_CREDIT + HIRATE_CREDIT.

formatting(_YEAR, 'Schedule 9',
	   [dl(1, "Total donations"), dl(2, "75% of Income"), dl(3,"Gifts of depreciable property"), 
	    dl(4,"Gifts of capital property"), tl(5,"25% of Gifts"), dl(6,"Total Donation Limit"), 
	    dl(340,"Allowable donations/gifts"), dl(342,"Cultural/Ecological Gifts"),
	    tl(344,"Total Gifts"), dl(345, "Amount up to $200"), dl(346, "Credit at bottom rate%"),
	    dl(347, "Amount Over $200"), dl(348, "Credit at top rate%"),
	    tl(9, "Donation Credit")
	    ]).
