#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>
#include <stddef.h>
#include <stdio.h>
#include <gpio.h>
#include <print.h>
#include <uart.h>

#define ADJ_ADC_PIN MUX0    // ADC1 (A1)
#define HALT_PIN_POLARTIY 0 // value to consider active
#define STEP_PIN_POLARITY 0 // value to consider active
#define DEBOUNCE_TIME 20    // ms
#define MIN_PULSE_TIME 1    // ms
#define SR_DELAY_TIME 10    //us (if using a slow software SR)

#define LED_PIN D13

// 6502 direct connected pins
#define DATA_PINS                  \
  {                                \
    D2, D3, D4, D5, D6, D7, D8, D9 \
  }
#define RW_PIN A0

// parallel in serial out shfit register
#define SR_CLK_PIN A2  // shift register clock
#define SR_LOAD_PIN A3 // register load clock
#define SR_SER_PIN A4  // serial data input from SR

// Clock generator control signals
#define HALT_PIN D10
#define STEP_PIN D12
#define CLK_PIN D13

// Globals
GPIO_TypeDef halt_pin = HALT_PIN;
GPIO_TypeDef step_pin = STEP_PIN;
GPIO_TypeDef clk_pin = CLK_PIN;

GPIO_TypeDef data_pins[] = DATA_PINS;
GPIO_TypeDef rw_pin = RW_PIN;

GPIO_TypeDef sr_clk_pin = SR_CLK_PIN;
GPIO_TypeDef sr_load_pin = SR_LOAD_PIN;
GPIO_TypeDef sr_ser_pin = SR_SER_PIN;

uint8_t currentHaltState = 0;  // active
uint8_t previousStepState = 1; // inactive
uint8_t currentStepState = 0;  // active

// -------- Functions --------- //
// A single  varible ms delay function
void delay(uint16_t ms)

{
  for (; ms; ms--)
  {
    _delay_ms(1);
  }
}

// Generic function to handle debouncing of inputs
// Updates the state variable that is passed in if debounce test is passed
void updateInput(GPIO_TypeDef *pin, uint8_t *currentState, uint8_t *previousState)
{
  uint8_t newState = GPIO_getInput(pin);
  if (newState != *currentState)
  {
    _delay_ms(DEBOUNCE_TIME);
    uint8_t checkState = GPIO_getInput(pin);
    if (newState == checkState)
    {
      // if new state remains after the debounce time
      *previousState = *currentState;
      *currentState = newState;
    }
  }
}

void initGpio()
{
  // Configure all the IOs
  GPIO_setOutput(&clk_pin);     // configured as output
  GPIO_setValueHigh(&step_pin); // input pullups enabled
  GPIO_setValueHigh(&halt_pin);
  for (uint8_t i = 0; i < 8; i++)
  {
    // configure with input pullup
    GPIO_setValueHigh(&data_pins[i]);
  }
  GPIO_setValueHigh(&rw_pin);
  GPIO_setOutput(&sr_clk_pin);
  GPIO_setValueHigh(&sr_clk_pin); // intialize to idle state
  GPIO_setOutput(&sr_load_pin);
  GPIO_setValueHigh(&sr_ser_pin);

  // Vcc as ref, ADC1 as input, left adjust result (8 bit mode)
  ADMUX |= (1 << ADJ_ADC_PIN) | (1 << ADLAR) | (1 << REFS0);
  // enable ADC, start conversion, auto trigger enable, 128 prescaler
  ADCSRA |= (1 << ADEN) | (1 << ADSC) | (1 << ADATE) | (1 << ADPS0) | (1 << ADPS1) | (1 << ADPS2);
  // ADCSRB already configured for free running modecc
  DIDR0 |= (1 << ADC1D); // disable the digital input buffer for the ADC pin

  UART_init();
  UART_printStr_p(PSTR("\n\n6502 Debugger Start\n"));
}

uint16_t getAddr()
{
  // pulse the load signal
  GPIO_setValueHigh(&sr_load_pin);
  _delay_us(SR_DELAY_TIME);
  GPIO_setValueLow(&sr_load_pin);
  _delay_us(SR_DELAY_TIME);

  uint16_t addr = 0;
  for (uint8_t bit = 16; bit; bit--)
  {
    GPIO_setValueLow(&sr_clk_pin);
    _delay_us(SR_DELAY_TIME);
    // pulse the clk signal high
    GPIO_setValueHigh(&sr_clk_pin);
    _delay_us(SR_DELAY_TIME);
    // data should be present on ser signal
    addr += GPIO_getInput(&sr_ser_pin) << (bit - 1); // need to subtract 1 so that the MSB is only shifted 15x
  }
  return addr;
}

uint8_t getData()
{
  uint8_t data = 0;
  for (uint8_t bit = 0; bit < 8; bit++)
  {
    data += GPIO_getInput(&data_pins[bit]) << bit;
  }
  return data;
}

// Get the data and print it out of the serial monitor
void printData()
{
  char serBuff[32]; // buffer to use with sprintf
  uint8_t data = getData();
  uint16_t addr = getAddr();
  uint8_t rw = GPIO_getInput(&rw_pin);
  sprintf(serBuff, "ADDR=%04X RWB=%01X DATA=%02X\n", addr, rw, data);
  UART_printStr(serBuff);
}

// Pulse the clock signal and print the data after rising edge
// consider replacing fixed delays with hardware timer for better accuracy
void step_clock()
{
  GPIO_setValueHigh(&clk_pin);
  printData();
  _delay_ms(MIN_PULSE_TIME);
  GPIO_setValueLow(&clk_pin);
  _delay_ms(MIN_PULSE_TIME);
}
int main(void)
{

  initGpio();

  for (;;)
  {
    uint8_t adc_val = ADCH; // get the 8 bit adc result and left shift by 1
    uint16_t pulseTime = (((uint16_t)adc_val * (uint16_t)adc_val) >> 6);

    updateInput(&halt_pin, &currentHaltState, NULL); // we don't care about the previous state for this so NULL is passed inplace

    if (currentHaltState ^ !HALT_PIN_POLARTIY)
    { // if halt is active
      // 0 ^ !0 = 0 ^ 1 = 1
      // 1 ^ !0 = 1 ^ 1 = 0
      // generate 50% duty cycle clock
      step_clock();
      delay(pulseTime + MIN_PULSE_TIME);
    }
    else // halt inactive
    {
      updateInput(&step_pin, &currentStepState, &previousStepState);
      if (!(previousStepState ^ !STEP_PIN_POLARITY) && (currentStepState ^ !STEP_PIN_POLARITY))
      {
        // a valid rising edge
        // gnerate a single clock pulse
        step_clock();
        previousStepState = currentStepState;
      }
    }
  }
  return 0;
}