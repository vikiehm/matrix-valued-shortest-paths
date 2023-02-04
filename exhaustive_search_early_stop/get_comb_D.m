function [A] = get_comb_D(length, t,T_k)
%GET_ALL_COMB calculates all possible path combinations

%only consider targets that are logic 1 in log_D

    for i=1:length
        if isempty(T_k{length,t})
            A = [];
            return
        end
        allV{i} = T_k{i,t};
    end
        A = allcomb(allV{:});
        if  length >= 2
            p = nchoosek(1:length,2);
            duplicates = false(size(A,1),1);
            for i=1:size(p,1)
                duplicates = duplicates | A(:,p(i,1)) == A(:,p(i,2));
            end
            A(duplicates,:) = [];
        end
end

