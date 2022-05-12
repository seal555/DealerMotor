//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract ServiceAndMaintenance {
    enum StatusBookingService {BOOKED, NOT_BOOKED}
    StatusBookingService bookingService;

    uint biayaService = 250000 wei;

    constructor(){
        bookingService = StatusBookingService.NOT_BOOKED;
    }

    /*
        modifier cek status booking service
    */
    modifier cekStatusBookingService () {
        require(bookingService == StatusBookingService.NOT_BOOKED, "Anda sudah melakukan booking service");
        _;
    }

    /*
        modifier biaya service
    */
    modifier cekBiayaService (uint _biaya) {
        require(_biaya >= biayaService, "Uang Anda tidak cukup untuk membayar biaya service!");
        _;
    }
}
