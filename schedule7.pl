%% -*- Prolog -*-
% $Id: schedule7.pl,v 1.6 2005/04/04 13:32:42 cbrowne Exp $
% Schedule 7

% 2003/2004 Rules Prepared by
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
% Schedule 7
formatting(_YEAR, 'Schedule 7', 
	[dl(1, "Unused contributions from previous years"),
	 dl(2, "Contributions - past year"),
	 dl(3, "Contributions - first 60 days"),
	 tl(4, "Current tax year Contributions"),
	 tl(5, "Total RRSP Contributions"),
	 dl(6, "Repayments under HBP"),
	 dl(7, "Repayments under LLP"),
	 tl(8, "Total Repayments"),
	 dl(9, "RRSP Contributions available to deduct"),
	 dl(10, "RRSP Contribution Deduction for year"),
	 dl(11, "Transfers"),
	 tl(12, "Sum"),
	 tl(13, "RRSP Deduction for year"),
	 dl(14, "Carryforward to future year"),
	 dl(15, "HBP Withdrawal"),
	 dl(17, "LLP Withdrawal")]).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 1, UNUSED_CONTRIB):-
   LASTYEAR is _YEAR - 1,
   taxfact(TAXPAYER, LASTYEAR, 'RRSP Unused', UNUSED_CONTRIB).
   
rawline(TAXPAYER, _YEAR, 'Schedule 7', 2, LAST_YEAR) :-
   taxfact(TAXPAYER, _YEAR, 'RRSP Contributions - Rest of Year', LAST_YEAR).

rawline(TAXPAYER, YEAR, 'Schedule 7', 3, FIRST_60_DAYS) :-
   NEXT_YEAR is YEAR + 1,
   taxfact(TAXPAYER, NEXT_YEAR, 'RRSP Contributions 1st 60 Days', FIRST_60_DAYS).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 4, CONTRIB):-
   sumoflines(TAXPAYER, _YEAR, 'Schedule 7', [2,3], CONTRIB).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 5, CONTRIB):-
   sumoflines(TAXPAYER, _YEAR, 'Schedule 7', [1,4], CONTRIB).
   
rawline(TAXPAYER, _YEAR, 'Schedule 7', 8, REPAYMENTS) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 7', [6,7], REPAYMENTS).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 9, AVAILABLE_DEDN) :-
  line(TAXPAYER, _YEAR, 'Schedule 7', 5, DED),
  line(TAXPAYER, _YEAR, 'Schedule 7', 8, REPAY),
  AVAILABLE_DEDN is DED - REPAY.

rawline(TAXPAYER, _YEAR, 'Schedule 7', 10, MAXCONTRIB) :-
  taxfact(TAXPAYER, _YEAR, 'RRSP Deduction Limit', DLIMIT),
  line(TAXPAYER, _YEAR, 'Schedule 7', 9, CONTRIBS),
  MAXCONTRIB is min(DLIMIT, CONTRIBS).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 12, TOTAL) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 7', [10, 11], TOTAL).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 13, DEDN) :-
  line(TAXPAYER, _YEAR, 'Schedule 7', 9, A),
  line(TAXPAYER, _YEAR, 'Schedule 7', 12, B),
  DEDN is min(A,B).

rawline(TAXPAYER, _YEAR, 'Schedule 7', 14, UNUSED) :-
  line(TAXPAYER, _YEAR, 'Schedule 7', 9, AVAILABLE),
  line(TAXPAYER, _YEAR, 'Schedule 7', 13, USED),
  UNUSED is AVAILABLE - USED.

