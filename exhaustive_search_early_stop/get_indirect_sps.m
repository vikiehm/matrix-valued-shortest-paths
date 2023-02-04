function [new_sps] = get_indirect_sps(sim_matrices)
% checks all possible paths if there exists a shorter indirect
% path than direct path

num_nodes = size(sim_matrices,1);
S=1:num_nodes;
num_cluster = size(sim_matrices{1,2},1);
all_sps = cell(1,num_nodes);
%max_k = 3;
tic
num_ks = cell(1,num_nodes);
D_ks = cell(1,num_nodes);
for i=1:num_nodes 
    num_ks{1,i} = 0;
end
for s=S
    T = 1:num_nodes;
    T = setdiff(T,s);

    D = zeros(1,num_nodes);
    
    smaller_D = cell(num_nodes,num_nodes);
    

    for t=T
        % for every source target pair add direct distance
        D(t) = entropy_fcn(sim_matrices{s,t});
        SPS{1,t} = [s t];
    end
    
    D_ks{1,1} = D;
    
    for i=T
        smaller_D{1,i} = setdiff(find(D < D(i)),s);
    end

    % iterate over path lengths
    for k=1:num_nodes
        num_ks{1,k} = num_ks{1,k} +1;
        A_empty = 1;
        D_k = inf(1,num_nodes);
        for t=T
            %curr_D= smaller_D{:,t};
            A = get_comb_D(k,t,smaller_D);
            if numel(A) ~= 0
                A_empty = 0;
            end

            for p_count = 1: size(A,1)
                P = A(p_count,:);
                P = [s P t];
                M_st = eye(num_cluster);
                for i = 1:numel(P)-1
                    u = P(i);
                    v = P(i+1);
                    M_st = M_st * sim_matrices{u,v};
                end
                if(entropy_fcn(M_st) < D_k(t))
                    D_k(t) = entropy_fcn(M_st);
                end
                if(entropy_fcn(M_st) < D(t))
                    D(t) = entropy_fcn(M_st);
                    for j=1:k
                        smaller_D{j,t} = setdiff(find(D_ks{1,j} < D(t)),s);
                    end
                    SPS{1,t} = P;
                end
            end

        %check for all t if there exist a path to another t that is shorter
        %than the current one

        end
        D_ks{1,k+1} = D_k;
        for i=1:numel(S)
            smaller_D{k+1,i} = find(D_k < D(i));
        end
        all_sps{1,s} = SPS;
        if A_empty 
            break
        end
    end
end

% return only indirect paths that are shorter than direct ones
new_sps = {};
for i=1:size(all_sps,2)
    curr_sps = all_sps{1,i};
    for j=1:size(curr_sps,2)
        curr_sp = curr_sps{1,j};
        if numel(curr_sp) > 2
            already_in = 0;
            for k=1:size(new_sps,2)
                if isequal(new_sps{1,k}, curr_sp) || isequal(new_sps{1,k}, flip(curr_sp,2))
                    already_in = 1;
                end
            end
            if ~already_in && curr_sp(1,1) < curr_sp(1,end)
                new_sps = [new_sps,curr_sp];
            end
        end
    end
end

end

