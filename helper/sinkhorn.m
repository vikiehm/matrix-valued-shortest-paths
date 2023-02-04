function X = sinkhorn(X, eps)
	N = size(X,1);
    M = size(X,2);
	e = ones(N,1);
    e_row = ones(M,1);
	
    if ( ~exist('eps', 'var') )
        eps = 1e-3;
    end
	vis = 0;
    
    max_iterations = 100000;
	
	if ( vis ) 
		figure;
    end

	norm_sums = [];
    curr_iteration = 0;
	while ( isempty(norm_sums) || norm_sums(end) > eps )
        curr_iteration = curr_iteration + 1;
        %bsxfun(@times, X, 1./rowSum);
        if curr_iteration > max_iterations
            X = 1/size(X,1) * ones(size(X));
            warning("Max Iteration reached")
            break
        end
        if size(X,1) == size(X,2)
            rowSum = X'*e;
            X = X*spdiag(1./rowSum); 
            colSum = X*e;
            X = spdiag(1./colSum)*X; 
            %bsxfun(@times, X, 1./(colSum'));
            norm_sums(end+1) = norm(X*e-e) + norm(X'*e-e);
        else
            colSum = X*e_row;
            X = diag(1./colSum)*X; 
            %bsxfun(@times, X, 1./(colSum));
            norm_sums(end+1) = norm(X*e_row-e);
        end

		if ( vis )
			cla;
			plot(norm_sums);
			drawnow;
		end
	end
end