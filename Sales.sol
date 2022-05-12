//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract Sales {
    enum StatusBookingMotor {YES, NO}
    StatusBookingMotor bookingMotor;

    uint biayaBooking = 1000000 wei;
    uint hargaMotor = 10000000 wei;

    constructor(){
        bookingMotor = StatusBookingMotor.NO;
    }

     /*
        biaya booking sebesar 1.000.000 wei
    */
    modifier cekBiayaBooking (uint _biaya) {
        require(_biaya >= biayaBooking, "Uang booking tidak cukup, minimal 1.000.000 WEI");
        _;
    }

    /*
        harga motor normal sebesar 10.000.000 WEI
        harga motor dengan booking sebesar 10.000.000 WEI - 1.000.000 WEI = 9.000.000 WEI
    */
    modifier cekHargaMotor (uint _uang) {
        require((bookingMotor == StatusBookingMotor.YES && _uang >= (hargaMotor - biayaBooking)) 
        || (bookingMotor == StatusBookingMotor.NO && _uang >= hargaMotor), "Uang Anda tidak cukup untuk membeli motor");
        _;
    }
}
