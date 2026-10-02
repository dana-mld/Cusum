# Cusum Anomaly Detection

The project combines a Python reference model with a VHDL implementation built around **AXI4-Stream** components.

## Overview

It identifies abnormal changes between consecutive sensor measurements.
A sample is marked as anomalous when either cumulative sum exceeds the configured threshold.

## Input 

The dataset contains temperature measurements from six sensors:

- DS18B20
- DHT11
- LM35DZ
- BMP180
- Thermistor
- DHT22

The original floating-point measurements are converted to integers by multiplying each value by `100`.  
The processed values are exported as binary files for hardware simulation.

## Software Implementation

The Python implementation runs the CUSUM algorithm independently on each sensor time series and plots the detected anomalies.
It also serves as a reference model for checking the behavior of the VHDL implementation.

## Hardware Implementation

The hardware design processes the sensor stream using VHDL modules connected through **AXI4-Stream** interfaces.

The resulting values are compared with the anomaly threshold. When the threshold is exceeded, the current sample is labeled as anomalous and the cumulative sums are reset.

## Technologies

- VHDL
- Xilinx Vivado
- AXI4-Stream
- Python
- pandas
- matplotlib
