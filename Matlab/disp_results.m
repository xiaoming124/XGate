function [successNum] = disp_results(packetCnt,receivedPacket,demodSymbol,gth)
%DISP_RESULTS 此处显示有关此函数的摘要
%   此处显示详细说明
successNum = 0;
for ii = 1:packetCnt
    if receivedPacket(1,ii) == 62.5e3
        disp(['BW ' num2str(receivedPacket(1,ii)/1e3) 'kHz, SF ' num2str(receivedPacket(2,ii)) ' packet detected at freq: ' num2str(receivedPacket(3,ii)/1e6) 'MHz.']);
        SER_temp = SER(receivedPacket(2,ii), gth,demodSymbol(:,ii));
        if SER_temp < 0.2
            successNum = successNum + 1;
        end
    end
end
end

