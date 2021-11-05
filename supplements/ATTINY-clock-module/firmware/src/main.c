#include <avr/io.h>
#include <util/delay.h>
#include <stddef.h>
#include <gpio.h>

#define ADJ_ADC_PIN MUX1    //
#define HALT_PIN_POLARTIY 0 // value to consider active
#define STEP_PIN_POLARITY 0 // value to consider active
#define DEBOUNCE_TIME 20    // ms
#define MIN_PULSE_TIME 1    // ms

#define HALT_PIN GPIO_PB3
#define STEP_PIN GPIO_PB2
#define CLK_PIN GPIO_PB1

// -------- Globals --------- //
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

int main(void)
{
  GPIO_TypeDef halt_pin = HALT_PIN;
  GPIO_TypeDef step_pin = STEP_PIN;
  GPIO_TypeDef clk_pin = CLK_PIN;

  // Configure all the IOs
  GPIO_setOutput(&clk_pin);     // configured as output
  GPIO_setValueHigh(&step_pin); // input pullups enabled
  GPIO_setValueHigh(&halt_pin);
  // Vcc as ref, ADC2 as input, left adjust result (8 bit mode)
  ADMUX |= (1 << ADJ_ADC_PIN) | (1 << ADLAR);
  // enable ADC, start conversion, auto trigger enable, 128 prescaler
  ADCSRA |= (1 << ADEN) | (1 << ADSC) | (1 << ADATE) | (1 << ADPS0) | (1 << ADPS1) | (1 << ADPS2);
  // ADCSRB already configured for free running modecc
  DIDR0 |= (1 << ADC2D); // disable the digital input buffer for the ADC pin
  // -------- Event Loop--------- //
  for (;;)
  {
    uint8_t adc_val = ADCH; // get the 8 bit adc result and left shift by 1
    uint16_t pulseTime = (((uint16_t)adc_val * (uint16_t)adc_val) >> 6);

    updateInput(&halt_pin, &currentHaltState, NULL); // we don't care about the previous state for this so NULL is passed inplace

    if (!!currentHaltState ^ !HALT_PIN_POLARTIY)
    { // if halt is active
      // 0 ^ !0 = 0 ^ 1 = 1
      // 1 ^ !0 = 1 ^ 1 = 0
      // generate 50% duty cycle clock
      GPIO_setValueHigh(&clk_pin);
      delay(pulseTime + MIN_PULSE_TIME);
      GPIO_setValueLow(&clk_pin);
      delay(pulseTime + MIN_PULSE_TIME);
    }
    else // halt inactive
    {
      updateInput(&step_pin, &currentStepState, &previousStepState);
      if (!(!!previousStepState ^ !STEP_PIN_POLARITY) && (!!currentStepState ^ !STEP_PIN_POLARITY))
      {
        // a valid rising edge
        // gnerate a single clock pulse
        GPIO_setValueHigh(&clk_pin);
        _delay_ms(MIN_PULSE_TIME);
        GPIO_setValueLow(&clk_pin);
        _delay_ms(MIN_PULSE_TIME);
        previousStepState = currentStepState;
      }
    }
  }

  return 0;
}