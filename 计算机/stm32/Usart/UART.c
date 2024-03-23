#include "UART.h"
/*----------use the UTF-8-------------*/


/**
 * @brief  串口初始化及配置
 * @param {None}
 * @retval None
 */
void USART_Config(void)
{
    GPIO_InitTypeDef UART_GPIO_TX_InitStruct,UART_GPIO_RX_InitStruct;
    USART_InitTypeDef USART_InitStruct;

    //打开时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC,ENABLE);
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_UART4,ENABLE);

    //GPIO初始化,USART_TX_Pin
    UART_GPIO_TX_InitStruct.GPIO_Pin = DEBUG_USART_TX_GPIO_PIN;
    UART_GPIO_TX_InitStruct.GPIO_Mode = GPIO_Mode_AF_PP;
    UART_GPIO_TX_InitStruct.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(DEBUG_USART_TX_GPIO_PORT, &UART_GPIO_TX_InitStruct);

    //GPIO初始化,USAER_RX_Pin
    UART_GPIO_RX_InitStruct.GPIO_Pin = DEBUG_USART_RX_GPIO_PIN;
    UART_GPIO_RX_InitStruct.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    UART_GPIO_RX_InitStruct.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(DEBUG_USART_RX_GPIO_PORT,&UART_GPIO_RX_InitStruct);

    //波特率115200
    USART_InitStruct.USART_BaudRate = 115200;
    //指定字长
    USART_InitStruct.USART_WordLength = USART_WordLength_8b;
    //停止位
    USART_InitStruct.USART_StopBits = USART_StopBits_1;
    //校验位
    USART_InitStruct.USART_Parity = USART_Parity_No;
    //串口模式使能
    USART_InitStruct.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    USART_InitStruct.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    //根据结构体的配置初始化串口
    USART_Init(DEBUG_USARTx,&USART_InitStruct);

    //启用`接收数据寄存器不为空`中断, 用于接受上位机发送来的数据，具体见中断服务函数中  
    USART_ITConfig(DEBUG_USARTx, USART_IT_RXNE, ENABLE);
    //打开UART4
    USART_Cmd(DEBUG_USARTx,ENABLE);
}

/**
 * @brief  配置嵌套向量中断控制器(控制着整个芯片中断相关的功能)
 * @param {None}
 * @retval 
 */
void NVIC_USART_Config(void)
{
    NVIC_InitTypeDef NVIC_USART_InitStruct;
    //设置优先级组
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);

    //中断源选择
    NVIC_USART_InitStruct.NVIC_IRQChannel = UART4_IRQn;
    //指定中断源的抢占优先级
    NVIC_USART_InitStruct.NVIC_IRQChannelPreemptionPriority = 1;
    //指定中断源的子优先级
    NVIC_USART_InitStruct.NVIC_IRQChannelSubPriority = 1;
    //中断使能
    NVIC_USART_InitStruct.NVIC_IRQChannelCmd = ENABLE;
    //根据结构体初始化NVIC
    NVIC_Init(&NVIC_USART_InitStruct);
}

/**
 * @brief  单片机发送字节
 * @param {USART_TypeDef *} pUSARTx 
 * @param {uint8_t} byte 
 * @retval 
 */
void USART_SendByte(USART_TypeDef * pUSARTx, uint8_t byte)
{
    USART_SendData(DEBUG_USARTx,byte);
    //等待`Transmit data register empty flag`设置,即等待数据发送完毕
    while(USART_GetFlagStatus(DEBUG_USARTx,USART_FLAG_TXE) == RESET){
    }
}

/**
 * @brief  单片机发送字符串
 * @param {USART_TypeDef *} pUSARTx 
 * @param {char *} str 
 * @retval 
 */
void USART_SendString(USART_TypeDef * pUSARTx, char * str)
{
    uint32_t k = 0;
    do
    {
        USART_SendData( DEBUG_USARTx, *(str+k) );
        //等待`Transmit data register empty flag`设置,即等待数据发送完毕
        while(USART_GetFlagStatus(DEBUG_USARTx,USART_FLAG_TXE) == RESET){
        }
        k++;
    } while (*(str+k) != '\0');
    //等待传输完成标志设置
    while(USART_GetFlagStatus(DEBUG_USARTx,USART_FLAG_TC) == RESET){
    }
}

/**
 * @brief  发送半字
 * @param {USART_TypeDef *} pUSARTx 
 * @param {uint16_t} ch 
 * @retval 
 */
void Usart_SendHalfWord( USART_TypeDef * pUSARTx, uint16_t ch)
{
	uint8_t temp_h, temp_l;
	
    //高8位
	temp_h = (ch&0XFF00)>>8;
    //低8位
	temp_l = ch&0XFF;
	
	USART_SendData(pUSARTx,temp_h);	
	while (USART_GetFlagStatus(pUSARTx, USART_FLAG_TXE) == RESET);
	
	USART_SendData(pUSARTx,temp_l);	
	while (USART_GetFlagStatus(pUSARTx, USART_FLAG_TXE) == RESET);	
}

int __io_putchar(int ch) {
    USART_SendByte(DEBUG_USARTx, ch);
    return ch;
}

int _write(int file, char *ptr, int len) {
    int DataIdx;
    for (DataIdx = 0; DataIdx < len; DataIdx++) {
        __io_putchar(*ptr++);
    }
    return len;
}













