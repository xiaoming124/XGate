function [packetCnt, receivedPacket, demodSymbol] = XGate_Receive(fs,Receive_Sig,BW,SF,Threshold,MaxPeakNum,SymbolNum)
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
filter125 = load("filter\125k_Filter.mat").Num';
filter250 = load("filter\250k_Filter.mat").Num';
filter500 = load("filter\500k_Filter.mat").Num';
% grd_truth_SF8 = load("LoRaData\LoRaPacket\125e3_8_0cf_gth.mat").grd_truth_SF8;

% successfulReceptionNum = 0;
receivedPacket = zeros(3,10);
demodSymbol = zeros(200,10);
packetCnt = 1;

% detect LoRa packet and extract parameters

% Only use short window
[~, detectionOutput] = PacketDetection_XGate(fs,Receive_Sig, BW, SF, Threshold, MaxPeakNum);
nfft = 2^SF * 16;

% Collaborate long and short window
% [~, detectionOutput] = PacketDetection_XGatePlus(fs,Receive_Sig, BW, SF, Threshold, Threshold*4, MaxPeakNum);
% nfft = 2^SF * 16 * 4;

% result cleaning
for ii = 1:length(detectionOutput)
    for jj = 1:3
        if detectionOutput(ii,jj) > 0  && detectionOutput(mod(ii + nfft/16 - 1,nfft) + 1,jj) > 0
            detectionOutput(mod(ii + nfft/16 - 1,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/16 - 1 + 1,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/16 - 1 - 1,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/16 - 1 + 2,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/16  - 1 - 2,nfft) + 1,jj) = 0;
            detectionOutput(mod(ii + nfft/16/2 - 1,nfft) + 1,jj) = detectionOutput(ii,jj);
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
            timeStep = round(detectionOutput(ii,jj)/16) + 1;
            detectionOutput(ii+1,jj) = 0;
            detectionOutput(ii+2,jj) = 0;
            centralF = ii / nfft * 2e6 - 1e6;
            tt = 1:length(Receive_Sig);
            tt = tt/fs;
            tt = tt.';
            Receive_Sig_channel = Receive_Sig .* exp(-1j * 2*pi * (centralF) * tt);
            if jj == 1
%                 disp(['BW 125kHz Packet detected at sample: ', num2str(ii) , ', freq: ', num2str(centralF/1e6), ' MHz']);
                Receive_Sig_af = conv(Receive_Sig_channel,filter125,'full');
                Receive_Sig_af = downsample(Receive_Sig_af, 16);
                decodeOutput = demodulation(BW,Receive_Sig_af(timeStep:end),BW,SF,SymbolNum);
                receivedPacket(:,packetCnt) = [125e3, SF, centralF];
                demodSymbol(1:length(decodeOutput),packetCnt) = decodeOutput;
                packetCnt = packetCnt + 1;
            elseif jj == 2
%                 disp(['BW 250kHz Packet detected at sample: ', num2str(ii) , ', freq:', num2str(centralF/1e6), ' MHz']);
                Receive_Sig_af = conv(Receive_Sig_channel,filter250,'full');
                Receive_Sig_af = downsample(Receive_Sig_af, 8);
                decodeOutput = demodulation(BW*2,Receive_Sig_af(timeStep:end),BW*2,SF+2,SymbolNum);
                receivedPacket(:,packetCnt) = [250e3, SF+2, centralF];
                demodSymbol(1:length(decodeOutput),packetCnt) = decodeOutput;
                packetCnt = packetCnt + 1;
            elseif jj == 3
%                 disp(['BW 500kHz Packet detected at sample: ', num2str(ii) , ', freq:', num2str(centralF/1e6), ' MHz']);
                Receive_Sig_af = conv(Receive_Sig_channel,filter500,'full');
                Receive_Sig_af = downsample(Receive_Sig_af, 4);
                decodeOutput = demodulation(BW*4,Receive_Sig_af(timeStep:end),BW*4,SF+4,SymbolNum);
                receivedPacket(:,packetCnt) = [500e3, SF+4, centralF];
                demodSymbol(1:length(decodeOutput),packetCnt) = decodeOutput;
                packetCnt = packetCnt + 1;
            end
        end
    end
end
packetCnt = packetCnt - 1;
end



