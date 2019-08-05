# MSP430-ADF4351

- 简单测试了一下通过SPI向ADF4351中写控制字
- 移植过程中出现了很多问题，主要就是memcpy和移位出现的问题，由于ESP32是32位而MSP430FR5994是16位单片机，MSP430一个int是两个字节，在移位的过程中如果移位长度超过8位就会溢出。所以要进行如下修改

```c++
修改前：
unsigned long r4 = (_feedbackType << 23) + // divided/fundamental feedback
    (_divider << 20) + // RF divider
    (200 << 12) + // band select clock divider
    (0 << 9) + // vco powerdown = false; MTLD = 1; aux output = divided;
    (_auxEnabled << 8) + // AUX OUTPUT enable/disable
    (_auxPower << 6) + // aux output power = {-4, -1, 2, 5dbm}
    (_rfEnabled << 5) + // RF OUTPUT ENABLED
    (_rfPower << 3) + // RF output power = 5dbm
    4;  // register select
    
修改后：
unsigned long r4 = ((unsigned long)_feedbackType << 23) + // divided/fundamental feedback
        ((unsigned long)_divider << 20) + // RF divider
        ((unsigned long)200 << 12) + // band select clock divider
        ((unsigned long)0 << 9) + // vco powerdown = false; MTLD = 1; aux output = divided;
        ((unsigned long)_auxEnabled << 8) + // AUX OUTPUT enable/disable
        ((unsigned long)_auxPower << 6) + // aux output power = {-4, -1, 2, 5dbm}
        ((unsigned long)_rfEnabled << 5) + // RF OUTPUT ENABLED
        ((unsigned long)_rfPower << 3) + // RF output power = 5dbm
        (unsigned long)4;  // register select
    _r4=r4;
```

强制类型转换一下就可以了