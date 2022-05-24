//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract Sales {
    address payable public customerSalesAddress;

    enum MotorcycleSalesBookingStatus {YES, NO}
    MotorcycleSalesBookingStatus public bookingUnitStatus;

    uint public bookingFee = 1000000 wei;

    mapping(string => string) public motorCycleType;
    mapping(string => uint) public motorCycleFullPrice;
    mapping(string => uint) public motorCycleStock;

    constructor(){
        bookingUnitStatus = MotorcycleSalesBookingStatus.NO;

        motorCycleType['M01'] = "Scooter";
        motorCycleType['M02'] = "Naked Bike";
        motorCycleType['M03'] = "SuperSport";

        motorCycleFullPrice['M01'] = 10000000 wei;
        motorCycleFullPrice['M02'] = 15000000 wei;
        motorCycleFullPrice['M03'] = 20000000 wei;

        motorCycleStock['M01'] = 10;
        motorCycleStock['M02'] = 10;
        motorCycleStock['M03'] = 10;
    }

    /*
        booking fee 1.000.000 wei for all type of motorcycle
    */
    modifier checkTheBookingFee (uint _fee) {
        require(_fee >= bookingFee, "Insufficient booking fee, minimum of 1.000.000 WEI");
        _;
    }

    /*
        check booking status
    */
    modifier checkTheBookingStatus () {
        require(bookingUnitStatus == MotorcycleSalesBookingStatus.NO, "You already booked a new motorcycle, transaction can't be proceed");
        _;
    }

    /*
        check type
    */
    modifier checkMotorcycleType (string memory _motorCycleType){
        require(motorCycleFullPrice[_motorCycleType] != 0, string(abi.encodePacked("Invalid motorcycle type ", _motorCycleType)));
         _;
    }

    /*
        full motorcyle example price is 10.000.000 WEI
        motorcyle example price with booking fee (10.000.000 WEI - 1.000.000 WEI = 9.000.000 WEI)
    */
    modifier checkTheMotorcyclePrice (uint _fee, string memory _motorCycleType) {
        require((bookingUnitStatus == MotorcycleSalesBookingStatus.YES && _fee >= (motorCycleFullPrice[_motorCycleType] - bookingFee)) 
        || (bookingUnitStatus == MotorcycleSalesBookingStatus.NO && _fee >= motorCycleFullPrice[_motorCycleType]), "Sorry! Insufficient money to buy a new motorcyle!");
        _;
    }

    /*
        check stock availability
    */
    modifier checkMotorcycleStock (string memory _motorCycleType){
        require(motorCycleStock[_motorCycleType] > 0, string(abi.encodePacked("Sorry the stock of ", motorCycleType[_motorCycleType], " unavailable")));
         _;
    }

    /*
        only customer allowed to do transaction
    */
    modifier checkCustomerSalesAddress (address payable _dealerOwnerAddress, address payable _customerSalesAddress){
     customerSalesAddress = _customerSalesAddress;
        require(_customerSalesAddress != _dealerOwnerAddress, "Owner unable to transact! Only customer allowed!");
         _;
    }
}
