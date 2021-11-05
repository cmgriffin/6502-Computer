# AVR Based 6502 Debugger
This is a debugging/monitoring tool intended to replace the Arduino Mega that Ben Eater used in his videos. An Arduino Nano combined with a parallel in serial out shift
register was used instead. In addition, the function of the clock module was also incorporated into this tool giving the user fairly complete control over the 6502 operation. 
An ATMEGA168 was used to function as the parallel in serial out shift register but any functionally similar shift register should work as well. 

* ATMEGA168 parallel in serial out shift register - [/supplements/AVR-input-expander/](/supplements/AVR-input-expander/)
* ATTINY13 Standalone clock module - [/supplements/ATTINY-clock-module/](/supplements/ATTINY-clock-module/)

![Schematic](/supplements/AVR-6502-Debugger/schematic/AVR-6502-Deubgger-sch.png)
