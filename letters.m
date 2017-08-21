function conc = letters(x,k)

conc(1) = x(3)*x(5)/k(1);
conc(2) = x(4)*x(5)/k(2);
conc(3) = x(5)*x(6)/k(3);
conc(4) = x(3)*x(4)/k(4);
conc(5) = x(3)*x(4)*x(5)/(k(1)*k(4));
conc(6) = x(1)*x(4)/k(5);
conc(7) = x(1)*x(4)*x(5)/(k(2)*k(5));
conc(8) = x(2)*x(4)/k(6);
conc(9) = x(2)*x(4)*x(5)/(k(2)*k(6));
conc(10) = x(1)*x(3)/k(7);
conc(11) = x(1)*x(3)*x(5)/(k(1)*k(7));
conc(12) = x(2)*x(3)/k(8);
conc(13) = x(2)*x(3)*x(5)/(k(1)*k(8));
conc(14) = x(1)*x(3)*x(4)/(k(4)*k(9));
conc(15) = x(2)*x(3)*x(4)/(k(10)*k(4));
conc(16) = x(1)*x(3)*x(4)*x(5)/(k(1)*k(4)*k(9));
conc(17) = x(2)*x(3)*x(4)*x(5)/(k(1)*k(10)*k(4));

% conc = [a, b, c, d, e, f, g, h, l, m, n, o, p, q, r, s, t]