%% This is how everything has been relabelled so that all the totals
% put in at the beginning are A(i), the remaining part of that chemical is 
% x(i), and all the rate constants are k(i).
%
% A = [DNA1tot, DNA2tot,    I1tot,  L3tot,  LdLIDtot,   Lm4tot  ]
% x = [DNA1,    DNA2,       I1,     L3,     LdLID,      Lm4     ]
%
% letters = [a, b, c, d, e, f, g, h, l, m, n, o, p, q, r, s, t]
%
% k = [Kd1, Kd2, Kd3, Kd4, Kd5, Kd6, Kd7, Kd8, Kd9, Kd10]
%
% The six equations are in the file "rootChemicals.m", written so that the
% function should output a zero-vector when the solution is correct.
%
% All the other equations which are used to compute the 'letter' chemicals
% are in the file "letters.m" which is used after finding the solution.
%%

% Define the values of A and k:
% A = [DNA1tot, DNA2tot,    I1tot,  L3tot,  LdLIDtot,   Lm4tot  ]
As  = [1000,    900,       1100,   1000,   300,       1000]; %play with this as the initial concentrations
% k = [Kd1, Kd2,  Kd3, Kd4, Kd5, Kd6,  Kd7,  Kd8,  Kd9, Kd10]
ks  = [29,  0.41, 1.8, 260, 20,  1500, 1000, 5000, 40,  25];

% Define the function we want to find the roots of by substituting in A and
% k but not yet x:
findMyZeros=@(x) rootChemicals(x,ks,As);

% Initial guess for x, x=As/2 seems reasonable
guess=As/2;

% Using fsolve to solve the problem for x:
% x = [DNA1,    DNA2,       I1,     L3,     LdLID,      Lm4     ]
xs = fsolve(findMyZeros,guess);

% Compute the other letters
% letters = [a, b, c, d, e, f, g, h, l, m, n, o, p, q, r, s, t]
ls=letters(xs,ks);

%% A Simple Graph
%Define labels for the graph
figure(1)

conclabels = categorical({'DNA1tot', 'DNA2tot',    'I1tot',  'L3tot',  'LdLIDtot',   'Lm4tot',...
                 'DNA1',    'DNA2',       'I1',     'L3',     'LdLID',      'Lm4',...
                 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't'});
totalSoln=[As,xs,ls];

%Plot a nice graph of the result
bar(conclabels,totalSoln)
ylabel('Concentration')
xlabel('Chemical')
title('How much of each chemical?')


%% A Better Graph
%
% Make a matrix with all the compounds of each initial chemical in that
% row, according to the initial equations:
%  A1 == l10 + l11 + l14 + l16 + l6 + l7 + x1
%  A2 == l12 + l13 + l15 + l17 + l8 + l9 + x2
%  A3 == l1 + l10 + l11 + l12 + l13 + l14 + l15 + l16 + l17 + l4 + l5 + x3
%  A4 == l14 + l15 + l16 + l17 + l2 + l4 + l5 + l6 + l7 + l8 + l9 + x4
%  A5 == l1 + l11 + l13 + l16 + l17 + l2 + l3 + l5 + l7 + l9 + x5
%  A6 == l3 + x6 

%Each A(i) has an x(i)
xTransferMatrix=eye(6);

%Each A(i) has the following combinations of l(i)
letterTransferMatrix= [ 0     0     1     0     1     0;...
                        0     0     0     1     1     0;...
                        0     0     0     0     1     1;...
                        0     0     1     1     0     0;...
                        0     0     1     1     1     0;...
                        1     0     0     1     0     0;...
                        1     0     0     1     1     0;...
                        0     1     0     1     0     0;...
                        0     1     0     1     1     0;...
                        1     0     1     0     0     0;...
                        1     0     1     0     1     0;...
                        0     1     1     0     0     0;...
                        0     1     1     0     1     0;...
                        1     0     1     1     0     0;...
                        0     1     1     1     0     0;...
                        1     0     1     1     1     0;...
                        0     1     1     1     1     0];
                    
TransferMatrix=[xTransferMatrix; letterTransferMatrix];
StackedBarMatrix=repmat([xs ls],6,1).*TransferMatrix';

%Write the labels
initialConcLabels = categorical({'DNA1tot', 'DNA2tot',    'I1tot',  'L3tot',  'LdLIDtot',   'Lm4tot'});

otherConcLabels={'DNA1',    'DNA2',       'I1',     'L3',     'LdLID',      'Lm4',...
                 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't'};
             
%Plot the graph!
figure(2)
bar(initialConcLabels,StackedBarMatrix,'stacked')
colormap(colorcube)
lgd=legend(otherConcLabels','location','northeastoutside','Orientation','vertical');
lgd.Title.String = 'Chemicals';
xlabel('Initial chemical')
ylabel('Stacked concentration')
title('What did each chemical become?')


