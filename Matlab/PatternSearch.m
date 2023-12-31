function [packetNumTemp, packetDetected] = PatternSearch(peakMatrix)
%   PATTERNSEARCH 此处显示有关此函数的摘要
%   此处显示详细说明
nfft = length(peakMatrix);
step = 1;
packetDetected = zeros(40,2);
packetNumTemp = 0;
for bin = 1:nfft
    if peakMatrix(bin, step)
        if peakMatrix(bin, step + 1) && peakMatrix(bin, step + 2) && peakMatrix(bin, step + 3) && peakMatrix(bin, step + 4)
            packetNumTemp = packetNumTemp + 1;
            packetDetected(packetNumTemp, 1) = 1;
            packetDetected(packetNumTemp, 2) = mod(bin + nfft/32 - 1, nfft) + 1;
%             disp(["BW 125kHz Packet Detected at bin#",bin]);
        end

        if peakMatrix(mod(bin + nfft/16 - 1, nfft) + 1, step + 1) && peakMatrix(bin, step + 2) && peakMatrix(mod(bin + nfft/16 - 1, nfft) + 1, step + 3) && peakMatrix(bin, step + 4)
            packetNumTemp = packetNumTemp + 1;
            packetDetected(packetNumTemp, 1) = 2;
            packetDetected(packetNumTemp, 2) = mod(bin + nfft/16 - 1, nfft) + 1;
%             disp("BW 250kHz Packet Detected at bin#");
        end
 
        if peakMatrix(mod(bin + nfft/16 - 1, nfft) + 1, step + 1) && peakMatrix(mod(bin + nfft/16*2 - 1, nfft) + 1, step + 2) && peakMatrix(mod(bin + nfft/16*3 - 1, nfft) + 1, step + 3) && peakMatrix(bin, step + 4)
            packetNumTemp = packetNumTemp + 1;
            packetDetected(packetNumTemp, 1) = 3;
            packetDetected(packetNumTemp, 2) = mod(bin + nfft/8 - 1, nfft) + 1;
%             disp(["BW 500kHz Packet Detected at bin#",bin]);
        end

    end
end

end

