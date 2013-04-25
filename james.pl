%% -*- Prolog -*-
:- include('taxreturn').

%% example

t4(483950333, 1, "LibertyRMS", 73538, 1801.8, 0, 819, 0, 0, 18641, 0, 0, 0, 0, 0).
t4(483950333, 2, "LibertyRMS", 6800, 163, 0, 0, 0, 0, 1500, 0, 0, 0, 0, 0).

taxfact(483950333, 'Name', 'Christopher Browne').

taxfact(483950333, 'Province', 'Ontario').

taxfact(2003, 'US Exchange Rate', 1.40146175).

taxfact(483950333, 'Interest Income', INTEREST) :-
  taxfact(2003, 'US Exchange Rate', RATE),
  AACU_INTEREST is 364.42,
  INTEREST is (AACU_INTEREST * RATE + 67.94).

taxfact(483950333, 'RRSP Contributions', 2003, 200).
taxfact(483950333, 'RRSP Contributions', 2004, X) :-
  INITIAL = 3500,
  REST = 2200,
  X is INITIAL + REST.

taxfact(483950333, 'LSIF 02', 2000).

taxfact(483950333, '2003 RRSP Deduction Limit', 18687).
taxfact(483950333, 'Charitable Donations', TOTAL_DONATIONS) :- 
 %  CCC is 61 * 12,
  CHBC is 1282,
  WATERLOO is 100,
%  TOTAL_DONATIONS is CCC + CHBC + WATERLOO.
  TOTAL_DONATIONS is CHBC + WATERLOO.

taxfact(483950333, 'Professional Fees', ACM) :-
  US_AMT is 150,
  taxfact(2003, 'US Exchange Rate', RATE),
%  ACM is US_AMT * RATE.
  ACM is 0.
  
taxfact(483950333, 'Rent', RENT) :-
  RENT is 12 * 1255.
taxfact(483950333, 'Year of Birth', 1967).

:- display_form(483950333, 'T1').
:- display_form(483950333, 'Schedule 1').
:- display_form(483950333, 'Schedule 3').
:- display_form(483950333, 'Schedule 4').
:- display_form(483950333, 'Schedule 5').
:- display_form(483950333, 'Schedule 7').
:- display_form(483950333, 'Schedule 8').
:- display_form(483950333, 'Schedule 9').
:- display_form(483950333, 'T2204').
:- display_form(483950333, 'T691').
:- display_form(483950333, 'T626').
:- display_form(483950333, 'T4').
:- display_form(483950333, 'ON479').
:- display_form(483950333, 'ON428').
