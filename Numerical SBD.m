% Numerical generation of spectral bifurcation diagram (Rössler system)

clear; clc; % For clearing previous uploads

% Parameter sweep range for b
db = 0.001;
b_start = 0.003086;
b_end   = 0.3086;

% Storage for bifurcation data
bif_freq = [];
bif_param = [];
bif_amp = [];

% Initial condition 
ini = 1e-6 * ones(3,1);

for b_val = b_start:db:b_end
    
    % Time settings for integration
    T = 5;
    dt = 1e-5;
    tspan = 0:dt:T;

    % Solver tolerance 
    options = odeset('RelTol',1e-4,'AbsTol',1e-4);

    % Rössler parameters
    a = 0.207;
    c = 7.57;

    % Rössler system (scaled to match experimental results)
    f = @(t, s) [
        -(s(2) + s(3)) * 1e3;
         (s(1) + a*s(2)) * 1e3;
         (b_val + s(3)*(10*s(1) - c)) * 1e3
    ];

    % Solve the system
    [t, sol] = ode45(f, tspan, ini, options);

    % Take the last segment of x(t) for steady-state analysis
    x = sol(end-(2^17 - 1):end, 1);
    n = length(x);

    % Apply window before FFT to reduce spectral leakage
    xw = x .* blackman(n);

    % FFT computation
    Y = fft(xw);
    spectrum = abs(Y/n);
    spectrum = spectrum(1:n/2+1);
    spectrum(2:end-1) = 2*spectrum(2:end-1);

    % Convert to dB scale
    spectrum_db = mag2db(spectrum);

    % Frequency axis
    fs = 1/dt;
    freq = (fs/n)*(0:n/2);

    % Peak detection in frequency spectrum
    temp_spec = [-300; spectrum_db; -300];  
    temp_freq = (fs/n)*(-1:n/2+1);

    [pks, locs] = findpeaks(temp_spec, temp_freq','MinPeakHeight', -300,'MinPeakProminence', 6);

    % Store results for plotting
    bif_freq = [bif_freq; locs];
    bif_param = [bif_param; b_val * ones(length(locs),1)];
    bif_amp = [bif_amp; round(pks)];

    % Use last state as next initial condition (to make it path following)
    ini = sol(end, :)';
end

% Plot spectral bifurcation diagram
figure
colors = turbo(max(bif_amp) - min(bif_amp) + 1);
gscatter(bif_param, bif_freq, bif_amp, colors, '.', 10)

set(gca, 'XDir', 'reverse');
axis tight
xlabel('b')
ylabel('Frequency (Hz)')
title('Rössler FFT Bifurcation Diagram')

% Custom ticks for better readability
xticks([0.0031 0.0309 0.0617 0.0926 0.1235 0.1543 0.1852 0.2160 0.2469 0.2778 0.30806]);
xticklabels({'0.0031','0.0309','0.0617','0.0926','0.1235','0.1543','0.1852','0.2160','0.2469','0.2778','0.30806'});