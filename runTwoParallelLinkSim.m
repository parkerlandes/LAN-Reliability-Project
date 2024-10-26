%% Function runTwoParallelLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

function result = runTwoParallelLinkSim(K,p,N)

    simResults = ones(1,N); % a place to store the result of each simulation

    for i=1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        % While we haven't successfully transmitted all K packets
        while pktSuccessCount < K
            
            % Start
            r1 = rand; % gen first random num to determine if packet is successful (r > p)
            r2 = rand; % gen second random num to determine if packet is successful (r > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % If both are unsuccessful
            while r1 < p && r2 < p
                r1 = rand; % transmit again, generate new success check value r
                r2 = rand; % transmit again, generate new success check value r
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end 

            pktSuccessCount = pktSuccessCount + 1; % increase success count after success (r > p)

        end

        simResults(i) = txAttemptCount; % Record total number of attempts for this simulation
    end

    result = mean(simResults);
end

