function [H,u,pos] = exactFlatSignal(H,u)
    uT = u(1:500);

    pos = find(u == max(max(uT)));
    H = H(pos+1:pos+1000);
    u = u(pos+1:pos+1000);
end