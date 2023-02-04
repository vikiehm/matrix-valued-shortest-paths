function [y] = entropy_log(x)
%ENTROPY_LOG returns 1 if x = 0 else returns log(x)
if x == 0
    y = 0;
else 
    y = log(x);
end
end

