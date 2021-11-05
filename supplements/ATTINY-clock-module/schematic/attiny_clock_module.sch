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
L MCU_Microchip_ATtiny:ATtiny13A-PU U1
U 1 1 614558E6
P 5800 4100
F 0 "U1" H 5271 4146 50  0000 R CNN
F 1 "ATtiny13A-PU" H 5271 4055 50  0000 R CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 5800 4100 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc8126.pdf" H 5800 4100 50  0001 C CNN
	1    5800 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 614565BA
P 5800 5200
F 0 "#PWR03" H 5800 4950 50  0001 C CNN
F 1 "GND" H 5805 5027 50  0000 C CNN
F 2 "" H 5800 5200 50  0001 C CNN
F 3 "" H 5800 5200 50  0001 C CNN
	1    5800 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 5200 5800 4850
$Comp
L Switch:SW_SPST SW2
U 1 1 614573B2
P 7350 4550
F 0 "SW2" H 7350 4785 50  0000 C CNN
F 1 "SW_SPST" H 7350 4694 50  0000 C CNN
F 2 "" H 7350 4550 50  0001 C CNN
F 3 "~" H 7350 4550 50  0001 C CNN
	1    7350 4550
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 61458A36
P 7350 4150
F 0 "SW1" H 7350 4435 50  0000 C CNN
F 1 "SW_Push" H 7350 4344 50  0000 C CNN
F 2 "" H 7350 4350 50  0001 C CNN
F 3 "~" H 7350 4350 50  0001 C CNN
	1    7350 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT RV1
U 1 1 61459B87
P 7350 5350
F 0 "RV1" H 7280 5396 50  0000 R CNN
F 1 "R_POT" H 7280 5305 50  0000 R CNN
F 2 "" H 7350 5350 50  0001 C CNN
F 3 "~" H 7350 5350 50  0001 C CNN
	1    7350 5350
	-1   0    0    -1  
$EndComp
NoConn ~ 6400 4300
Wire Wire Line
	7200 5350 6700 5350
Wire Wire Line
	6700 5350 6700 4200
Wire Wire Line
	6700 4200 6400 4200
Wire Wire Line
	7150 4550 6800 4550
Wire Wire Line
	6800 4550 6800 4100
Wire Wire Line
	6800 4100 6400 4100
$Comp
L power:+5V #PWR01
U 1 1 6145DB6C
P 5800 3200
F 0 "#PWR01" H 5800 3050 50  0001 C CNN
F 1 "+5V" H 5815 3373 50  0000 C CNN
F 2 "" H 5800 3200 50  0001 C CNN
F 3 "" H 5800 3200 50  0001 C CNN
	1    5800 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR02
U 1 1 6145E558
P 7350 5100
F 0 "#PWR02" H 7350 4950 50  0001 C CNN
F 1 "+5V" H 7365 5273 50  0000 C CNN
F 2 "" H 7350 5100 50  0001 C CNN
F 3 "" H 7350 5100 50  0001 C CNN
	1    7350 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 61461255
P 7850 5650
F 0 "#PWR04" H 7850 5400 50  0001 C CNN
F 1 "GND" H 7855 5477 50  0000 C CNN
F 2 "" H 7850 5650 50  0001 C CNN
F 3 "" H 7850 5650 50  0001 C CNN
	1    7850 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 4150 7850 4150
Wire Wire Line
	7850 4150 7850 4550
Wire Wire Line
	7350 5500 7350 5600
Wire Wire Line
	7350 5600 7850 5600
Connection ~ 7850 5600
Wire Wire Line
	7850 5600 7850 5650
Wire Wire Line
	7550 4550 7850 4550
Connection ~ 7850 4550
Wire Wire Line
	7850 4550 7850 5600
Wire Wire Line
	5800 3500 5800 3400
Wire Wire Line
	6400 4000 6900 4000
Wire Wire Line
	6900 4000 6900 4150
