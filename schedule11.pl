%% -*- Prolog -*-
% $Id: schedule11.pl,v 1.5 2005/04/04 13:32:42 cbrowne Exp $
% Schedule 11

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

rawline(TAXPAYER, _YEAR, 'Schedule 11', 1, UNUSED_EDAMTS) :-
   taxfact(TAXPAYER, _YEAR, 'Unused Tuition and Education - 2002', UNUSED_EDAMTS).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 2, TUITION) :-
   taxfact(TAXPAYER, _YEAR, 'Tuition', TUITION).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 320, TUITION) :-
   line(TAXPAYER, _YEAR, 'Schedule 11', 2, TUITION).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 3, EDU_AMT) :-
   taxfact(TAXPAYER, _YEAR, 'T2202A - B', MONTHS),
   MONTHS < 12,
   EDU_AMT is MONTHS * 120;
   taxfact(TAXPAYER, _YEAR, 'T2202A - B', MONTHS),
   MONTHS >= 12,
   EDU_AMT is 12 * 120.

rawline(TAXPAYER, _YEAR, 'Schedule 11', 4, EDU_AMT) :-
   taxfact(TAXPAYER, _YEAR, 'T2202A - C', MONTHS),
   MONTHS < 12,
   EDU_AMT is MONTHS * 400;
   taxfact(TAXPAYER, _YEAR, 'T2202A - C', MONTHS),
   MONTHS >= 12,
   EDU_AMT is 12 * 400.

rawline(TAXPAYER, _YEAR, 'Schedule 11', 5, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 11', [2,3,4], TTL).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 6, TTL) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 11', [1,5], TTL).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 7, TOTAL_INCOME) :-
  line(TAXPAYER, _YEAR, 'T1', 260, TOTAL_INCOME).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 8, CREDITS) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 1', [300, 301, 303, 308, 310, 312], CREDITS).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 9, DIFF) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'Schedule 1', 7, 8, DIFF).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 10, UNUSED) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 1, V1),
  line(TAXPAYER, _YEAR, 'Schedule 11', 9, V2),
  UNUSED is min(V1, V2);
  UNUSED is 0.

rawline(TAXPAYER, _YEAR, 'Schedule 11', 11, DFF2) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 9, V1),
  line(TAXPAYER, _YEAR, 'Schedule 11', 10, V2),
  DFF2 is V1 - V2;
  DFF2 is 0.

rawline(TAXPAYER, _YEAR, 'Schedule 11', 10, CREDITFORYEAR) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 5, V1),
  line(TAXPAYER, _YEAR, 'Schedule 11', 11, V2),
  CREDITFORYEAR is min(V1, V2);
  CREDITFORYEAR is 0.

rawline(TAXPAYER, _YEAR, 'Schedule 11', 13, TUITIONCLAIM) :-
  sumoflines(TAXPAYER, _YEAR, 'Schedule 11', [10, 12], TUITIONCLAIM).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 14, CFWD) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 6, CFWD).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 15, CFWD) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 13, CFWD).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 16, DIFF) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 14, V1),
  line(TAXPAYER, _YEAR, 'Schedule 11', 15, V2),
  DIFF is V1 - V2; 
  DIFF is 0.

rawline(TAXPAYER, _YEAR, 'Schedule 11', 17, MIN) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 5, V1),
  MIN is min(V1, 5000).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 18, V12) :-
  line(TAXPAYER, _YEAR, 'Schedule 11', 12, V12).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 19, TFAMT) :-
  difflines_min_zero(TAXPAYER, _YEAR, 'Schedule 11', 17, 18, TFAMT).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 20, TRANSFERRING) :-
  taxfact(TAXPAYER, _YEAR, 'Transfer education amount to parent', X),
  line(TAXPAYER, _YEAR, 'Schedule 11', 19, MAXTFAMT),
  TRANSFERRING is min(X, MAXTFAMT).

rawline(TAXPAYER, _YEAR, 'Schedule 11', 21, LEFTFORCFWD) :-
   difflines_min_zero(TAXPAYER, _YEAR, 'T1', 16, 20, LEFTFORCFWD).

formatting(_YEAR, 'Schedule 11', 
	[dl(1, "Unused credits from 2002"), dl(2, "Eligible Tuition for Year"),
	 dl(3, "Education Credit - Column B"), dl(4, "Education Credit - Column C"),
	 tl(5, "Total Current Tuition/Edu Amts"), tl(6, "Total Available Educ. amts"),
	 dl(7, "Taxable Income"), dl(8, "Total Credits"), tl(9, "Net Credits"),
	 dl(10, "Unused amts claimed for 2003"), dl(11, "Remaining Edu Amts"),
	 dl(12, "Current Amts Claimed for Year"), tl(13, "Total Tuition/Educational Claims"),
	 dl(14, "Forward from line 6"), dl(15, "Forward from Line 13"),
	 tl(16, "Difference"), dl(17, "Lesser of $5K and Line 5"),
	 dl(18, "Line 12"), tl(19, "Maximum Amount Transferrable"),
	 dl(20, "Amount Transferred"), tl(21, "Educational Credits Carryforward")]).
