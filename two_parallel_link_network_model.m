%% Simulation parameters
K1 = 1;
K2 = 5;
K3 = 15;
K4 = 50;
K5 = 100;
N = 1000;

%% Probability Range
p = 0.01:0.01:0.99; % vector with range of probabilities from 0 to 1 non-inclusive

%% Simulated results

simulated_result1 = ones(1, length(p));
simulated_result2 = ones(1, length(p));
simulated_result3 = ones(1, length(p));
simulated_result4 = ones(1, length(p));
simulated_result5 = ones(1, length(p));

for i=1:length(p)
    simulated_result1(i) = runTwoParallelLinkSim(K1,p(i),N);
    simulated_result2(i) = runTwoParallelLinkSim(K2,p(i),N);
    simulated_result3(i) = runTwoParallelLinkSim(K3,p(i),N);
    simulated_result4(i) = runTwoParallelLinkSim(K4,p(i),N);
    simulated_result5(i) = runTwoParallelLinkSim(K5,p(i),N);
end

%% Graph results
% Figure 1
figure; semilogy(simulated_result1, 'ok', 'DisplayName', 'Simulated K=1')
hold off
legend show; 
title('Results for K = 1');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 2
figure; semilogy(simulated_result2, 'om', 'DisplayName', 'Simulated K=5')
hold off
legend show; 
title('Results for K = 5');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 3
figure; semilogy(simulated_result3, 'og', 'DisplayName', 'Simulated K=15')
hold off
legend show; 
title('Results for K = 15');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 4
figure; semilogy(simulated_result4, 'or', 'DisplayName', 'Simulated K=50')
hold off
legend show; 
title('Results for K = 50');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 5
figure; semilogy(simulated_result5, 'ob', 'DisplayName', 'Simulated K=100')
hold off
legend show; 
title('Results for K = 100');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 6 - Combined figure for all K values
figure;
hold on
semilogy(simulated_result1, 'ok', 'DisplayName', 'Simulated K=1');
semilogy(simulated_result2, 'om', 'DisplayName', 'Simulated K=5');
semilogy(simulated_result3, 'og', 'DisplayName', 'Simulated K=15');
semilogy(simulated_result4, 'or', 'DisplayName', 'Simulated K=50');
semilogy(simulated_result5, 'ob', 'DisplayName', 'Simulated K=100');
hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

%% two_parallel_link_simulation()

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
