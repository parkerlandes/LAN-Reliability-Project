%% Simulation parameters
K1 = 1;
K2 = 5;
K3 = 15;
K4 = 50;
K5 = 100;
N = 1000;

%% Calculated result
p = 0.01:0.01:0.99; % vector with range of probabilities from 0 to 1 non-inclusive

expected_result1 = K1./((1-p).^2);
expected_result2 = K2./((1-p).^2);
expected_result3 = K3./((1-p).^2);
expected_result4 = K4./((1-p).^2);
expected_result5 = K5./((1-p).^2);
% expected_result1 = (2-p)./((1-p).^2*K1);
% expected_result2 = (2-p)./((1-p).^2*K2);
% expected_result3 = (2-p)./((1-p).^2*K3);
% expected_result4 = (2-p)./((1-p).^2*K4);
% expected_result5 = (2-p)./((1-p).^2*K5);

%% Simulated result

simulated_result1 = ones(1, length(p));
simulated_result2 = ones(1, length(p));
simulated_result3 = ones(1, length(p));
simulated_result4 = ones(1, length(p));
simulated_result5 = ones(1, length(p));

for i=1:length(p)
    simulated_result1(i) = runTwoSeriesLinkSim(K1,p(i),N);
    simulated_result2(i) = runTwoSeriesLinkSim(K2,p(i),N);
    simulated_result3(i) = runTwoSeriesLinkSim(K3,p(i),N);
    simulated_result4(i) = runTwoSeriesLinkSim(K4,p(i),N);
    simulated_result5(i) = runTwoSeriesLinkSim(K5,p(i),N);
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
semilogy(expected_result1, '-k', 'DisplayName', 'Expected K=1');
hold on
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

%% two_series_link_simulation()

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

