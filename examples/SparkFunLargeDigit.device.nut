//Copy in code from TPIC5C596.class.nut

//Example Conducted on an IMP004m

function entry() {
    largeDigitDriver <- TPIC5C596(hardware.pinE, hardware.pinM, hardware.pinA);
    agent.on("updateBigLed", largeDigitDriver.displayNumber.bindenv(digit));
}

// Start Process
entry();