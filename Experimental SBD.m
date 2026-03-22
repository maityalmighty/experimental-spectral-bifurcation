% Experimental bifurcation diagram 

clear; clc;

% Storage for bifurcation data
bifpar = [];
bifval = [];

block_size = 2^17;   % number of samples per parameter value
ii = 0;

% Sweep parameter (matches how data was recorded)
for param = -10:0.01:-0.1
    
    % Upload the CSV file (where time series data is recorded through DAQ
    % and python) as "testmatrix3) 
    d = testmatrix3(ii*block_size + 1 : (ii+1)*block_size, 3);
    
    % Remove initial transient (first ~30% of the signal)
    d = d(round(0.3*length(d)) : end);
    
    % Smooth slightly to suppress noise before peak detection
    d = smoothdata(d, 'movmean', 50);
    
    % Detect peaks (these represent oscillation amplitudes)
    [pks, ~] = findpeaks(d, 'MinPeakProminence', 0.005);
    
    % Store peaks along with current parameter value
    bifpar = [bifpar; param * ones(length(pks),1)];
    bifval = [bifval; pks];
    
    ii = ii + 1;
end

% Plot bifurcation diagram
figure
plot(bifpar, bifval, '.k', 'MarkerSize', 6)
xlabel('Parameter')
ylabel('Peak Amplitude')
title('Experimental Bifurcation Diagram (Amplitude Map)')
grid on