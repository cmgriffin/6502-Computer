EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_ATmega:ATmega168-20PU U1
U 1 1 6155DAE3
P 5400 4200
F 0 "U1" H 4757 4246 50  0000 R CNN
F 1 "ATmega168-20PU" H 4757 4155 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 5400 4200 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2545-8-bit-AVR-Microcontroller-ATmega48-88-168_Datasheet.pdf" H 5400 4200 50  0001 C CNN
	1    5400 4200
	1    0    0    -1  
$EndComp
Text Label 6100 3000 0    50   ~ 0
X0
Text Label 6100 3100 0    50   ~ 0
X1
Text Label 6100 3200 0    50   ~ 0
X2
Text Label 6100 3300 0    50   ~ 0
X3
Text Label 6100 3400 0    50   ~ 0
X4
Text Label 6100 3500 0    50   ~ 0
X5
Text Label 6100 3600 0    50   ~ 0
X6
Text Label 6100 3700 0    50   ~ 0
X7
Text Label 6100 4700 0    50   ~ 0
X8
Text Label 6100 4800 0    50   ~ 0
X9
Text Label 6100 4900 0    50   ~ 0
X10
Text Label 6100 5000 0    50   ~ 0
X11
Text Label 6100 5100 0    50   ~ 0
X12
Text Label 6100 5200 0    50   ~ 0
X13
Text Label 6100 5300 0    50   ~ 0
X14
Text Label 6100 5400 0    50   ~ 0
X15
Wire Wire Line
	6000 3000 6350 3000
Wire Wire Line
	6000 3100 6350 3100
Wire Wire Line
	6000 3200 6350 3200
Wire Wire Line
	6000 3300 6350 3300
Wire Wire Line
	6000 3400 6350 3400
Wire Wire Line
	6000 3500 6350 3500
Wire Wire Line
	6000 3600 6350 3600
Wire Wire Line
	6000 3700 6350 3700
Wire Wire Line
	6000 4700 6350 4700
Wire Wire Line
	6000 4800 6350 4800
Wire Wire Line
	6000 4900 6350 4900
Wire Wire Line
	6000 5000 6350 5000
Wire Wire Line
	6000 5100 6350 5100
Wire Wire Line
	6000 5200 6350 5200
Wire Wire Line
	6000 5300 6350 5300
Wire Wire Line
	6000 5400 6350 5400
Entry Wire Line
	6350 3000 6450 3100
Entry Wire Line
	6350 3100 6450 3200
Entry Wire Line
	6350 3200 6450 3300
Entry Wire Line
	6350 3300 6450 3400
Entry Wire Line
	6350 3400 6450 3500
Entry Wire Line
	6350 3500 6450 3600
Entry Wire Line
	6350 3600 6450 3700
Entry Wire Line
	6350 3700 6450 3800
Entry Wire Line
	6350 4700 6450 4800
Entry Wire Line
	6350 4800 6450 4900
Entry Wire Line
	6350 4900 6450 5000
Entry Wire Line
	6350 5000 6450 5100
Entry Wire Line
	6350 5100 6450 5200
Entry Wire Line
	6350 5200 6450 5300
Entry Wire Line
	6350 5300 6450 5400
Entry Wire Line
	6350 5400 6450 5500
Wire Bus Line
	6450 5750 7850 5750
Text Label 7500 5750 0    50   ~ 0
X[0..15]
NoConn ~ 6000 4500
$Comp
L power:+5V #PWR01
U 1 1 615642A6
P 5400 2300
F 0 "#PWR01" H 5400 2150 50  0001 C CNN
F 1 "+5V" H 5415 2473 50  0000 C CNN
F 2 "" H 5400 2300 50  0001 C CNN
F 3 "" H 5400 2300 50  0001 C CNN
	1    5400 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 61565A33
