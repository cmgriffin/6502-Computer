# AVR_input_expander

A very simple AVR based shift register emulator that I created since I did not have something like the 74HC165 to use. The atmega168 is extremely overqualified for this but has two full 8-bit ports available that make for a simple 16 input implementation. An ATTINY48 could have been easily used for this application. 

All functionality after initialization is done inside the ISR. Defines are used to configure if the device is parallel in serial out or serial in parallel out. There is no serial out currently to cascade additional devices. 

Performance wise, this is at least 100x slower than a hardware shift register. In the target application I used a 10us delay between all pin state changes driving the shift register. However, as this is being used to debug a 6502 computer while it is single stepped (this device captures the address bus state), speed is not a concern. 

![Schematic](/supplements/AVR-input-expander/schematic/atmega168_input_expander.png)
