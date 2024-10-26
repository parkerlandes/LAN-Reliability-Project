%% Function runCustomCompoundNetworkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

% function result = runCustomCompoundNetworkSim(K,p,N)
% 
%     simResults = ones(1,N); % a place to store the result of each simulation
% 
%     for i=1:N
%         txAttemptCount = 0; % transmission count
%         pktSuccessCount = 0; % number of packets that have made it across
% 
%         % While we haven't successfully transmitted all K packets
%         while pktSuccessCount < K
% 
%             % START PARALLEL
%             r1 = rand; % gen first random num to determine if packet is successful (r > p)
%             r2 = rand; % gen second random num to determine if packet is successful (r > p)
%             txAttemptCount = txAttemptCount + 1; % count 1st attempt
% 
%             % if both are unsuccessful
%             while r1 < p && r2 < p
%                 r1 = rand; % transmit again, generate new success check value r
%                 r2 = rand; % transmit again, generate new success check value r
%                 txAttemptCount = txAttemptCount + 1; % count additional attempt
%             end 
% 
%             % SINGLE LINK
%             r3 = rand;
%             txAttemptCount = txAttemptCount + 1; % count 1st attempt
% 
%             while r3 < p
%                 r3 = rand; % transmit again, generate new success check value r
%                 txAttemptCount = txAttemptCount + 1; % count additional attempt
%             end 
% 
%             pktSuccessCount = pktSuccessCount + 1; % increase success count after success (r > p)
% 
%         end
% 
%         simResults(i) = txAttemptCount; % record total number of attempted transmissions before...
%     end
% 
%     result = mean(simResults);
% end

function result = runCustomCompoundNetworkSim(K, p, N)
    simResults = zeros(1, N); % Preallocate array for simulation results

    for i = 1:N
        txAttemptCount = 0; % Transmission count for the current simulation
        pktSuccessCount = 0; % Number of successfully transmitted packets

        % While we haven't successfully transmitted all K packets
        while pktSuccessCount < K
            txAttemptCount = txAttemptCount + 1; % Count this transmission attempt

            % Start parallel link transmissions
            r1 = rand; % Random number for first link
            r2 = rand; % Random number for second link

            % Check for successful transmission on both links
            while r1 < p(1) && r2 < p(2)
                r1 = rand; % New random number for first link
                r2 = rand; % New random number for second link
                txAttemptCount = txAttemptCount + 1; % Count additional attempts
            end 

            % Single link transmission
            r3 = rand; % Random number for the single link
            txAttemptCount = txAttemptCount + 1; % Count this transmission attempt

            while r3 < p(3)
                r3 = rand; % New random number for single link
                txAttemptCount = txAttemptCount + 1; % Count additional attempts
            end 

            pktSuccessCount = pktSuccessCount + 1; % Increase success count after success
        end

        simResults(i) = txAttemptCount; % Record total number of attempts for this simulation
    end

    result = mean(simResults); % Record total number of attempts for all simulations
end
