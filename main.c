#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN 7
#define BUTTON 4


int main(void)
{
    DDRD |= 1 << LED_PIN;   
    DDRD &= ~(1 << BUTTON); 
    PORTD |= 1 << BUTTON;   

    while(1)
    {
          if ((PIND & (1 << BUTTON)))
          {
            PORTD |= 1 << LED_PIN; 
          }
          else
          {
            PORTD &= ~(1 << LED_PIN); 
          }
    }
}
