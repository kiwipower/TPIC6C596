# TPIC6C596
Electric Imp compatible driver for the TPIC6C596 - used in the SparkFun Large Digit Driver

Based on the code and examples found at: https://learn.sparkfun.com/tutorials/large-digit-driver-hookup-guide?_ga=2.55402536.200087887.1528884570-211908983.1528884570

We have simply converted the example code into Squirrel, note that you will have to use a level shifter from 3.3V to 5V for this driver.

We have used this Driver to create a fun Display Board in our office. We hope you will find this code useful.

This class has one main function and a test function.

## displayNumber(*number,numberOfDrivers*)

displayNumber will send a number to the Digit Drivers dependant on the numberOfDrivers you have added into the chain.

```squirrel
    //Hardware Pins related to the Imp004m
    const numberOfDrivers = 3;
    largeDigitDriver <- TPIC5C596(hardware.pinE, hardware.pinM, hardware.pinA);
    agent.on("updateSign", largeDigitDriver.displayNumber.bindenv(digit,numberOfDrivers)); 
```

## demoCounter(numberOfDrivers)

demoCounter will count up the digits from 0 -> (10^numberOfDrivers). The speed of the counting is also defined by the number of drivers in use.


Simply call this function to test your equipment.

# License

The PN532 library is licensed under the [MIT License](./LICENSE).