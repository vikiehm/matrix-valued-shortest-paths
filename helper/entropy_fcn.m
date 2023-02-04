function [entropy] = entropy_fcn(x)
% calculate the similarity of a matrix
%log_m = arrayfun(@(x) entropy_log(x),sim_matrix);
%entropyFcn = @(x) -sum(sum(x.*log_m));
idx = x(:)>0;
entropy = -x(idx)'*log(x(idx));
%entropy = entropyFcn(sim_matrix);
end

