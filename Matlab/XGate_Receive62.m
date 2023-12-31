function [packetCnt, receivedPacket, demodSymbol] = XGate_Receive62(fs,Receive_Sig,BW,SF,Threshold,MaxPeakNum,SymbolNum)
% Receive LoRa packet using XGate
% Example - XGate_Receive(Fs, Sig, BW_min, SF_min, Threshold, MaxPeakNum);
% Parameters:
% Fs: sampling rate (by default = 2MHz)
% Sig: raw signal
% BW_min & SF_min: the minimum BW and SF under a specific slope, used to
%     generate downchirp with short window
% Threshold: the detection threshold after dechirp-FFT
% MaxPeakNum: maximum number of peaks after threshold decision
% SymbolNum: number of symbols in payload

% load filter coe
filter62 = load("filter\62k_Filter.mat").Num';
% filter125 = load("filter\125k_Filter.mat").Num';
% filter250 = load("filter\250k_Filter.mat").Num';
% filter500 = load("filter\500k_Filter.mat").Num';

% successfulReceptionNum = 0;
receivedPacket = zeros(3,10);
demodSymbol = zeros(200,10);
packetCnt = 1;

% detect LoRa packet and extract parameters

% Only use short window
[~, detectionOutput] = PacketDetection_XGate(fs,Receive_Sig, BW, SF, Threshold, MaxPeakNum);
nfft = 2^SF * 32;

% Collaborate long and short window
% [~, detectionOutput] = PacketDetection_XGatePlus(fs,Receive_Sig, BW, SF, Threshold, Threshold*4, MaxPeakNum);
% nfft = 2^SF * 16 * 4;

% result cleaning
for ii = 1:length(detectionOutput)
    for jj = 1:3
        if detectionOutput(ii,jj) > 0  && detectionOutput(mod(ii + nfft/32 - 1,nfft) + 1,jj) > 0
            detectionOutput(mod(ii + nfft/32 - 1,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/32 - 1 + 1,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/32 - 1 - 1,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/32 - 1 + 2,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/32  - 1 - 2,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/32/2 - 1,nfft) + 1,jj) = detectionOutput(ii,jj);
            detectionOutput(ii,jj) = 0;
            detectionOutput(ii-1,jj) = 0;
            detectionOutput(ii+1,jj) = 0;
            detectionOutput(ii-2,jj) = 0;
            detectionOutput(ii+2,jj) = 0;
        end
    end
end


for ii = 1:length(detectionOutput)
    for jj = 1:3
        if detectionOutput(ii,jj) > 0
            timeStep = round(detectionOutput(ii,jj)/32) + 1;
            detectionOutput(ii+1,jj) = 0;
            detectionOutput(ii+2,jj) = 0;
%             centralF = ii / nfft * 2e6 - 1e6;
            centralF = (mod(ii - nfft/64 - 1, nfft) + 1) / nfft * 2e6 - 1e6;
            tt = 1:length(Receive_Sig);
            tt = tt/fs;
            tt = tt.';
            Receive_Sig_channel = Receive_Sig .* exp(-1j * 2*pi * (centralF) * tt);
            if jj == 1
                Receive_Sig_af = conv(Receive_Sig_channel,filter62,'full');
                Receive_Sig_af = downsample(Receive_Sig_af, 32);
                decodeOutput = demodulation(62.5e3,Receive_Sig_af(timeStep:end),62.5e3,SF,SymbolNum);
                receivedPacket(:,packetCnt) = [BW, SF, centralF];
                demodSymbol(1:length(decodeOutput),packetCnt) = decodeOutput;
                packetCnt = packetCnt + 1;
            end
        end
    end
end
packetCnt = packetCnt - 1;
end



