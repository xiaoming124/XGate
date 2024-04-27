clc;
clear;
close all;

% Sampling parameters
fs = 2e6;          % default sample rate 2MHz

% LORA pkt variables
num_data_sym = 112; % for (125kHz, SF8) packet

% Parameters for signal display
ST_LORA = 3.6e5;                % start pos of LoRa signal samples
ED_LORA = 8.9e5;                % end pos of LoRa signal samples
% SPECTRO_LEN = 2048*5+num_symb;      % max length of LoRa spectrom

% figure display configuration
SHOW_SIGNALS = 0;   % show the raw signals or not
SHOW_SPECTRUM = 1;  % show the spectrum of raw signals or not

%
% data loading section
%
% load data 
fi_1 = fopen('input/singlePacket/singlePacket_125e3_8.dat','rb');
x_inter_1 = fread(fi_1, 'float32');
fclose(fi_1);

% load true symbols
grd_truth_125e3_8 = load("input/singlePacket/125e3_8_gth_112sym.mat").grd_truth_SF8;

% if data is complex
x_1 = x_inter_1(1:2:end) + 1i*x_inter_1(2:2:end);

% scale signal amplitude to around 1
x_1 = x_1 * 50; 
% add gaussian noise
SNR = 10;
x_1 = awgn(x_1, SNR);

% locating signal samples
sig_st = ST_LORA;
sig_ed = ED_LORA;

target_signal = x_1(sig_st:sig_ed);


% Receive LoRa packet using XGate

% Example - XGate_Receive(Fs, Sig, BW_min, SF_min, Threshold, MaxPeakNum);
%
% Parameters:
% Fs: sampling rate (by default = 2MHz)
% Sig: raw signal
% BW_min & SF_min: the minimum BW and SF under a specific slope, used to
%     generate downchirp with short window
% Threshold: the detection threshold after dechirp-FFT
% MaxPeakNum: maximum number of peaks after threshold decision
% SymbolNum: maximum number of symbols in payload
%
% Return:
% packetCnt: the number of received packet
% receivedPacket: the parameters of received packet
% demodSymbol: the demodulated symbol of received packet

BW_min = 125e3;
SF_min = 8;
Threshold = 2000;
MaxPeakNum = 135;
SymbolNum = 200;

[packetCnt, receivedPacket, demodSymbol] = XGate_Receive(fs,target_signal,BW_min,SF_min,Threshold,MaxPeakNum,SymbolNum);
% Calculate the SER
demodSER = SER(receivedPacket(2,1),grd_truth_125e3_8,demodSymbol(:,1));
disp('******************************************')
disp(['Symbol Error Rate for this File = ' num2str(demodSER)]);
disp('*****************FINISHED*****************')

% figure plotting
if (SHOW_SIGNALS > 0)
    figure(1);
    plot(abs(x_1));
    xlabel('Samples');
    ylabel('Amplitude');
    title('Raw signals')
end

if (SHOW_SPECTRUM > 0)
    % Time Resolution can be modified
    figure(2);
    pspectrum(x_1,fs,'spectrogram','OverlapPercent',99,'Leakage',0.85,'MinThreshold',-25,'TimeResolution',0.005);
end


% BW_min = 125e3;
% SF_min = 7;
% Threshold = 1080;
% MaxPeakNum = 70;
% SymbolNum = 200;
% 
% 
% BW_min = 125e3;
% SF_min = 8;
% Threshold = 2000;
% MaxPeakNum = 135;
% SymbolNum = 200;
% 
% 
% BW_min = 125e3;
% SF_min = 9;
% Threshold = 3000;
% MaxPeakNum = 270;
% SymbolNum = 200;
% 
% 
% BW_min = 125e3;
% SF_min = 10;
% Threshold = 5000;
% MaxPeakNum = 540;
% SymbolNum = 200;
% 
% 
% BW_min = 125e3;
% SF_min = 11;
% Threshold = 9000;
% MaxPeakNum = 1000;
% SymbolNum = 200;
% 
% 
% BW_min = 125e3;
% SF_min = 12;
% Threshold = 18000;
% MaxPeakNum = 2000;
% SymbolNum = 200;


