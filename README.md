# XGate-Matlab

Instructions to use XGate receive LoRa packets.

XGate can be configured on-the-fly via software to receive all LoRa logical channels within an Rx spectrum.

## Folders: 
filter - coe of digital LP filters (bandwidth 62.5kHz~500kHz), used to extract LoRa packets from raw signal after detecting packet and meta-information.

input - data traces of raw signal.

## Key Functions: 

XGate_Receive.m - detect and receive LoRa packets using XGate, return (1) number of detected packets; (2) parameters of detected packets; (3) demodulated symbols.

PacketDetection_XGate.m - detect packet and meta-information.

PatternSearch.m - search for specific peak patterns from the dechirp-FFT results of consecutive windows (a sub-funtion in XGate packet detection).

## To use

Matlab Version: R2022b

Open the "Matlab" folder, and run three main files, the detected packets and parameters are printed on the command window.

main_singlePacket.m - detect and receive a single packet.

main_concurrentPacket.m - detect and receive three concurrent packets with different parameters but the same slope.

main_concurrentPacket_168CHs - concurrently utilize 168 logical channels in 1.6MHz spectrum.

## Citation

```
@inproceedings{yu2024xgate,
  title={Revolutionizing LoRa Gateway with XGate: Scalable Concurrent Transmission across Massive Logical Channels},
  author={Yu, Shiming and Xia, Xianjin and Hou, Ningning and Zheng, Yuanqing and Gu, Tao},
  booktitle={Proceedings of the 30th Annual International Conference on Mobile Computing and Networking},
  year = {2024},
  publisher = {Association for Computing Machinery},
  address = {New York, NY, USA},
  location = {Washington, D.C., USA},
  series = {ACM MobiCom '24}
}
```