Wire Wire Line
	6900 4150 7150 4150
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 61463D33
P 8600 3400
F 0 "J1" H 8572 3332 50  0000 R CNN
F 1 "Conn_01x03_Male" H 8572 3423 50  0000 R CNN
F 2 "" H 8600 3400 50  0001 C CNN
F 3 "~" H 8600 3400 50  0001 C CNN
	1    8600 3400
	-1   0    0    1   
$EndComp
Wire Wire Line
	7850 3500 7850 3700
Connection ~ 7850 4150
Wire Wire Line
	7850 3500 8400 3500
Wire Wire Line
	8400 3400 6700 3400
Wire Wire Line
	6700 3400 6700 3700
Wire Wire Line
	6700 3900 6400 3900
Wire Wire Line
	8400 3300 5800 3300
Connection ~ 5800 3300
Wire Wire Line
	5800 3300 5800 3200
Text Notes 7400 3250 0    50   ~ 0
Power Input\nClock Output
Text Notes 7950 4050 0    50   ~ 0
Clock Single Step
Text Notes 7950 4550 0    50   ~ 0
Continuous/Halted Switch
Text Notes 7900 5400 0    50   ~ 0
Continuous Mode \nFrequency Adjustment
Wire Wire Line
	7350 5100 7350 5200
Text Label 6850 3400 0    50   ~ 0
CLK
Text Label 6500 4000 0    50   ~ 0
STEP
Text Label 6500 4100 0    50   ~ 0
HALT
Text Label 6800 5350 0    50   ~ 0
ADJ
$Comp
L Device:C C1
U 1 1 6146E342
P 4450 4150
F 0 "C1" H 4565 4196 50  0000 L CNN
F 1 "C" H 4565 4105 50  0000 L CNN
F 2 "" H 4488 4000 50  0001 C CNN
F 3 "~" H 4450 4150 50  0001 C CNN
	1    4450 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 4300 4450 4850
Wire Wire Line
	4450 4850 5800 4850
Connection ~ 5800 4850
Wire Wire Line
	5800 4850 5800 4700
Wire Wire Line
	4450 4000 4450 3400
Wire Wire Line
	4450 3400 5800 3400
Connection ~ 5800 3400
Wire Wire Line
	5800 3400 5800 3300
$Comp
L Device:LED D1
U 1 1 61471925
P 7550 3700
F 0 "D1" H 7543 3445 50  0000 C CNN
F 1 "GREEN" H 7543 3536 50  0000 C CNN
F 2 "" H 7550 3700 50  0001 C CNN
F 3 "~" H 7550 3700 50  0001 C CNN
	1    7550 3700
	-1   0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 61475998
P 7050 3700
F 0 "R1" V 7257 3700 50  0000 C CNN
F 1 "R" V 7166 3700 50  0000 C CNN
F 2 "" V 6980 3700 50  0001 C CNN
F 3 "~" H 7050 3700 50  0001 C CNN
	1    7050 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7200 3700 7400 3700
Wire Wire Line
	7700 3700 7850 3700
Connection ~ 7850 3700
Wire Wire Line
	7850 3700 7850 4150
Wire Wire Line
	6900 3700 6700 3700
Connection ~ 6700 3700
Wire Wire Line
	6700 3700 6700 3900
$Comp
L Device:LED D2
U 1 1 6147B9BF
P 3900 4350
F 0 "D2" V 3939 4232 50  0000 R CNN
F 1 "RED" V 3848 4232 50  0000 R CNN
F 2 "" H 3900 4350 50  0001 C CNN
F 3 "~" H 3900 4350 50  0001 C CNN
	1    3900 4350
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R2
U 1 1 6147B9C5
P 3900 3850
F 0 "R2" H 3970 3896 50  0000 L CNN
F 1 "R" H 3970 3805 50  0000 L CNN
F 2 "" V 3830 3850 50  0001 C CNN
F 3 "~" H 3900 3850 50  0001 C CNN
	1    3900 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 4000 3900 4200
Wire Wire Line
	3900 4850 4450 4850
Wire Wire Line
	3900 4500 3900 4850
Connection ~ 4450 4850
Wire Wire Line
	3900 3400 4450 3400
Wire Wire Line
	3900 3400 3900 3700
Connection ~ 4450 3400
$EndSCHEMATC
