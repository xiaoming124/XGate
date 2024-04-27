clc;
clear;
close all;

% Sampling parameters
fs = 2e6;          % default sample rate 2MHz

% LORA pkt variables
num_data_sym = 112; % for (125kHz, SF8) packet

% Parameters for signal display
% ST_LORA = 3.6e5;                % start pos of LoRa signal samples
% ED_LORA = 8.9e5;                % end pos of LoRa signal samples
% SPECTRO_LEN = 2048*5+num_symb;      % max length of LoRa spectrom

% figure display configuration
SHOW_SIGNALS = 0;   % show the raw signals or not
SHOW_SPECTRUM = 1;  % show the spectrum of raw signals or not

%
% data loading section
%
% load data 
fi_1 = fopen('input/concurrentPacket/concurrentPacket_125e3_8_250e3_10_500e3_12.dat','rb');
x_inter_1 = fread(fi_1, 'float32');
fclose(fi_1);

% load true symbols
grd_truth_125e3_8 = load("input/concurrentPacket/125e3_8_gth_112sym.mat").grd_truth_SF8;
grd_truth_250e3_10 = load("input/concurrentPacket/250e3_10_gth_88sym.mat").grd_truth_250_SF10;
grd_truth_500e3_12 = load("input/concurrentPacket/500e3_12_gth_49sym.mat").grd_truth_500_SF12;

% if data is complex
x_1 = x_inter_1(1:2:end) + 1i*x_inter_1(2:2:end);

% scale signal amplitude to around 1
x_1 = x_1 * 50; 
% add gaussian noise
SNR = 10;
x_1 = awgn(x_1, SNR);

% locating signal samples
% sig_st = ST_LORA;
% sig_ed = ED_LORA;

target_signal = x_1(1:end);


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
SER_125 = 1;
SER_250 = 1;
SER_500 = 1;
for ii = 1:packetCnt
    if receivedPacket(1,ii) == 500e3
        disp(['BW ' num2str(receivedPacket(1,ii)/1e3) 'kHz, SF ' num2str(receivedPacket(2,ii)) ' packet detected at freq: ' num2str(receivedPacket(3,ii)/1e6) 'MHz.']);
        SER_temp = SER(receivedPacket(2,ii),grd_truth_500e3_12,demodSymbol(:,ii));
        if SER_temp < SER_500
            SER_500 = SER_temp;
        end
    elseif receivedPacket(1,ii) == 250e3
        disp(['BW ' num2str(receivedPacket(1,ii)/1e3) 'kHz, SF ' num2str(receivedPacket(2,ii)) ' packet detected at freq: ' num2str(receivedPacket(3,ii)/1e6) 'MHz.']);
        SER_temp = SER(receivedPacket(2,ii),grd_truth_250e3_10,demodSymbol(:,ii));
        if SER_temp < SER_250
            SER_250 = SER_temp;
        end
    elseif receivedPacket(1,ii) == 125e3
        disp(['BW ' num2str(receivedPacket(1,ii)/1e3) 'kHz, SF ' num2str(receivedPacket(2,ii)) ' packet detected at freq: ' num2str(receivedPacket(3,ii)/1e6) 'MHz.']);
        SER_temp = SER(receivedPacket(2,ii),grd_truth_125e3_8,demodSymbol(:,ii));
        if SER_temp < SER_125
            SER_125 = SER_temp;
        end
    end
end
disp('******************************************')
disp(['Symbol Error Rate for this File SER_500kHz = ' num2str(SER_500) ', SER_250kHz = ' num2str(SER_250) ', SER_125kHz = ' num2str(SER_125)]);
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
