#include <avr/io.h>
#include <util/delay.h>
#include <avr/wdt.h>
#include <gpio.h>

#define USR_SW_PIN_POLARITY 1 // value to consider active
#define DEBOUNCE_TIME 20      // ms
#define RST_DELAY 500         // ms, time after assertion of valid reset trigger
#define RST_PULSE 50          // ms

#define USR_SW_PIN GPIO_PB2
#define RST_PIN GPIO_PB1

// -------- Globals --------- //
uint8_t previousSwState = 1; // inactive
uint8_t currentSwState = 0;  // active

// -------- Functions --------- //

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
  GPIO_TypeDef sw_pin = USR_SW_PIN;
  GPIO_TypeDef rst_pin = RST_PIN;

  _delay_ms(RST_DELAY);
  GPIO_setOutput(&rst_pin);
  _delay_ms(RST_PULSE);
  GPIO_setInput(&rst_pin);

  GPIO_setValueHigh(&sw_pin); // input pullups enabled

  // -------- Event Loop--------- //
  for (;;)
  {
    updateInput(&sw_pin, &currentSwState, &previousSwState);
    if (!(!!previousSwState ^ !USR_SW_PIN_POLARITY) && (!!currentSwState ^ !USR_SW_PIN_POLARITY))
    {
      // a valid rising edge
      wdt_enable(WDTO_15MS); // enable the WDT to create a reset
      for (;;)
      {
        // loop until reset occurs
      }
    }
  }

  return 0;
}