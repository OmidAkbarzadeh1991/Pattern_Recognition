function lambda=lambda_fi(g)
gb=prod(g)*poly(-1./g); % find the coefficients of p(lambda)
gb(end-1:end)=gb(end-1:end)-1; % correct the last two
gc=roots(gb); % find the roots of p(lambda)=0
ii=(imag(gc)==0)&(gc>=-1)...
    &(abs(gc)>0.001); % identify lambda’s index
lambda=(gc(ii)); % find lambda
end