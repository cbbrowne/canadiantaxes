%% -*- Prolog -*-

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

:- include('taxutils').
:- include('annualrates').
:- include('t1').
:- include('t2204').
:- include('t691').
:- include('t626').
:- include('t4').
:- include('schedule1').
:- include('schedule3').
:- include('schedule4').
:- include('schedule5').
:- include('schedule7').
:- include('schedule8').
:- include('schedule9').
:- include('schedule11').
:- include('on479').
:- include('on428').
:- include('lsif').
% Raw Facts
t4(456789012, 1, "BigCo", 62538, 1402, 0, 619, 0, 0, 12641, 0, 0, 0, 0, 0).

taxfact(456789012, 'Name', 'Joe Who').
taxfact(456789012, 'Interest Income', 2500).
taxfact(456789012, 2003, 'RRSP Contributions - Rest of Year', 1200).
taxfact(456789012, 2004, 'RRSP Contributions - 1st 60 Days', 74300).
taxfact(456789012, 2003, 'RRSP Deduction Limit', 14000).
taxfact(456789012, 'Charitable Donations', 1250).
taxfact(456789012, 'Rent', RENT) :-
  RENT is 12 * 1255.
taxfact(456789012, 'Year of Birth', 1971).

taxfact(456789012, 'Spouse', 987654321).

% Info about spouse
t4(987654321, 1, "LittleCo", 21538, 282, 0, 3690, 0, 0, 2127, 0, 0, 0, 0, 0).
taxfact(987654321, 'Name', 'Lady Who').
taxfact(987654321, 'Year of Birth', 1973).
taxfact(987654321, 'Charitable Donations', 800).

% info about son, 123456789
taxfact(123456789, 'Name', 'Timmy Who').
taxfact(123456789, 'Year of Birth', 1992).
taxfact(123456789, 'Interest Income', 400).
taxfact(123456789, 'Unused Tuition and Education - 2002', 0).
taxfact(123456789, 'Tuition', 1800).
taxfact(123456789, 'T2202A - B', 8).
taxfact(123456789, 'Transfer education amount to parent', X) :-
  line(123456789, 'Schedule 11', 19, X).
taxfact(123456789, 'Dependent of', 456789012).

% info about daughter, 246802468
taxfact(246802468, 'Name', 'Tammy Who').
taxfact(246802468, 'Year of Birth', 1984).
taxfact(246802468, 'Interest Income', 300).
taxfact(246802468, 'Unused Tuition and Education - 2002', 0).
taxfact(246802468, 'Tuition', 2800).
taxfact(246802468, 'Infirm', 'Yes').  % She is officially disabled...
taxfact(246802468, 'T2202A - C', 12).
taxfact(246802468, 'Transfer education amount to parent', X) :-
   line(246802468, 'Schedule 11', 19, X).
taxfact(246802468, 'Dependent of', 456789012).

% Local Variables:
% mode: prolog
