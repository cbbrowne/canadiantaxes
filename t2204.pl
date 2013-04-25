%% -*- Prolog -*-
% $Id: t2204.pl,v 1.6 2005/04/04 13:32:42 cbrowne Exp $
% Inferences for T2204

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

rawline(TAXPAYER, _YEAR, 'T2204', 1, EARNINGS) :-
   line(TAXPAYER, _YEAR, 'T4', 14, RAW_EARNINGS),
   line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Maximum Pensionable Earnings', MAX_EARNINGS),
   EARNINGS is min(RAW_EARNINGS, MAX_EARNINGS).

rawline(_TAXPAYER, _YEAR, 'T2204', 2, 3500).

rawline(TAXPAYER, _YEAR, 'T2204', 3, SUBJECT_TO_CPP) :-
   line(TAXPAYER, _YEAR, 'T2204', 1, EARNINGS),
   line(TAXPAYER, _YEAR, 'T2204', 2, DEDN),
   line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Maximum Income Subject to CPP', MAX_INCOME),
   RAW = EARNINGS - DEDN,
   SUBJECT_TO_CPP is min(MAX_INCOME, max(0, RAW)).

rawline(TAXPAYER, _YEAR, 'T2204', 4, DEDNS) :-
   sumoflines(TAXPAYER, _YEAR, 'T4', [16,17], DEDNS).

rawline(TAXPAYER, _YEAR, 'T2204', 5, REQD) :-
   line(TAXPAYER, _YEAR, 'T2204', 3, SUBJECT_TO_CPP),
   line(TAXPAYER, _YEAR, 'Annual Rates', 'Federal Maximum CPP', MAX_CPP),
   RAW is SUBJECT_TO_CPP * 495 / 10000,
   REQD is min(RAW, MAX_CPP).

rawline(TAXPAYER, _YEAR, 'T2204', 6, OVERPAID) :-
   line(TAXPAYER, _YEAR, 'T2204', 4, CPP_PAID),
   line(TAXPAYER, _YEAR, 'T2204', 5, REQUIRED),
   OVERPAID is max(0, CPP_PAID - REQUIRED).

