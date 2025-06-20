# Buffered GPIO
This module enables the user to give a series of values as input or output through the gpio pins. The gpio pins are combined as different groups as 2,4,8 buffer groups depending on the data size. Each buffer group has a clock pin associated with it. The data values for a group can be sampled either using an external clock fed at its clock pin or internal clock generated at the clock pin.

## Buffer Grouping
   | Number of Data pins in Buffer group | Clock GPIO |Data GPIOs|Usage|
   |:---:|:---:|:---:|:---:|
   |Two|5|3,4| Only used in BGA144 and QFN64 with internal flash packages |
   |Four|6|11,15,18,22|Used in all packages|
   |Eight|7| 1,2,8,9,14,16,17,31 |Not possible in QFN48, QFN32 packages|


The buffer added to the module which stores the gpio pin data enables this functionality.Each group has a buffer of its own. The buffers have a depth of 16.

The gpio is connected with a 32 bit axi4lite system bus. The buffer has a depth of 16. Depending on the axi request size, upto 16 entries can be enqueued into the 2 buffer in one cycle (16 entries x 2 bits each = 32 bit axi4lite bus), 8 entries for 4 buffer and 4 entries for the 8 buffer. 

Similarly when receiving external inputs from the gpio pins, the data gets enqueued into the buffer one by one. While reading data out from the buffer , depending on the axi request size upto 16 entries can be dequeued and read from the 2 buffer in one cycle, 8 entries for 4 buffer and 4 entries for the 8 buffer.

The successive buffer entries will be placed sequentially in the 32 bit axi bus.

There is a separate address space to write and read the 8 and 4 buffers combined as a 12 bit data. The 8 buffer will store the lsb 8 bits and the 4 buffer will store the msb 4 bits of any combined 12 bit data sent or received through axi.

### Buffer control register
|Bit position|Field|Use|
|:---:|:---|:---|
|0|Buffer 2 Enable| **1** -> 2 Bit buffer **enabled** ; **0** -> 2 Bit buffer **disabled**|
|1|Buffer 4 Enable| **1** -> 4 Bit buffer **enabled** ; **0** -> 4 Bit buffer **disabled**|
|2|Buffer 8 Enable| **1** -> 8 Bit buffer **enabled** ; **0** -> 8 Bit buffer **disabled**|
|3|Buffer 2 Clock Select|**0** -> Buffer 2 operates on **internal** clock ; **1** -> Buffer 2 operates on **external** clock received through gpio pin 5|
|4|Buffer 4 Clock Select|**0** -> Buffer 4 operates on **internal** clock ; **1** -> Buffer 4 operates on **external** clock received through gpio pin 6|
|5|Buffer 8 Clock Select|**0** -> Buffer 8 operates on **internal** clock ; **1** -> Buffer 8 operates on **external** clock received through gpio pin 7|
|6|Buffer 2 Clock Edge Select| **0** -> Buffer 2 enqueues and dequeues on **positive** edge of selected clock  ;  **1** -> Buffer 2 enqueues and dequeues on **negative** edge of selected clock|
|7|Buffer 4 Clock Edge Select| **0** -> Buffer 4 enqueues and dequeues on **positive** edge of selected clock  ;  **1** -> Buffer 4 enqueues and dequeues on **negative** edge of selected clock|
|8|Buffer 8 Clock Edge Select| **0** -> Buffer 8 enqueues and dequeues on **positive** edge of selected clock  ;  **1** -> Buffer 8 enqueues and dequeues on **negative** edge of selected clock|
|9|buffer 2 direction| 0 -> buffer 2 enqueue from GPIO is enabled ; 1 -> buffer 2 dequeue to GPIO enabled |
|10|buffer 4 direction| 0 -> buffer 4 enqueue from GPIO is enabled ; 1 -> buffer 4 dequeue to GPIO enabled |
|11|buffer 8 direction| 0 -> buffer 8 enqueue from GPIO is enabled ; 1 -> buffer 8 dequeue to GPIO enabled |
|12|buffer 2 clear|Clears buffer 2 data and makes the buffer empty|
|13|buffer 4 clear|Clears buffer 4 data and makes the buffer empty|
|14|buffer 8 clear|Clears buffer 8 data and makes the buffer empty|
|15|buffer 2 data check| Size for data availability check in buffer 2 ; 00 -> not checking for any data ; 01 -> checking for 8 bits send or receive ; 10 -> checking for 16 bits send or receive ; 11 -> checking for 32 bits send or receive|
|16|buffer 4 data check| Size for data availability check in buffer 4 ; 00 -> not checking for any data ; 01 -> checking for 8 bits send or receive ; 10 -> checking for 16 bits send or receive ; 11 -> checking for 32 bits send or receive|
|17|buffer 8 data check| Size for data availability check in buffer 8 ; 00 -> not checking for any data ; 01 -> checking for 8 bits send or receive ; 10 -> checking for 16 bits send or receive ; 11 -> checking for 32 bits send or receive|
|18|buffer 12 data check| Size for data availability check in buffer 4 and 8 combined as one ; 00 -> not checking for any data ; 01 -> checking for 8 bits send or receive ; 10 -> checking for 16 bits send or receive ; 11 -> checking for 32 bits send or receive|

### Buffer status register
|Bit position|Field|Use|
|:---:|:---|:---|
|0|buffer2 Not Full|Stores 1 if there is space in buffer2 for an enqueue ; 0 if buffer is full|
|1|buffer2 Not Empty|Stores 1 if there is an element to dequeue in buffer2 ; 0 if buffer is empty|
|2|buffer4 Not Full|Stores 1 if there is space in buffer4 for an enqueue ; 0 if buffer is full|
|3|buffer4 Not Empty|Stores 1 if there is an element to dequeue in buffer2 ; 0 if buffer is empty|
|4|buffer8 Not Full|Stores 1 if there is space in buffer8 for an enqueue ; 0 if buffer is full|
|5|buffer8 Not Empty|Stores 1 if there is an element to dequeue in buffer2 ; 0 if buffer is empty|
|6|buffer 2 can take input for dma|Stores 1 if there is space available in buffer 2 for the size requested by dma, else stores 0|
|7|buffer 2 output ready for dma|Stores 1 if there is data available in buffer 2 for the size requested by dma, else stores 0|
|8|buffer 4 can take input for dma|Stores 1 if there is space available in buffer 4 for the size requested by dma, else stores 0|
|9|buffer 4 output ready for dma|Stores 1 if there is data available in buffer 4 for the size requested by dma, else stores 0|
|10|buffer 8 can take input for dma|Stores 1 if there is space available in buffer 8 for the size requested by dma, else stores 0|
|11|buffer 8 output ready for dma|Stores 1 if there is data available in buffer 8 for the size requested by dma, else stores 0|
|12|buffer 12 can take input for dma|Stores 1 if there is space available in buffer 4 and 8 combined for the size requested by dma, else stores 0|
|13|buffer 12 output ready for dma|Stores 1 if there is data available in buffer 4 and 8 combined for the size requested by dma, else stores 0|


**<ins>Note :** DMA can send or receive data to the buffers only if there is space available in the buffer. Hence Buffered GPIO can make full use of DMA only if the DMA data is being enqueued or dequeued parallely from/to external peripheral continously.

![gpio_buffered_structure](https://github.com/user-attachments/assets/ca398264-fe41-4572-baab-a30e18f55754)
