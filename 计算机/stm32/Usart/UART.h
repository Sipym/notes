#ifndef __UART_H__
#define __UART_H__

#include "stm32f10x.h"

//串口UART4宏定义
#define DEBUG_USARTx                UART4
#define DEBUG_USART_CLK             RCC_APB1Periph_UART4
#define DEBUG_USART_BAUDRATE        115200

//UART4 GPIO引脚宏定义
#define DEBUG_USART_GPIO_CLK        RCC_APB2Periph_GPIOC
#define DEBUG_USART_TX_GPIO_PIN     GPIO_Pin_10
#define DEBUG_USART_TX_GPIO_PORT    GPIOC
#define DEBUG_USART_RX_GPIO_PIN     GPIO_Pin_11
#define DEBUG_USART_RX_GPIO_PORT    GPIOC


//函数声明

void USART_Config(void);
void NVIC_USART_Config(void);
void USART_SendByte(USART_TypeDef * pUSARTx, uint8_t byte);
void USART_SendString(USART_TypeDef * pUSARTx, char * string);
int __io_putchar(int ch);
int _write(int file, char *ptr, int len);
extern int printf (const char *__restrict __format, ...);
#endif
