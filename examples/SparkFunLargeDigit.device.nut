//Copy in code from TPIC5C596.class.nut

/**Example Conducted on an IMP004m
 * Using 3 SparkFun Large Digit Drivers and Large 7 segment LEDs
 * */

function entry() {
    largeDigitDriver <- TPIC5C596(hardware.pinE, hardware.pinM, hardware.pinA);
    agent.on("updateBigLed", largeDigitDriver.displayNumber.bindenv(digit,numberOfDrivers));
}

//Change according to number of LED drivers you ar using
const numberOfDrivers = 3;

// Start Process
entry();