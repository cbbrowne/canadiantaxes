%% -*- Prolog -*-
% $Id: t691.pl,v 1.9 2005/03/21 04:20:57 cbrowne Exp $
% Inferences for T91

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

rawline(TAXPAYER, _YEAR, 'T691', 1, TXINC) :-
   line(TAXPAYER, _YEAR, 'T1', 234, NETINCOME),
   sumoflines(TAXPAYER, _YEAR, 'T1', [235, 257], DEDUCTIONS),
   TXINC is NETINCOME - DEDUCTIONS.

rawline(TAXPAYER, _YEAR, 'T691', 4, NETFILM) :-
   difflines_min_zero(TAXPAYER, _YEAR, 'T691', 2, 3, NETFILM).

rawline(TAXPAYER, _YEAR, 'T691', 7, NETRENT) :-
   difflines_min_zero(TAXPAYER, _YEAR, 'T691', 5, 6, NETRENT).

rawline(TAXPAYER, _YEAR, 'T691', 11, SHELTER) :-
   sumoflines(TAXPAYER, _YEAR, 'T691', [8,9,10], SHELTER).

rawline(TAXPAYER, _YEAR, 'T691', 15, RESINC) :-
   sumoflines(TAXPAYER, _YEAR, 'T691', [13, 14], RESINC).

rawline(TAXPAYER, _YEAR, 'T691', 16, RESINC) :-
   difflines_min_zero(TAXPAYER, _YEAR, 'T691', 12, 15, RESINC).

rawline(TAXPAYER, _YEAR, 'T691', 17, CAPGAIN) :-
   line(TAXPAYER, _YEAR, 'Schedule 3', 197, CAPGAIN).

rawline(TAXPAYER, _YEAR, 'T691', 23, CGAINS) :-
   sumoflines(TAXPAYER, _YEAR, 'T691', [18,19,20,21,22], CGAINS).

rawline(TAXPAYER, _YEAR, 'T691', 24, CGAINS) :-
   line(TAXPAYER, _YEAR, 'T691', 17, CAPGAIN),
   line(TAXPAYER, _YEAR, 'T691', 23, DEDNS),
   CGAINS is CAPGAIN - DEDNS.

rawline(TAXPAYER, _YEAR, 'T691', 'a', LIMIT1) :-
   line(TAXPAYER, _YEAR, 'T691', 24, CGAINS),
   LIMIT1 is abs(CGAINS * 3 / 10).

rawline(TAXPAYER, _YEAR, 'T691', 'b', LIMIT2) :-
   line(TAXPAYER, _YEAR, 'T1', 127, LIMIT2).

rawline(TAXPAYER, _YEAR, 'T691', 25, ADDBACK) :-
   line(TAXPAYER, _YEAR, 'T691', 24, CGAINS),
   CGAINS > 0,
   line(TAXPAYER, _YEAR, 'T691', 25, ADDBACK);
   line(TAXPAYER, _YEAR, 'T691', 'a', LIMITA),
   line(TAXPAYER, _YEAR, 'T691', 'b', LIMITB),
   ADDBACK is min(LIMITA, LIMITB).

rawline(TAXPAYER, _YEAR, 'T691', 26, INCTOTAL) :-
   sumoflines(TAXPAYER, _YEAR, 'T691', [1,4,7,11,16,25], INCTOTAL).

rawline(TAXPAYER, _YEAR, 'T691', 27, INCTOTAL) :-
  line(TAXPAYER, _YEAR, 'T691', 26, INCTOTAL).

rawline(TAXPAYER, _YEAR, 'T691', 28, RELODEDN) :-
  line(TAXPAYER, _YEAR, 'T1', 248, RELODEDN).

rawline(TAXPAYER, _YEAR, 'T691', 29, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'T4', [39], BOX39),
  sumoflines(TAXPAYER, _YEAR, 'T1212', [4], LINE4),
  TTL is BOX39 + LINE4 / 2.

rawline(TAXPAYER, _YEAR, 'T691', 30, VALUE) :-
  taxfact(TAXPAYER, _YEAR, 'Gifts of Securities', X),
  VALUE is X + X.

