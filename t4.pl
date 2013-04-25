%% -*- Prolog -*-
% $Id: t4.pl,v 1.2 2005/03/21 04:20:57 cbrowne Exp $

% T4 Inferences
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

mline(TAXPAYER, _YEAR, 'T4', VER, 14, INCOME) :-
  t4(TAXPAYER, _YEAR, VER, _Z,INCOME, _A,_B,_C,_D,_E,_F,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 16, CPP) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,CPP,_B,_C,_D,_E,_F,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 17, QPP) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,QPP,_C,_D,_E,_F,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 18, EIC) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,EIC,_D,_E,_F,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 20, RPP) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,RPP,_E,_F,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 52, PA) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,PA,_F,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 22, ITD) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,_F,ITD,_G,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 24, EIE) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,_F,_G,EIE,_H,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 26, CPPE) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,_F,_G,_H,CPPE,_I,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 44, UNION) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,_F,_G,_H,_I,UNION,_J,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 46, CHAR) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,_F,_G,_H,_I,_J,CHAR,_K).
mline(TAXPAYER, _YEAR, 'T4', VER, 50, DPSP) :-
  t4(TAXPAYER, _YEAR, VER, _Z,_A,_B,_C,_D,_E,_F,_G,_H,_I,_J,_K,DPSP).

rawline(TAXPAYER, _YEAR, 'T4', LINE, AMT) :-
  recurse_across_multi_forms(TAXPAYER, _YEAR, 'T4', [1,2,3,4,5,6,7,8,9,10], LINE, 0, AMT).
