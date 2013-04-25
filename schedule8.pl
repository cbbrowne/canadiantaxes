%% -*- Prolog -*-
% $Id: schedule8.pl,v 1.4 2005/04/04 13:32:42 cbrowne Exp $
% Schedule 8

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

rawline(TAXPAYER, _YEAR, 'Schedule 8', 1, EARNINGS) :-
  sumoflines(TAXPAYER, _YEAR, 'T1', [122, 135, 136, 137, 138, 139, 140, 141, 142, 143], EARNINGS).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 2, EXTRA) :-
  line(TAXPAYER, _YEAR, 'CPT20', 'total', EXTRA).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 373, X) :-
  line(TAXPAYER, _YEAR, 'Schedule 8', 2, X).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 3, EBASE) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 8', [1,2], EBASE).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 4, T4EARNINGS) :-
  sumoflines(TAXPAYER, _YEAR, 'T4', [14, 26], T4EARNINGS).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 5, TPE):-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 8', [3,4], TPE).

rawline(_TAXPAYER, _YEAR, 'Schedule 8', 6, 3500).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 7, ESC):-
  line(TAXPAYER, _YEAR, 'Schedule 8', 5, EARNINGS),
  line(TAXPAYER, _YEAR, 'Schedule 8', 6, DEDUCT),
  ESC is min(36400, max(0, EARNINGS - DEDUCT)).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 8, RT) :-
  line(TAXPAYER, _YEAR, 'Schedule 8', 7, AMT),
  RT is (AMT * 99/1000).

rawline(TAXPAYER, _YEAR, 'Schedule 8', 9, CONT):-
  sumoflines(TAXPAYER, _YEAR, 'T4', [16, 17], ES),
  CONT is ES * 2.

rawline(TAXPAYER, _YEAR, 'Schedule 8', 10, PAYABLE):-
  line(TAXPAYER, _YEAR, 'Schedule 9', 1, SELFEMPEARN),
  SELFEMPEARN > 0,
  line(TAXPAYER, _YEAR, 'Schedule 9', 9, PAID),
  line(TAXPAYER, _YEAR, 'Schedule 9', 8, AMT_DUE),
  PAYABLE is max(0, AMT_DUE - PAID).

formatting(_YEAR, 
           'Schedule 8', [dl(1, "Pensionable self-employment earnings"),
	                  dl(2, "Elected Employment Earnings"),
			  tl(3, "Total Earnings"),
			  dl(4, "T4 CPP Earnings"),
			  tl(5, "Total CPPable Earnings"),
			  dl(6, "Basic Exemption"),
			  dl(7, "Earnings subject to CPP"),
			  dl(8, "Amount Due"),
			  dl(9, "Contributions thru employment"),
			  tl(10, "Contributions payable on self-employment"),
			  dl(11, "Deduction and tax credit for CPP")]).
