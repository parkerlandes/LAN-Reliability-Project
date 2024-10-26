%% Simulation parameters
K1 = 1;
K2 = 5;
K3 = 15;
K4 = 50;
K5 = 100;
N = 1000;

%% Calculated result
p = 0.01:0.01:0.99; % vector with range of probabilities from 0 to 1 non-inclusive

expected_result1 = K1./(1-p);
expected_result2 = K2./(1-p);
expected_result3 = K3./(1-p);
expected_result4 = K4./(1-p);
expected_result5 = K5./(1-p);

%% Simulated result
simulated_result1 = ones(1, length(p));
simulated_result2 = ones(1, length(p));
simulated_result3 = ones(1, length(p));
simulated_result4 = ones(1, length(p));
simulated_result5 = ones(1, length(p));

for i=1:length(p)
    simulated_result1(i) = runSingleLinkSim(K1,p(i),N);
    simulated_result2(i) = runSingleLinkSim(K2,p(i),N);
    simulated_result3(i) = runSingleLinkSim(K3,p(i),N);
    simulated_result4(i) = runSingleLinkSim(K4,p(i),N);
    simulated_result5(i) = runSingleLinkSim(K5,p(i),N);
end

%% Graph results
% Figure 1
figure; semilogy(expected_result1, '-k', 'DisplayName', 'Expected K=1')
hold on
semilogy(simulated_result1, 'ok', 'DisplayName', 'Simulated K=1')
hold off
legend show; 
title('Results for K = 1');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 2
figure; semilogy(expected_result2, '-m', 'DisplayName', 'Expected K=5')
hold on
semilogy(simulated_result2, 'om', 'DisplayName', 'Simulated K=5')
hold off
legend show; 
title('Results for K = 5');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 3
figure; semilogy(expected_result3, '-g', 'DisplayName', 'Expected K=15')
hold on
semilogy(simulated_result3, 'og', 'DisplayName', 'Simulated K=15')
hold off
legend show; 
title('Results for K = 15');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 4
figure; semilogy(expected_result4, '-r', 'DisplayName', 'Expected K=50')
hold on
semilogy(simulated_result4, 'or', 'DisplayName', 'Simulated K=50')
hold off
legend show; 
title('Results for K = 50');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 5
figure; semilogy(expected_result5, '-b', 'DisplayName', 'Expected K=100')
hold on
semilogy(simulated_result5, 'ob', 'DisplayName', 'Simulated K=100')
hold off
legend show; 
title('Results for K = 100');
xlabel('Probability (p)');
ylabel('Number of Transmissions');

% Figure 6 - Combined figure for all K values
figure;
hold on
semilogy(expected_result1, '-k', 'DisplayName', 'Expected K=1');
semilogy(simulated_result1, 'ok', 'DisplayName', 'Simulated K=1');

semilogy(expected_result2, '-m', 'DisplayName', 'Expected K=5');
semilogy(simulated_result2, 'om', 'DisplayName', 'Simulated K=5');

semilogy(expected_result3, '-g', 'DisplayName', 'Expected K=15');
semilogy(simulated_result3, 'og', 'DisplayName', 'Simulated K=15');

semilogy(expected_result4, '-r', 'DisplayName', 'Expected K=50');
semilogy(simulated_result4, 'or', 'DisplayName', 'Simulated K=50');

semilogy(expected_result5, '-b', 'DisplayName', 'Expected K=100');
semilogy(simulated_result5, 'ob', 'DisplayName', 'Simulated K=100');

hold off;
legend show; 
title('Combined Results for All K Values');
xlabel('Probability (p)');
ylabel('Number of Transmissions');
grid on; % Optional: Add grid for better readability

%% single_link_simulation()

function result = runSingleLinkSim(K,p,N)

    simResults = ones(1,N); % a place to store the result of each simulation

    for i=1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        while pktSuccessCount < K

            r=rand; % generate random number to determine if packet is successful (r > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % while packet transmission is not successful (r < p)
            while r < p
                r=rand; % transmit again generate new success check value r
                txAttemptCount = txAttemptCount + 1; % count additional attempt
            end

            pktSuccessCount = pktSuccessCount + 1; % increase success count after success (r > p)
        end

        simResults(i) = txAttemptCount; % Record total number of attempts for this simulation 
    end

    result = mean(simResults);
end