P 5400 5950
F 0 "#PWR05" H 5400 5700 50  0001 C CNN
F 1 "GND" H 5405 5777 50  0000 C CNN
F 2 "" H 5400 5950 50  0001 C CNN
F 3 "" H 5400 5950 50  0001 C CNN
	1    5400 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 5950 5400 5700
Wire Wire Line
	5500 2700 5500 2650
Wire Wire Line
	5500 2650 5400 2650
Wire Wire Line
	5400 2650 5400 2700
Wire Wire Line
	5400 2650 5400 2500
Connection ~ 5400 2650
NoConn ~ 4800 3000
$Comp
L power:PWR_FLAG #FLG02
U 1 1 615674AE
P 3300 4850
F 0 "#FLG02" H 3300 4925 50  0001 C CNN
F 1 "PWR_FLAG" H 3300 5023 50  0000 C CNN
F 2 "" H 3300 4850 50  0001 C CNN
F 3 "~" H 3300 4850 50  0001 C CNN
	1    3300 4850
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 615679B8
P 2850 4850
F 0 "#FLG01" H 2850 4925 50  0001 C CNN
F 1 "PWR_FLAG" H 2850 5023 50  0000 C CNN
F 2 "" H 2850 4850 50  0001 C CNN
F 3 "~" H 2850 4850 50  0001 C CNN
	1    2850 4850
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 61567EE0
P 3300 4850
F 0 "#PWR04" H 3300 4600 50  0001 C CNN
F 1 "GND" H 3305 4677 50  0000 C CNN
F 2 "" H 3300 4850 50  0001 C CNN
F 3 "" H 3300 4850 50  0001 C CNN
	1    3300 4850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR03
U 1 1 615687F5
P 2850 4850
F 0 "#PWR03" H 2850 4700 50  0001 C CNN
F 1 "+5V" H 2865 5023 50  0000 C CNN
F 2 "" H 2850 4850 50  0001 C CNN
F 3 "" H 2850 4850 50  0001 C CNN
	1    2850 4850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 6156A986
P 4150 2950
F 0 "C1" H 4265 2996 50  0000 L CNN
F 1 "100nF" H 4265 2905 50  0000 L CNN
F 2 "" H 4188 2800 50  0001 C CNN
F 3 "~" H 4150 2950 50  0001 C CNN
	1    4150 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 2800 4150 2500
Wire Wire Line
	4150 2500 5400 2500
Connection ~ 5400 2500
Wire Wire Line
	5400 2500 5400 2300
$Comp
L power:GND #PWR02
U 1 1 6156CB60
P 4150 3200
F 0 "#PWR02" H 4150 2950 50  0001 C CNN
F 1 "GND" H 4155 3027 50  0000 C CNN
F 2 "" H 4150 3200 50  0001 C CNN
F 3 "" H 4150 3200 50  0001 C CNN
	1    4150 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 3200 4150 3100
Text Label 6100 3900 0    50   ~ 0
SRCLK
Text Label 6100 4000 0    50   ~ 0
RCLK
Text Label 6100 4100 0    50   ~ 0
SER
Wire Wire Line
	6000 3900 7850 3900
Wire Wire Line
	6000 4000 7850 4000
Wire Wire Line
	6000 4100 7850 4100
Text GLabel 7850 3900 2    50   Input ~ 0
SRCLK
Text GLabel 7850 4000 2    50   Input ~ 0
RCLK
Text GLabel 7850 4100 2    50   Output ~ 0
SER
Text GLabel 7850 5750 2    50   Input ~ 0
X[0..15]
Text Notes 6650 3750 0    50   ~ 0
SRCLK (shift register clock) - shifts the serial data output of memory (rising edge)\nRCLK (register/store clock) - stores the current inputs into memory (rising edge)\nSER (serial data output) - serial data clocked out by SRCLK
NoConn ~ 6000 4200
NoConn ~ 6000 4300
NoConn ~ 6000 4400
Wire Bus Line
	6450 3100 6450 5750
$EndSCHEMATC
