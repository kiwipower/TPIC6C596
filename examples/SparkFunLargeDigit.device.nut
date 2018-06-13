function entry() {
    digit <- BigLEDSign(hardware.pinE, hardware.pinM, hardware.pinA);
    agent.on("updateBigLed", digit.displayNumber.bindenv(digit));
}

// run BigLED
entry();