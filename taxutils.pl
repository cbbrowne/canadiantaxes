%% -*- Prolog -*-
% $Id: taxutils.pl,v 1.11 2005/04/15 04:44:52 cbrowne Exp $
% Some Tax Return Utilities

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

recurse_across_lines(_TAXPAYER, _YEAR, _, [], AMT, AMT).

recurse_across_lines(TAXPAYER, _YEAR, FORM, [A|B], INAMT, OUTAMT) :-
  line(TAXPAYER, _YEAR, FORM, A, VAL),
  !,
  INPVAL is VAL + INAMT,
  recurse_across_lines(TAXPAYER, _YEAR, FORM, B, INPVAL, OUTAMT) ; 
  % If A has no VAL
  recurse_across_lines(TAXPAYER, _YEAR, FORM, B, INAMT, OUTAMT).

% 
sumoflines(TAXPAYER, _YEAR, FORM, LLIST, AMT) :-
  recurse_across_lines(TAXPAYER, _YEAR, FORM, LLIST, 0, AMT).

sumofforms(TAXPAYER, _YEAR, FORMLIST, LINE, AMT) :-
  recurse_across_multi_forms(TAXPAYER, _YEAR, FORMLIST, LINE, 0, AMT).

recurse_across_multi_forms(_TAXPAYER, _YEAR, _A, [], _B, AMT, AMT).

recurse_across_multi_forms(TAXPAYER, _YEAR, FORM, [A|B], LINE, AMT1, AMT2) :- 
  mline(TAXPAYER, _YEAR, FORM, A, LINE, VAL),
  !,
  INPTEMP is VAL + AMT1,
  recurse_across_multi_forms(TAXPAYER, _YEAR, FORM, B, LINE, INPTEMP, AMT2);
  % if A hasn't a value...
  recurse_across_multi_forms(TAXPAYER, _YEAR, FORM, B, LINE, AMT1, AMT2).

diffminimumzero(AMOUNT, DEDUCTION, RESULT) :-
  AMOUNT >= DEDUCTION,
  !,
  RESULT is AMOUNT - DEDUCTION.

diffminimumzero(AMOUNT, DEDUCTION, RESULT) :- 
  AMOUNT < DEDUCTION,
  !,
  RESULT is 0.

difflines_min_zero(TAXPAYER, _YEAR, FORM, L1, L2, RESULT) :-
  line(TAXPAYER, _YEAR, FORM, L1, V1),
  line(TAXPAYER, _YEAR, FORM, L2, V2),
  V1 > V2,
  !,
  RESULT is V1 - V2;
  line(TAXPAYER, _YEAR, FORM, L1, V1),
  line(TAXPAYER, _YEAR, FORM, L2, V2),
  !,
  RESULT is 0;
  line(TAXPAYER, _YEAR, FORM, L1, RESULT),
  !;
  RESULT is 0.

warning(X) :- 
  X = 1,
  format('------------------------------------------------------------------------------~N', []),
  format('Lurid Disclaimer:  The author of this tax calculation software,~N', []),
  format('Christopher Browne, disclaims that this software has been~N', []),
  format('stringently verified for correctness, and and refuses to verify~N', []),
  format('that it is of any use other than for your education and/or~N', []),
  format('entertainment.  It is CERTAINLY not certified by CCRA.  He~N', []),
  format('declines to offer any form of tax or legal advice, particularly~N', []),
  format('as he has no official standing to do so.  This code may contain~N', []),
  format('live plague bacteria, and cause nausea and vomiting as a result.~N', []),
  format('------------------------------------------------------------------------------~N', []).

tex_form(TAXPAYER, YEAR, FORM) :-
    formatting(YEAR, FORM, LINES),
    taxfact(TAXPAYER, 'Name', NAME),
    format('{\\bf SIN: ~d \\hfil Name: ~a \\hfil Form: ~a}\\\\~N', [TAXPAYER, NAME, FORM]),
    format('\\begin{tabular}{lrr}~N', []),
    format('Description & Amount & Line \\\\ \\hline~N', []),
    render_tex(TAXPAYER, YEAR, FORM, LINES),
    format('\\hline~N', []),
    format('\\end{tabular} \\pagebreak~N', []).

display_form(TAXPAYER, YEAR, FORM) :-
    formatting(YEAR, FORM, LINES),
    taxfact(TAXPAYER, 'Name', NAME),
    format('SIN: ~d Name: ~a Form: ~a~N', [TAXPAYER, NAME, FORM]),
    format('------------------------------------------------------------------------------~N', []),
    render_form(TAXPAYER, YEAR, FORM, LINES),
    format('------------------------------------------------------------------------------~N', []),
    warning(1).

