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

// Number of digits
const numberOfDigit = 3;

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
    function displayNumber(number) {
        local remainder;

        for (local i = 0 ; i < numberOfDigit ; i++) {
            remainder = number % 10;

            writeDigit(remainder);

            number /= 10;
        }
        //Latch the current segment data
        latchPin.write(0);
        latchPin.write(1);
    }

    function demoCounter() {
        for ( local i = 0; ; i++  ) {
            digit.displayNumber(i);
            imp.sleep(0.5);
            if ( i == 1000 ) {
                i = -1;
            }
        }
    }
};