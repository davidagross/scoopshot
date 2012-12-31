function [first7DigPrimePalindromeInConsecutiveDigsOfPi,digits] = scoopshot
% Scoopshot is hiring a SW Developer!
% We are looking for great software developers to join our team in 
% Helsinki, Finland. No specific skillset or background is required, beyond 
% a solid grasp of CS fundamentals. Point us to your public code, or tell 
% us something interesting you?ve done.
%
% Send your application (and your code) to:
%
% { the first 7-digit palindromic prime found in consecutive digits of pi } 
% @scoopshot.com
%
% This function aims to determine the email address above

%% find all 7 digit palindromes.  there are 9000 of them.
disp('Finding all 7 digit prime palindromes...');
tic
[A,B,C,D] = ndgrid(1:9,0:9,0:9,0:9);
palindromes = ...
    A(:)*1e6+B(:)*1e5+C(:)*1e4+D(:)*1e3+C(:)*1e2+B(:)*1e1+A(:)*1e0;
primePalindromes = palindromes(isprime(palindromes));
primePalindromesStr = cellfun(@num2str,num2cell(primePalindromes), ...
    'UniformOutput',false);
toc
%% get digits of pi
% disp('Downloading 1 million digits of pi...');
disp('Reading 1 million digits of pi...');
tic
% piHtml = ...
%     urlread('http://www.piday.org/includes/pi_to_1million_digits_v2.html');
piHtml = fileread('piHtml.html');
notNumbers = regexp(piHtml,'[^\d]');
numbers = setdiff(1:numel(piHtml),notNumbers);
% numbers(1) and numbers(2) are the '1' and '0' of "10px", and numbers(3)
% start pi, 3.  
piDigits = piHtml(numbers(4:end));
toc
%% find the match
disp('Finding the first match...');
tic
ret = regexp(piDigits,primePalindromesStr);
palindromeInds = cell2mat(ret');
firstDigit = min(palindromeInds);
digits = firstDigit+(0:6);
first7DigPrimePalindromeInConsecutiveDigsOfPi = ...
    piDigits(digits);
toc