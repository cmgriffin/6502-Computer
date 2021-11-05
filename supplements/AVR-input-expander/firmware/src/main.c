// A very simple parallel-in serial-out shift register emulator
// The atmega168 is extremly overqualified for this but has two full 8-bit ports
// available that make for a simple 16 input implementation

#include <avr/io.h>
#include <avr/interrupt.h>

#define SRCLK_PIN PC0
#define RCLK_PIN PC1
#define SER_PIN PC2

#define CLK_POLARITY_RISING
//#define CLK_POLARITY_FALLING
#define PARALLEL_INPUT
//#define PARALLEL_OUTPUT

#ifdef CLK_POLARITY_RISING
#ifdef CLK_POLARITY_FALLING
#error "CLK_POLARITY_RISING and CLK_POLARITY_FALLING cannot both be defined"
#endif
#endif

#ifdef PARALLEL_INPUT
#ifdef PARALLEL_OUTPUT
#error "PARALLEL_INPUT and PARALLEL_OUTPUT cannot both be defined"
#endif
#endif

/*******Globals*******/

volatile uint8_t SrclkLastState,
    RclkLastState;             // for the ISR to determine which pin was triggered
volatile uint16_t inputBuffer; // hold the input data once it is latched

void initGpio()
{
#ifdef PARALLEL_INPUT
  PORTB = 0xff;         // enable all the pullups for easier debugging
  PORTD = 0xff;         // enable all the pullups for easier debugging
  DDRC |= _BV(SER_PIN); // set serial pin as an output
#else
  PORTC |= _BV(SER_PIN); // input by default, enable the pullup
  DDRB = 0xff;           // configure as outputs, low by default
  DDRD = 0xff;           // configure as outputs, low by default
#endif
  PORTC |= _BV(SRCLK_PIN) | _BV(RCLK_PIN); // input by default, enable the pullups
  PCICR |= _BV(PCIE1);                     // enable pin change interupts for portc
  PCMSK1 |= _BV(PCINT8) | _BV(PCINT9);     // enable the pin change interupt for SRCLK and RCLK pins
}

// ISR where all updates functionality is implemented
// optimized to have lowest delay from SRCLK to SER output
#ifdef PARALLEL_INPUT
ISR(PCINT1_vect)
{
  cli(); // disable interupts
  uint8_t SrclkState = (PINC & _BV(SRCLK_PIN));
#ifdef CLK_POLARITY_RISING
  if (SrclkLastState && !SrclkState)
  // negative edge on SRCLK
#else
  if (!SrclkLastState && SrclkState)
  // positive edge on SRCLK
#endif
  {
    if (inputBuffer & 0x8000)
    {
      PORTC = PORTC | _BV(SER_PIN); // will set SER pin high;
    }
    else
    {
      PORTC = PORTC & ~_BV(SER_PIN); // will set SER pin low;
    }
    inputBuffer <<= 1; // shift left so next bit sent is next highest bit
  }

  uint8_t RclkState = (PINC & _BV(RCLK_PIN));

#ifdef CLK_POLARITY_RISING
  if (!RclkLastState && RclkState)
// positive edge on RCLK
#else
  if (RclkLastState && !RclkState)
// negative edge on RCLK
#endif
  {
    // positive edge on RCLK
    // store the data currently present at the inputs and start shifting from beginning
    inputBuffer = ((uint16_t)PIND << 8); // high byte
    inputBuffer += (uint16_t)PINB;       // low byte
  }

  SrclkLastState = SrclkState; // update the last state vars
  RclkLastState = RclkState;

  sei(); // enable interupts
}
#else
ISR(PCINT1_vect)
{
  cli(); // disable interupts
  // PORTC ^= _BV(SER_PIN);
  // PORTC ^= _BV(SER_PIN);
  uint8_t SrclkState = (PINC & _BV(SRCLK_PIN));
#ifndef CLK_POLARITY_RISING
  if (SrclkLastState && !SrclkState)
  // negative edge on SRCLK
#else
  if (!SrclkLastState && SrclkState)
  // positive edge on SRCLK
#endif
  {
    inputBuffer <<= 1; // shift left so next bit sent is next highest bit
    inputBuffer += !!(PINC & _BV(SER_PIN));
  }

  uint8_t RclkState = (PINC & _BV(RCLK_PIN));

#ifdef CLK_POLARITY_RISING
  if (!RclkLastState && RclkState)
// positive edge on RCLK
#else
  if (RclkLastState && !RclkState)
// negative edge on RCLK
#endif
  {
    PORTD = (uint8_t)(inputBuffer >> 8);   // high byte
    PORTB = (uint8_t)(inputBuffer & 0xff); // low byte
  }

  SrclkLastState = SrclkState; // update the last state vars
  RclkLastState = RclkState;

  sei(); // enable interupts
}
#endif

int main(void)
{
  initGpio(); // setup the Gpio
  sei();      // enable interupts

  for (;;)
  {
    // everything is done in the ISR
  }
  return 0;
}