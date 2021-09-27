function EPS = my_eps(a)
    % Matrix Calculations - HW1 Q7
    EPS = 1;
    a_pluse= EPS + a;
    while a_pluse > a
        EPS = EPS / 2;
        a_pluse= a + EPS;
    end
end
