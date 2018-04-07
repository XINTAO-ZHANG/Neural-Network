function f=activation_diff_fn(x)
    f=exp(-x)./(1 + exp(-x)).^2;
end