rawline(TAXPAYER, _YEAR, 'T691', 31, V) :-
  line(TAXPAYER, _YEAR, 'T691', 29, V).

rawline(TAXPAYER, _YEAR, 'T691', 32, V) :-
  line(TAXPAYER, _YEAR, 'T691', 30, V).

rawline(TAXPAYER, _YEAR, 'T691', 33, V) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 31, 32, V).

rawline(TAXPAYER, _YEAR, 'T691', 34, FORTYPERCENT) :-
    line(TAXPAYER, _YEAR, 'T691', 33, V),
    FORTYPERCENT is V * 2/5.

rawline(TAXPAYER, _YEAR, 'T691', 35, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'T691', [30,34], TTL).

rawline(TAXPAYER, _YEAR, 'T691', 36, TTL) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 29, 35, TTL).

rawline(TAXPAYER, _YEAR, 'T691', 37, DEDN) :-
  sumoflines(TAXPAYER, _YEAR, 'T4', [41], DEDN).

rawline(TAXPAYER, _YEAR, 'T691', 38, GRUB) :-
  taxfact(TAXPAYER, _YEAR, 'Deduction for Grub Stake', GRUB).

rawline(TAXPAYER, _YEAR, 'T691', 39, DPSP) :-
  taxfact(TAXPAYER, _YEAR, 'Deduction for Deferred Profit-Sharing', DPSP).

rawline(TAXPAYER, _YEAR, 'T691', 40, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'T691', [37,38,39], TTL).

rawline(TAXPAYER, _YEAR, 'T691', 41, SIXTYP) :-
    line(TAXPAYER, _YEAR, 'T691', 40, V),
    SIXTYP is V * 3/5.

rawline(TAXPAYER, _YEAR, 'T691', 42, MURB) :-
  taxfact(TAXPAYER, _YEAR, 'MURB loss claim of CCA', MURB).
  
rawline(TAXPAYER, _YEAR, 'T691', 43, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'T691', [27,28,36,41,42], TTL).

rawline(TAXPAYER, _YEAR, 'T691', 44, V120) :-
  line(TAXPAYER, _YEAR, 'T1', 120, V),
  V120 is V / 5.

rawline(TAXPAYER, _YEAR, 'T691', 45, V217) :-
  line(TAXPAYER, _YEAR, 'T1', 217, V),
  V217 is V * 3 / 5.

rawline(TAXPAYER, _YEAR, 'T691', 46, L46) :-
  line(TAXPAYER, _YEAR, 'T691', 156, L46).

rawline(TAXPAYER, _YEAR, 'T691', 47, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'T691', [44, 45, 46], TTL).

rawline(TAXPAYER, _YEAR, 'T691', 48, DIFF) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 43, 47, DIFF).

rawline(_TAXPAYER, _YEAR, 'T691', 49, BASIC_EXEMPTION) :-
  BASIC_EXEMPTION is 40000.

rawline(TAXPAYER, _YEAR, 'T691', 50, NATI) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 48, 49, NATI).

rawline(TAXPAYER, _YEAR, 'T691', 51, NATI) :-
  line(TAXPAYER, _YEAR, 'T691', 50, NATI).

rawline(_TAXPAYER, _YEAR, 'T691', 52, 16).  % 16%

rawline(TAXPAYER, _YEAR, 'T691', 53, GMINAMT) :-
  line(TAXPAYER, _YEAR, 'T691', 51, NATI),
  line(TAXPAYER, _YEAR, 'T691', 52, RATE),
  GMINAMT is NATI * RATE / 100.

rawline(TAXPAYER, _YEAR, 'T691', 54, TAX_CREDITS) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 350, TAX_CREDITS).

rawline(TAXPAYER, _YEAR, 'T691', 55, SOMELINES) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [314,318,324,326], SOMELINES).

rawline(_TAXPAYER, _YEAR, 'T691', 56, 16).

rawline(TAXPAYER, _YEAR, 'T691', 57, AMT) :-
  line(TAXPAYER, _YEAR, 'T691', 55, BASE),
  line(TAXPAYER, _YEAR, 'T691', 56, RATE),
  AMT is BASE * RATE / 100.

rawline(TAXPAYER, _YEAR, 'T691', 58, DIFF) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 54, 57, DIFF).

