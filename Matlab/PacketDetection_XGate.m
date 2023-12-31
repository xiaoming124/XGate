function [packetNum,blindDetectionOutput] = PacketDetection_XGate(fs,rxdata,BW,SF,th1,maxFalsePeak)
%PACKETDETECTION_XGATE 此处显示有关此函数的摘要
%   此处显示详细说明
win = 2^SF*16/(BW/125e3);
tt = 1:win;
tt = tt/fs;
tt = tt';
k = BW^2/2^SF;

%% Directly use short window
downchirp = exp(-1j*pi*k*tt.^2);
ii = 1;
window_len = win;
nfft = 2^SF*16/(BW/125e3);
peakMatrix = zeros(nfft,5);
cnt = 0;
packetNum = 0;
blindDetectionOutput = zeros(nfft,3);

while ii < length(rxdata) - window_len
    decoding_window = rxdata(ii : ii + window_len - 1);
    dechirp_signal = decoding_window .* downchirp;
    blindDechirpOutput = abs(fftshift(fft(dechirp_signal,nfft)));
    peakDetected = zeros(nfft,1);
    for jj = 1:nfft
        if blindDechirpOutput(jj) > th1
%             disp(blindDechirpOutput(jj));
%             disp(jj);
            peakDetected(jj) = 1;
            cnt = cnt + 1;
            % th = 75
            if cnt > maxFalsePeak
                peakDetected = zeros(nfft,1);
                break;
            end
        end
    end
    cnt = 0;
    peakMatrix(:,1) = [];
    peakMatrix = [peakMatrix peakDetected];
    [packetNumTemp, packetDetected] = PatternSearch(peakMatrix);
    for packetId = 1:length(packetDetected)
        packet = packetDetected(packetId,:);
        if ~packet(1) == 0
            blindDetectionOutput(packet(2), packet(1)) = ii - window_len*5;      
        end
    end
    ii = ii + window_len;
    if packetNumTemp > 0
        packetNum = 1;
%         return;
    end
end

end