render_tex(_TAXPAYER, _YEAR, _FORM, []).
render_tex(TAXPAYER, YEAR, FORM, [LINE|REST]) :-
    tex_line(TAXPAYER, YEAR, FORM, LINE),
    !,
    render_tex(TAXPAYER, YEAR, FORM, REST);
    render_tex(TAXPAYER, YEAR, FORM, REST).

tex_line(TAXPAYER, YEAR, FORM, LINEDATA):-
  LINEDATA =.. [tl, LINE, DESCR],
%  LINEDATA is tl(LINE, DESCR),
  line(TAXPAYER, YEAR, FORM, LINE, VALUE),
  !,
  format('\\hline~N', []),
  format("  ~t~s~60|& ~t~2f~76|&~t~d~82|\\\\~N", [DESCR, VALUE, LINE]),
  format('\\hline~N', []);
  LINEDATA =.. [dl, LINE, DESCR],
  line(TAXPAYER, YEAR, FORM, LINE, VALUE),
  !,
  format("  ~t~s~60|& ~t~2f~76|&~t~d~82|\\\\~N", [DESCR, VALUE, LINE]).
%  format("%04d  ~44s %14.2f~N", [LINE, DESCR, VALUE]).

render_form(_TAXPAYER, _YEAR, _FORM, []).

render_form(TAXPAYER, YEAR, FORM, [LINE|REST]) :-
    render_line(TAXPAYER, YEAR, FORM, LINE),
    !,
    render_form(TAXPAYER, YEAR, FORM, REST);
    render_form(TAXPAYER, YEAR, FORM, REST).

render_line(TAXPAYER, YEAR, FORM, LINEDATA):-
  LINEDATA =.. [tl, LINE, DESCR],
%  LINEDATA is tl(LINE, DESCR),
  line(TAXPAYER, YEAR, FORM, LINE, VALUE),
  !,
%  format('~4s  ~44s ~18s~N', ["", "", "-----------"]),
  format('~t~s~78|~N', ["------------"]),
  format("~t~d~5|  ~t~s~60| ~t~2f~76|~N", [LINE, DESCR, VALUE]),
%  format("%04d  ~44s %14.2f~N", [LINE, DESCR, VALUE]),
  format('~t~s~78|~N', ["------------"]);
%  LINEDATA is dl(LINE, DESCR),
  LINEDATA =.. [dl, LINE, DESCR],
  line(TAXPAYER, YEAR, FORM, LINE, VALUE),
  !,
  format("~t~d~5|  ~t~s~60| ~t~2f~76|~N", [LINE, DESCR, VALUE]).
%  format("%04d  ~44s %14.2f~N", [LINE, DESCR, VALUE]).

%The use of stored_line/4 represents a MAJOR performance optimization.
%MANY of the rules make reference to the a small set of lines on the
%tax return, notably Net Income, Taxable Income, and such.  Without the
%optimization presented here, each of those references will trace the
%calculations back to their sources.

%stored_line/4 is used to implement a technique known as "memoization."
%When a line/4 rule fires, it looks to see if there is already a stored
%value.  If there is, it immediately returns that value.  If not, then
%it proceeds with the calculation, and saves the value.  The part about
%"immediately returns that value" means that no rawline/4 calculation
%needs to be inferred more than once.

:- dynamic stored_line/5.
% discontiguous([(taxfact,4), (taxfact,3), (rawline,5), (line,5)]).

line(A, B, C, D, E) :-
  stored_line(A,B,C,D,E),
  !;
  rawline(A,B,C,D,E),
  assert(stored_line(A,B,C,D,E)),
  !.

% Taxation facts that are inferred directly from tax facts
infirm_dependent(TAXPAYER, YEAR, DEPENDENT) :-
  taxfact(DEPENDENT, YEAR, 'Dependent of', TAXPAYER),
  taxfact(DEPENDENT, YEAR, 'Infirm', 'Yes').

non_infirm_dependent(TAXPAYER, YEAR, DEPENDENT) :-
  taxfact(DEPENDENT, YEAR, 'Dependent of', TAXPAYER),
  taxfact(DEPENDENT, YEAR, 'Infirm', 'Yes'),
  fail;
  taxfact(DEPENDENT, YEAR, 'Dependent of', TAXPAYER).

taxfact(TAXPAYER, YEAR, 'Dependents', DEPENDENTS) :-
  setof(A_DEP, non_infirm_dependent(TAXPAYER, YEAR, A_DEP), DEPENDENTS).

taxfact(TAXPAYER, YEAR, 'Infirm Dependents', DEPENDENTS) :-
  setof(A_DEP, infirm_dependent(TAXPAYER, YEAR, A_DEP), DEPENDENTS).

taxfact(TAXPAYER, YEAR, 'Age', AGE) :-
  taxfact(TAXPAYER, YEAR, 'Year of Birth', YOB),
  AGE is YEAR - YOB.
