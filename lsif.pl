%% -*- Prolog -*-
% $Id: lsif.pl,v 1.4 2005/04/04 13:32:42 cbrowne Exp $
% LSIF - Labour Sponsored Investment Funds
% and Employee Ownership Tax Credits

% 2003 Rules Prepared by
% Christopher B. Browne
% cbbrowne Computing Inc
% cbbrowne@acm.org

%Released under the "chat" license; do as you like with this, just
%don't claim you wrote it, don't remove the Lurid Disclaimer, and
%remember, if it breaks, you get to keep all of the pieces.

%LURID DISCLAIMER:  START

%Note that I Am Not A Lawyer, and provide neither legal advice nor
%advice about managing your taxes.  If your use of this software leads
%to your getting audited, or to you paying either too little or too
%much tax, just remember that I denied that I was offering tax or legal
%advice.

%Imagine further lurid warnings like "Contains live plague bacteria.
%Beware the Rabid Hippopotami.  May cause bleeding at the eyes.

%LURID DISCLAIMER:  END

rawline(TAXPAYER, _YEAR, 'LSIF', 2, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 02', X).

rawline(TAXPAYER, _YEAR, 'LSIF', 3, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 03', X).

rawline(TAXPAYER, _YEAR, 'LSIF', 4, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 04', X).

rawline(TAXPAYER, _YEAR, 'LSIF', 5, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 05', X).

rawline(TAXPAYER, _YEAR, 'LSIF', 6, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 06', X). 

rawline(TAXPAYER, _YEAR, 'LSIF', 7, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 07', X).

rawline(TAXPAYER, _YEAR, 'LSIF', 8, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 08', X).

rawline(TAXPAYER, _YEAR, 'LSIF', 9, X) :-
  taxfact(TAXPAYER, _YEAR, 'LSIF 09', X).
