//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract SparePart {
    address payable public customerSparePartAddress;

    mapping(string => string) public sparePartType;
    mapping(string => uint) public sparePartPrice;
    mapping(string => uint) public sparePartStock;

    constructor(){
        sparePartType['P01'] = "Brake Pad";
        sparePartType['P02'] = "Disc Brake";
        sparePartType['P03'] = "Cluth Cable";
        sparePartType['P04'] = "Front Bulp Lamp";
        sparePartType['P05'] = "Rear Bulp Lamp";
        sparePartType['P06'] = "Tubeless Tyre";
        sparePartType['P07'] = "Handgrip";
        sparePartType['P08'] = "Copper Spark Plug";
        sparePartType['P09'] = "Iridium Spark Plug";
        sparePartType['P10'] = "Accu";
        sparePartType['P11'] = "Horn";

        sparePartPrice['P01'] = 100000 wei;
        sparePartPrice['P02'] = 300000 wei;
        sparePartPrice['P03'] = 200000 wei;
        sparePartPrice['P04'] = 7000 wei;
        sparePartPrice['P05'] = 6000 wei;
        sparePartPrice['P06'] = 450000 wei;
        sparePartPrice['P07'] = 22000 wei;
        sparePartPrice['P08'] = 25000 wei;
        sparePartPrice['P09'] = 85000 wei;
        sparePartPrice['P10'] = 275000 wei;
        sparePartPrice['P11'] = 115000 wei;

        sparePartStock['P01'] = 50;
        sparePartStock['P02'] = 25;
        sparePartStock['P03'] = 10;
        sparePartStock['P04'] = 100;
        sparePartStock['P05'] = 100;
        sparePartStock['P06'] = 15;
        sparePartStock['P07'] = 15;
        sparePartStock['P08'] = 75;
        sparePartStock['P09'] = 100;
        sparePartStock['P10'] = 50;
        sparePartStock['P11'] = 20;
    }

    /*
        check type
    */
    modifier checkSparePartType (string memory _part){
        require(sparePartPrice[_part] != 0, string(abi.encodePacked("Invalid sparepart type ", _part)));
         _;
    }

    /*
        check the stock of sparepart
    */
    modifier cekSparePartStock (string memory _part, uint _quantity) {
        require(sparePartStock[_part] != 0 && sparePartStock[_part] >= _quantity, string(abi.encodePacked("Sorry the stock of ", sparePartType[_part], " unavailable")));
        _;
    }

    /*
        check the sparepart price
    */
    modifier cekSparePartPrice (string memory _part, uint _quantity) {
        require(msg.value >= (sparePartPrice[_part] * _quantity), 
            string(abi.encodePacked("Sorry! Insufficient money to buy spare part ", sparePartType[_part])));
        _;
    }

    /*
        only customer allowed to do transaction
    */
    modifier checkCustomerSparePartAddress (address payable _dealerOwnerAddress, address payable _customerSparePartAddress){
     customerSparePartAddress = _customerSparePartAddress;
        require(_customerSparePartAddress != _dealerOwnerAddress, "Owner unable to transact! Only customer allowed!");
         _;
    }
}