rawline(TAXPAYER, _YEAR, 'T691', 59, MINAMT) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 53, 58, MINAMT).

rawline(TAXPAYER, _YEAR, 'T691', 60, FTAX) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 11, FTAX).

rawline(TAXPAYER, _YEAR, 'T691', 61, CREDITS) :-
  line(TAXPAYER, _YEAR, 'Schedule 1', 350, CREDITS).

rawline(TAXPAYER, _YEAR, 'T691', 62, DIVTAXCREDIT) :-
  line(TAXPAYER, _YEAR, 'T1', 120, DIVIDENDS),
  DIVTAXCREDIT = (DIVIDENDS * 13333333 / 100000000).

rawline(TAXPAYER, _YEAR, 'T691', 63, OSEMPTAXCREDIT) :-
  line(TAXPAYER, _YEAR, 'T626', 'result', OSEMPTAXCREDIT).

rawline(TAXPAYER, _YEAR, 'T691', 64, TOTALCREDITS) :-
  sumoflines(TAXPAYER, _YEAR, 'T691', [61, 62, 63], TOTALCREDITS).

rawline(TAXPAYER, _YEAR, 'T691', 65, TAXPAYABLE) :-
  line(TAXPAYER, _YEAR, 'T691', 60, TAX),
  line(TAXPAYER, _YEAR, 'T691', 64, TOTALCREDITS),
  TAXPAYABLE is TAX - TOTALCREDITS.

rawline(TAXPAYER, _YEAR, 'T691', 66, MINTAXCOAPP) :-
  line(TAXPAYER, _YEAR, 'T691', 124, MINTAXCOAPP).

rawline(TAXPAYER, _YEAR, 'T691', 67, BASICFEDTAX):-
  line(TAXPAYER, _YEAR, 'T691', 65, TAXPAYABLE),
  line(TAXPAYER, _YEAR, 'T691', 66, MINTAXCOAPP),
  BASICFEDTAX is TAXPAYABLE - MINTAXCOAPP.

rawline(TAXPAYER, _YEAR, 'T691', 68, FEDSURTAX):-
  line(TAXPAYER, _YEAR, 'T691', 67, BASICFEDTAX),
  FEDSURTAX is (BASICFEDTAX * 48) / 100.

rawline(TAXPAYER, _YEAR, 'T691', 69, MORETAX):-
  sumoflines(TAXPAYER, _YEAR, 'T691', [67, 68], MORETAX).

rawline(TAXPAYER, _YEAR, 'T691', 70, FEDFORTAXCREDIT):-
  line(TAXPAYER, _YEAR, 'T2209', 10, FEDFORTAXCREDIT).

rawline(TAXPAYER, _YEAR, 'T691', 71, LOGGINGCREDIT):-
  taxfact(TAXPAYER, _YEAR, 'Federal Logging Tax Credit', LOGGINGCREDIT).

rawline(TAXPAYER, _YEAR, 'T691', 72, TOTCREDITS):-
  sumoflines(TAXPAYER, _YEAR, 'T691', [70, 71], TOTCREDITS).

rawline(TAXPAYER, _YEAR, 'T691', 73, NETTAX):-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 69, 72, NETTAX).

rawline(TAXPAYER, _YEAR, 'T691', 74, POLDON):-
  line(TAXPAYER, _YEAR, 'Schedule 1', 410, POLDON).

rawline(TAXPAYER, _YEAR, 'T691', 75, ITC):-
  line(TAXPAYER, _YEAR, 'T2038', 'ITC', ITC).

rawline(TAXPAYER, _YEAR, 'T691', 76, LSIC):-
  line(TAXPAYER, _YEAR, 'Schedule 1', 414, LSIC).

rawline(TAXPAYER, _YEAR, 'T691', 77, CREDITS):-
  sumoflines(TAXPAYER, _YEAR, 'T691', [74,75,76], CREDITS).

rawline(TAXPAYER, _YEAR, 'T691', 78, FEDTAXPAYABLE):-
  difflines_min_zero(TAXPAYER, _YEAR, 'T691', 73, 77, FEDTAXPAYABLE).

%rawline(TAXPAYER, _YEAR, 'T691', 57, AMT) :-


