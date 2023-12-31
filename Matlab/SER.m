function SER = SER(SF,Result1,Result2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if SF == 7 || SF == 8
    guardBin = 1;
elseif SF == 9 || SF == 10
    guardBin = 2;
else
    guardBin = 4;
end

N = length(Result1);
errCnt = 0;

for ii = 1:N
    tempErr = abs(Result1(ii) - Result2(ii));
    if tempErr > guardBin
        errCnt = errCnt + 1;
    end
end

SER = errCnt / N;

end