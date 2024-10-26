%% Simulation parameters
K1 = 1;
K2 = 5;
K3 = 10;
N = 1000;

%% Probability Range
p1 = 0.1;
p2 = 0.6;
p3 = 0.01:0.01:0.99;

%% Simulated results

% Figure 1
simulated_result1 = runCustomCompoundNetworkSim(K1, [p1, p2, p3], N);
simulated_result2 = runCustomCompoundNetworkSim(K2, [p1, p2, p3], N);
simulated_result3 = runCustomCompoundNetworkSim(K3, [p1, p2, p3], N);

% Figure 2
simulated_result4 = runCustomCompoundNetworkSim(K1, [p2, p1, p3], N);
simulated_result5 = runCustomCompoundNetworkSim(K2, [p2, p1, p3], N);
simulated_result6 = runCustomCompoundNetworkSim(K3, [p2, p1, p3], N);

% Figure 3
simulated_result7 = runCustomCompoundNetworkSim(K1, [p1, p3, p2], N);
simulated_result8 = runCustomCompoundNetworkSim(K2, [p1, p3, p2], N);
simulated_result9 = runCustomCompoundNetworkSim(K3, [p1, p3, p2], N);

% Figure 4
simulated_result10 = runCustomCompoundNetworkSim(K1, [p2, p3, p1], N);
simulated_result11 = runCustomCompoundNetworkSim(K2, [p2, p3, p1], N);
simulated_result12 = runCustomCompoundNetworkSim(K3, [p2, p3, p1], N);

% Figure 5
simulated_result13 = runCustomCompoundNetworkSim(K1, [p3, p1, p2], N);
simulated_result14 = runCustomCompoundNetworkSim(K2, [p3, p1, p2], N);
simulated_result15 = runCustomCompoundNetworkSim(K3, [p3, p1, p2], N);

% Figure 6
simulated_result16 = runCustomCompoundNetworkSim(K1, [p3, p2, p1], N);
simulated_result17 = runCustomCompoundNetworkSim(K2, [p3, p2, p1], N);
simulated_result18 = runCustomCompoundNetworkSim(K3, [p3, p2, p1], N);

% Graph Figure 1
figure;
hold on
semilogy(simulated_result1, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result2, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result3, 'og', 'DisplayName', 'Simulated K=10');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

% Graph Figure 2
figure;
hold on
semilogy(simulated_result4, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result5, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result6, 'og', 'DisplayName', 'Simulated K=10');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability]

% Graph Figure 3
figure;
hold on
semilogy(simulated_result7, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result8, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result9, 'og', 'DisplayName', 'Simulated K=10');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

% Graph Figure 4
figure;
hold on
semilogy(simulated_result10, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result11, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result12, 'og', 'DisplayName', 'Simulated K=10');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

% Graph Figure 5
figure;
hold on
semilogy(simulated_result13, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result14, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result15, 'og', 'DisplayName', 'Simulated K=10');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

% Graph Figure 6
figure;
hold on
semilogy(simulated_result16, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result17, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result18, 'og', 'DisplayName', 'Simulated K=10');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

%% custom_compound_network_simulation()

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
