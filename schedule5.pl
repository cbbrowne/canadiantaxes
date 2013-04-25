%% -*- Prolog -*-
% $Id: schedule5.pl,v 1.3 2005/03/23 14:43:54 cbrowne Exp $
% Schedule 5

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

eligible_dependent(DEPENDENT, YEAR) :-
   taxfact(DEPENDENT, YEAR, 'Age', AGE),
   AGE < 18;
   taxfact(DEPENDENT, YEAR, 'Disability', 'Yes'),
   taxfact(DEPENDENT, YEAR, 'Age', AGE),
   AGE >= 18.

amt_for_dependent(DEPENDENT, _YEAR, AMOUNT) :-
   eligible_dependent(DEPENDENT, _YEAR),
   line(DEPENDENT, _YEAR, 'Annual Rates', 'Federal Dependent Base', BASE),
   line(DEPENDENT, _YEAR, 'T1', 236, NET_INCOME),
   AMOUNT is max(0, BASE - NET_INCOME).

dependents_sum([], _YEAR, AMT, AMT).

dependents_sum([A|B], _YEAR, AMT1, TOTAL) :-
   amt_for_dependent(A, _YEAR, AMTA),
   AMT2 = AMT1 + AMTA,
   dependents_sum(B, _YEAR, AMT2, TOTAL).

rawline(TAXPAYER, _YEAR, 'Schedule 5', 305, TOTALDEPENDENT_AMOUNTS) :-
  taxfact(TAXPAYER, _YEAR, 'Dependents', DEPENDENTS),
  dependents_sum(DEPENDENTS, 0, TOTALDEPENDENT_AMOUNTS).

amt_for_infirm_adult_dependent(DEPENDENT, _YEAR, AMOUNT) :-
   taxfact(DEPENDENT, _YEAR, 'Disability', 'Yes'),
   taxfact(DEPENDENT, _YEAR, 'Age', AGE),
   AGE > 18,   
   line(_TAXPAYER, _YEAR, 'Annual Rates', 'Federal Infirm Dependent Base', BASE),
   line(DEPENDENT, _YEAR, 'T1', 236, NET_INCOME),
   line(DEPENDENT, _YEAR, 'Annual Rates', 'Federal Infirm Dependent Max Income', MINAMT),
   LINE3 is min(MINAMT, BASE - NET_INCOME),
   amt_for_dependent(DEPENDENT, LINE4),
   AMOUNT is max(0, LINE3 - LINE4).

infirm_dependents_sum([], _YEAR, AMT, AMT).

infirm_dependents_sum([A|B], _YEAR, AMT1, TOTAL) :-
   amt_for_infirm_adult_dependent(A, _YEAR, AMTA),
   AMT2 = AMT1 + AMTA,
   infirm_dependents_sum(B, _YEAR, AMT2, TOTAL).

rawline(TAXPAYER, _YEAR, 'Schedule 5', 306, TOTALINFIRM) :-
  taxfact(TAXPAYER, _YEAR, 'Infirm Dependents', DEPENDENTS),
  infirm_dependents_sum(DEPENDENTS, _YEAR, 0, TOTALINFIRM).

