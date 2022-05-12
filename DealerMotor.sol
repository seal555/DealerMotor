//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

import "./Owner.sol";
import "./Sales.sol";
import "./SparePart.sol";
import "./ServiceAndMaintenance.sol";

contract DealerMotor is Owner, Sales, SparePart, ServiceAndMaintenance{

    constructor(){ }

    // PENJUALAN
    //////////////////////////////////////////////////////////////////////////////////////////////
    /*
        fungsi untuk melakukan booking unit motor baru, dikenakan biaya booking 
    */
    function bookingUnitMotor() payable external cekBiayaBooking(msg.value) {
        bookingMotor = StatusBookingMotor.YES;
        ownerDealer.transfer(msg.value);
    }

    /*
        fungsi untuk melakukan pembelian unit motor baru, seharga 10.000.000 WEI
        jika dengan booking maka harga 9.000.000 WEI
        jika tanpa booking maka harga full 10.000.000 WEI
    */
    function beliUnitMotor() payable external cekHargaMotor(msg.value){
        if(bookingMotor == StatusBookingMotor.YES){
            ownerDealer.transfer(hargaMotor - biayaBooking);
            bookingMotor = StatusBookingMotor.NO;
        }
        else{
            ownerDealer.transfer(hargaMotor);
        }  
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////


    // SPAREPARTS
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*
        fungsi untuk melakukan pembelian sparepart
    */
    function beliSparePart(string memory _part) payable external cekSparepart(_part) {
        ownerDealer.transfer(spareparts[_part]);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////


    // SERVICE & MAINTENANCE
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////   
    /*
        fungsi untuk melakukan booking service, tidak ada biaya (gratis) 
    */
    function bookingServiceMotor() payable external cekStatusBookingService() {
        bookingService = StatusBookingService.BOOKED;
    }

    /*
        fungsi untuk melakukan pembayaran biaya service
    */
    function bayarServiceMotor() payable external cekBiayaService(msg.value) {
        bookingService = StatusBookingService.NOT_BOOKED;
        ownerDealer.transfer(msg.value);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
}
