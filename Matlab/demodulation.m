function PHY_data = demodulation(fs,rxdata,BW,SF,symNum)
%DEMODULATION 此处显示有关此函数的摘要
%   此处显示详细说明

PHY_data = [];
window_len = 2^SF;
tt = 1: window_len;
tt = tt.* 1/fs;
k = BW^2/2^SF;
upchirp = exp(1j*2*pi*(k*0.5*tt-BW/2).*tt).';
downchirp = exp(-1j*2*pi*(k*0.5*tt-BW/2).*tt).';
last_freq = 0;
peak_power = 999999;
% define status: 0,Free; 1,Preambles Detected; 2,SFD Detected
status = 0;
ii = 1;
cnt = 0;
symCnt = 0;

if SF == 7 || SF == 8
    guardBin = 2;
elseif SF == 9 || SF == 10
    guardBin = 4;
else
    guardBin = 8;

end

while ii < length(rxdata) - window_len
    decoding_window = rxdata(ii : ii + window_len - 1);
    dechirp_sig = decoding_window.* downchirp;
    [up_peak,freq] = max(abs(fft(dechirp_sig,2^SF)));
    if status == 0
        if abs(freq - last_freq) <= guardBin/2
            cnt = cnt + 1;          
        end
        if cnt > 3
            peak_power = up_peak;
            status = 1;
            ii = ii + window_len - freq + 1; % make decoding_window aligned with chirp signal
        end
        last_freq = freq;

    elseif status == 1
        dechirp_sig_up = decoding_window .* upchirp;
        [down_peak,~] = max(abs(fft(dechirp_sig_up,2^SF)));
        if(abs(down_peak) > abs(up_peak)) % Downchirp Detected
            status = 2;
%             ii = ii - (window_len - down_freq + 1);
            ii = ii + 2.25 * window_len; % Start from the first symbol
            symbol_start_num = ii;
            ii = ii - window_len;
        end

    elseif status == 2

        symCnt = symCnt + 1;

        if(symCnt <= symNum)
            PHY_data = [PHY_data freq];
%             fprintf("winID: %d, peakPower: %.2f, bin: %d.\n", length(PHY_data),abs(up_peak),freq);

        else
%             end_num = ii; % record the end number
%             status = 0;
            return;
        end
    end 
    ii = ii + window_len;

end

end

