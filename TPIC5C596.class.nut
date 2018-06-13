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



/**
 *  Program to update 3 digit LED, Only integer numbers are currently
 *  supported.
 *
 */

//
// LED constants
//
const a  = 0x01;
const b  = 0x40;
const c  = 0x20;
const d  = 0x10;
const e  = 0x08;
const f  = 0x02;
const g  = 0x04;
const dp = 0x80;

// Digit LED pattern
local lookup = {}
lookup[0] <- (a | b | c | d | e | f);
lookup[1] <- (b | c);
lookup[2] <- (a | b | d | e | g);
lookup[3] <- (a | b | c | d | g);
lookup[4] <- (f | g | b | c);
lookup[5] <- (a | f | g | c | d);
lookup[6] <- (a | f | g | e | c | d);
lookup[7] <- (a | b | c);
lookup[8] <- (a | b | c | d | e | f | g);
lookup[9] <- (a | b | c | d | f | g);

class TPIC5C596 {
    dataPin = null;
    clockPin = null;
    latchPin = null;

    constructor (latch, clock, data) {
        server.log("calling TPIC5C596 constructor")
        latchPin = latch;
        clockPin = clock;
        dataPin  = data;

        latchPin.configure(DIGITAL_OUT, 0);
        clockPin.configure(DIGITAL_OUT, 0);
        dataPin.configure(DIGITAL_OUT, 0);

        displayNumber(0);
    }

    function writeDigit(number) {
        local segments = lookup[number];
        if ( (number >= 0) && (number <= 9) ) {
            for ( local i = 0; i < 8; i++) {
                clockPin.write(0);
                dataPin.write(segments & (1 << ( 7 - i )))
                clockPin.write(1);
            }
        }
        //server.log(format("segments: 0x%02X", segments));
    }

//display number as 3 digit decimal value
    function displayNumber(number,numberOfDrivers) {
        local remainder;

        for (local i = 0 ; i < numberOfDrivers ; i++) {
            remainder = number % 10;

            writeDigit(remainder);

            number /= 10;
        }
        //Latch the current segment data
        latchPin.write(0);
        latchPin.write(1);
    }

    function demoCounter(numberOfDrivers) {
        for ( local i = 0; ; i++  ) {
            digit.displayNumber(i,numberOfDrivers);
            imp.sleep(1/numberOfDrivers);
            if ( i == math.pow(10,numberOfDrivers) ) {
                i = -1;
            }
        }
    }
};