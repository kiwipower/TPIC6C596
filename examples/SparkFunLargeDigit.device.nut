//MIT License
//
//Copyright [2018] KiWi Power Ltd.
//
//SPDX-License-Identifier: MIT
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be
//included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
//EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
//OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//OTHER DEALINGS IN THE SOFTWARE.

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