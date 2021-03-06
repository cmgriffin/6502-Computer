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
P 5500 4050
F 0 "U1" H 4971 4096 50  0000 R CNN
F 1 "ATtiny13A-PU" H 4971 4005 50  0000 R CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 5500 4050 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/doc8126.pdf" H 5500 4050 50  0001 C CNN
	1    5500 4050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 614565BA
P 5500 4850
F 0 "#PWR03" H 5500 4600 50  0001 C CNN
F 1 "GND" H 5505 4677 50  0000 C CNN
F 2 "" H 5500 4850 50  0001 C CNN
F 3 "" H 5500 4850 50  0001 C CNN
	1    5500 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 4850 5500 4800
$Comp
L Switch:SW_Push SW1
U 1 1 61458A36
P 7050 4100
F 0 "SW1" H 7050 4385 50  0000 C CNN
F 1 "SW_Push" H 7050 4294 50  0000 C CNN
F 2 "" H 7050 4300 50  0001 C CNN
F 3 "~" H 7050 4300 50  0001 C CNN
	1    7050 4100
	1    0    0    -1  
$EndComp
NoConn ~ 6100 4250
$Comp
L power:+5V #PWR01
U 1 1 6145DB6C
P 5500 3150
F 0 "#PWR01" H 5500 3000 50  0001 C CNN
F 1 "+5V" H 5515 3323 50  0000 C CNN
F 2 "" H 5500 3150 50  0001 C CNN
F 3 "" H 5500 3150 50  0001 C CNN
	1    5500 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 4100 7550 4100
Wire Wire Line
	5500 3450 5500 3350
Wire Wire Line
	6100 3950 6600 3950
Wire Wire Line
	6600 3950 6600 4100
Wire Wire Line
	6600 4100 6850 4100
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 61463D33
P 8300 3350
F 0 "J1" H 8272 3282 50  0000 R CNN
F 1 "Conn_01x03_Male" H 8272 3373 50  0000 R CNN
F 2 "" H 8300 3350 50  0001 C CNN
F 3 "~" H 8300 3350 50  0001 C CNN
	1    8300 3350
	-1   0    0    1   
$EndComp
Connection ~ 7550 4100
Wire Wire Line
	7550 3450 8100 3450
Wire Wire Line
	8100 3350 6400 3350
Wire Wire Line
	6400 3850 6100 3850
Wire Wire Line
	8100 3250 5500 3250
Connection ~ 5500 3250
Wire Wire Line
	5500 3250 5500 3150
Text Label 6200 3850 0    50   ~ 0
~RST~
Text Label 6200 3950 0    50   ~ 0
USR_RST_BTN
$Comp
L Device:C C1
U 1 1 6146E342
P 4150 4100
F 0 "C1" H 4265 4146 50  0000 L CNN
F 1 "C" H 4265 4055 50  0000 L CNN
F 2 "" H 4188 3950 50  0001 C CNN
F 3 "~" H 4150 4100 50  0001 C CNN
	1    4150 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 4250 4150 4800
Wire Wire Line
	4150 4800 5500 4800
Connection ~ 5500 4800
Wire Wire Line
	5500 4800 5500 4650
Wire Wire Line
	4150 3950 4150 3350
Wire Wire Line
	4150 3350 5500 3350
Connection ~ 5500 3350
Wire Wire Line
	5500 3350 5500 3250
Wire Wire Line
	7550 3450 7550 4100
Wire Wire Line
	6400 3350 6400 3850
Wire Wire Line
	7550 4100 7550 4300
$Comp
L power:GND #PWR04
U 1 1 61461255
P 7550 4300
F 0 "#PWR04" H 7550 4050 50  0001 C CNN
F 1 "GND" H 7555 4127 50  0000 C CNN
F 2 "" H 7550 4300 50  0001 C CNN
F 3 "" H 7550 4300 50  0001 C CNN
	1    7550 4300
	1    0    0    -1  
$EndComp
NoConn ~ 6100 4050
NoConn ~ 6100 4150
NoConn ~ 6100 3750
$EndSCHEMATC
