//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

import "./Owner.sol";
import "./Sales.sol";
import "./SparePart.sol";
import "./ServiceAndMaintenance.sol";

contract MotorCycleDealer is Owner, Sales, SparePart, ServiceAndMaintenance{

    constructor(){ }

    // SALES
    //////////////////////////////////////////////////////////////////////////////////////////////
    /*
        function for booking new motorcycle unit, booking fee applied
    */
    function bookingNewMotorcycleUnit() payable external checkCustomerSalesAddress(dealerOwnerAddress, msg.sender) checkTheBookingStatus() checkTheBookingFee(msg.value){
        bookingUnitStatus = MotorcycleSalesBookingStatus.YES;
        dealerOwnerAddress.transfer(bookingFee);

        // handle change if value larger than booking fee
        uint excessMoney = msg.value - bookingFee;
        sendRefund(msg.sender, excessMoney);

        emit recordTransaction(msg.sender, bookingFee);
    }

    /*
        function to buy a brand new motorcyle unit, example price is 10.000.000 WEI
        if booking first, customer only need to pay 9.000.000 WEI
        if without booking, customer need to pay at full price 10.000.000 WEI
    */
    function buyNewMotorCycleUnit(string memory _motorCycleType) payable external checkCustomerSalesAddress(dealerOwnerAddress, msg.sender) checkMotorcycleType(_motorCycleType) checkMotorcycleStock(_motorCycleType) checkTheMotorcyclePrice(msg.value, _motorCycleType) {
        // handle refund if value larger than motorcyle price
        uint excessMoney = 0;

        if(bookingUnitStatus == MotorcycleSalesBookingStatus.YES){
            // update booking status
            bookingUnitStatus = MotorcycleSalesBookingStatus.NO;

            uint remainingPrice = motorCycleFullPrice[_motorCycleType] - bookingFee;

            dealerOwnerAddress.transfer(remainingPrice);
            
            if(msg.value > remainingPrice) excessMoney = msg.value - (remainingPrice); 
        }
        else{
            dealerOwnerAddress.transfer(motorCycleFullPrice[_motorCycleType]);
            excessMoney = msg.value - motorCycleFullPrice[_motorCycleType];
        }  

        // sent back excess money to buyer if occurred
        sendRefund(msg.sender, excessMoney);

        // update the stock
        motorCycleStock[_motorCycleType] -= 1;
        
        emit recordTransaction(msg.sender, motorCycleFullPrice[_motorCycleType]);
    }

    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////


    // SPAREPARTS
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*
        function to buy sparepart
    */
    function buySparePart(string memory _partType, uint _quantity) payable external checkCustomerSparePartAddress(dealerOwnerAddress, msg.sender) 
        checkSparePartType(_partType) 
        cekSparePartStock(_partType, _quantity) 
        cekSparePartPrice(_partType, _quantity) {

        uint totalPrice = sparePartPrice[_partType] * _quantity;
        dealerOwnerAddress.transfer(totalPrice);

        // handle refund if value larger than sparepart price
        uint excessMoney = 0;
        if(msg.value > totalPrice) excessMoney = msg.value - (totalPrice);
        // sent back excess money to buyer if occurred
        sendRefund(msg.sender, excessMoney);

        // update the stock
        sparePartStock[_partType] -= _quantity;

        emit recordTransaction(msg.sender, totalPrice);
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    /*
        function to send back the excess/change money to customer if occure
    */
    function sendRefund(address payable _customerAddress, uint _value) payable public {
        if(_value > 0) _customerAddress.transfer(_value);
    }

    /*
        event to record any successful transaction
    */
    event recordTransaction(address _customerAddress, uint _value);
}
