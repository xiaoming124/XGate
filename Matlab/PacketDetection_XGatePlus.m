function [packetNum,blindDetectionOutput] = PacketDetection_XGatePlus(fs,rxdata,BW,SF,th1,th2,maxFalsePeak)
%PACKETDETECTION_XGATE 此处显示有关此函数的摘要
%   此处显示详细说明
win = 2^SF*16/(BW/125e3);
tt = 1:win;
tt = tt/fs;
tt = tt';

tt_long = 1:win*4;
tt_long = tt_long/fs;
tt_long = tt_long';
k = BW^2/2^SF;

%% Collaborate long and short window
downchirp_short = exp(-1j*pi*k*tt.^2);
downchirp_long = exp(-1j*pi*k*tt_long.^2);
ii = 1;
window_len_short = win;
window_len_long = win *4;
nfft = 2^SF*16*4/(BW/125e3);
peakMatrix = zeros(nfft,5);
cnt_short = 0;
cnt_long = 0;

packetNum = 0;
blindDetectionOutput = zeros(nfft,3);

shortFlag = 0;
longFlag = 0;

while ii < length(rxdata) - window_len_long
    decoding_window_short = rxdata(ii : ii + window_len_short - 1);
    decoding_window_long = rxdata(ii : ii + window_len_long - 1);
    dechirp_signal_short = decoding_window_short .* downchirp_short;
    dechirp_signal_long = decoding_window_long .* downchirp_long;
    blindDechirpOutput_short = abs(fftshift(fft(dechirp_signal_short,nfft)));
    blindDechirpOutput_long = abs(fftshift(fft(dechirp_signal_long,nfft)));
    peakDetected_short = zeros(nfft,1);
%     peakDetected_long = zeros(nfft,1);
    peakDetected_final = zeros(nfft,1);

    for jj = 1:nfft
        if blindDechirpOutput_short(jj) > th1 && shortFlag == 0
%             disp(blindDechirpOutput(jj));
            peakDetected_short(jj) = 1;
            cnt_short = cnt_short + 1;
            if cnt_short > maxFalsePeak
                peakDetected_short = zeros(nfft,1);
                shortFlag = 1;
            end
        end


        if blindDechirpOutput_long(jj) > th2 && longFlag == 0
%             disp(blindDechirpOutput(jj));
%             peakDetected_long(jj) = 1;
            peakDetected_final(jj) = 1;
            cnt_long = cnt_long + 1;
            if cnt_long > maxFalsePeak
                peakDetected_final = zeros(nfft,1);
                longFlag = 1;
            end
        end
        
    end

    shortFlag = 0;
    longFlag = 0;

    cnt_short = 0;
    cnt_long = 0;
    % shadow cleaning
    guard = 1;
    for jj = 1: nfft
        if peakDetected_short(jj) == 1
            peakDetected_final(jj) = 1;
            for kk = -guard:guard
                peakDetected_final(mod(jj - nfft/16 + kk - 1,nfft) + 1) = 0;
                peakDetected_final(mod(jj - nfft/16*2 + kk - 1,nfft) + 1) = 0;
                peakDetected_final(mod(jj - nfft/16*3 + kk - 1,nfft) + 1) = 0;
%                 peakDetected_final(ii - nfft/16 * 4 + jj) = 0;
            end
        end
    end

    peakMatrix(:,1) = [];
    peakMatrix = [peakMatrix peakDetected_final];
    [packetNumTemp, packetDetected] = PatternSearch(peakMatrix);
    for packetId = 1:length(packetDetected)
        packet = packetDetected(packetId,:);
        if ~packet(1) == 0
            blindDetectionOutput(packet(2), packet(1)) = ii - window_len_short*5;      
        end
    end
    ii = ii + window_len_short;
    if packetNumTemp > 0
        packetNum = 1;
    end
end

end



