function y = activation_de( x )
%   Detailed explanation goes here
    y = exp(-x)./(1+exp(-x)).^2;
%     y = 2/(pi*(x.^2+1));
end

