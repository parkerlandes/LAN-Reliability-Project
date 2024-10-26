%% Function runTwoSeriesLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

function result = runTwoSeriesLinkSim(K, p, N)
    simResults = ones(1, N); % Preallocate array for simulation results

    for i = 1:N
        txAttemptCount = 0; % Transmission count for the current simulation
        pktSuccessCount = 0; % Number of successfully transmitted packets

        % While it hasn't successfully transmitted all K packets
        while pktSuccessCount < K
            % Simulate the transmission for a single packet across two links
            txAttemptCount = txAttemptCount + 1; % Count this transmission attempt

            r1 = rand; % Random number for first link
            r2 = rand; % Random number for second link

            % Check if both links successfully transmitted the packet
            if r1 >= p && r2 >= p
                pktSuccessCount = pktSuccessCount + 1; % Increase success count
            else
                % Retry until both links succeed
                while true
                    r1 = rand; % New random number for first link
                    r2 = rand; % New random number for second link
                    txAttemptCount = txAttemptCount + 1; % Count this additional attempt

                    if r1 >= p && r2 >= p
                        pktSuccessCount = pktSuccessCount + 1; % Count this packet as successful
                        break; % Exit the retry loop
                    end
                end
            end
        end

        simResults(i) = txAttemptCount; % Record total number of attempts for this simulation
    end

    result = mean(simResults); % Return the average number of transmissions across all simulations
end




