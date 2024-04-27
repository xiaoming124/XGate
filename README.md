# XGate-Matlab

Instructions to use XGate to receive LoRa packets.

XGate can be configured on-the-fly via software to receive all LoRa logical channels within an Rx spectrum.

## Folders: 
filter - coe of digital LP filters (bandwidth 62.5kHz~500kHz), used to extract LoRa packets from raw signal after detecting packet and meta-information.

input - three data traces of raw signal.

## Key Functions: 

XGate_Receive.m - detect and receive LoRa packets using XGate, return (1) number of detected packets; (2) parameters of detected packets; (3) demodulated symbols.

PacketDetection_XGate.m - detect packet and meta-information.

PatternSearch.m - search for specific peak patterns from the dechirp-FFT results of consecutive windows (a sub-funtion in XGate packet detection).

## Hardware Requirements:

LoRa transmitter: SX1276 + Arduino Uno (or other LoRa-compatible radios)

Data trace collection: USRP N210 (or other Software Defined Radios with equivalent functionality)

Data trace processing: A workstation with Matlab (version:R2022b)

## To run the artifact:

We provide three data traces that reproduce the key functions of XGate.

Open the "Matlab" folder, and run three main files, the detected packets and parameters are printed on the command window.

main_singlePacket.m - detect and receive a single packet without channel information (refer to Figure 2). 

main_concurrentPacket.m - detect and receive three concurrent packets with different parameters but the same slope (refer to Figure 3 and Figure 5).

main_concurrentPacket_168CHs - concurrently utilize 168 logical channels in 1.6MHz spectrum (refer to the peak dot of "XGate (Setting #2)" Figure 11(a)).

## To run and evaluate XGate on your own testbed

Collect data traces: 

1. Set up USRP at 2M sps (by default) with appropriate central frequency under your experiment settings (e.g., central frequency = 915MHz that covers the spectrum 914-916MHz).
2. Set up LoRa radios with any transmission parameters but ensure they can be covered by the Rx spectrum of USRP (e.g., central frequency = 914.6MHz, bandwidth = 250kHz).
3. Use the GNURadio Project "gr-lora-ChannelS\examples\rx_usrp.grc" to collect data traces. The trace will be saved by the "File Sink" block. Then forward the received data traces to the workstation.

Pre-process and synthesize the data traces:

1. Extract the ground truth files of the modulated symbols (e.g., the '.mat' files in the 'input' folder). Receive the LoRa packet individually using standard LoRa demodulators, and we can get the results.
2. Normalize the per-packet amplitude to around 1 by modifying the Rx gain in USRP or other factors since XGate uses the threshold method for packet detection, or you may need to adjust the detection threshold in our released code.
3. Select multiple data traces and add them up with random time offsets to emulate large-scale network traffic. To evaluate the maximum concurrency, the packet power normalization is important because the performance of logical channel concurrency may be affected by the near-far effect (refer to Figure 16 and Figure 17).


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
