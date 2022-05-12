//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract SparePart {
    mapping(string => uint) spareparts;

    constructor(){
        spareparts['Kanvas Rem Cakram'] = 100000 wei;
        spareparts['Piringan Cakram'] = 300000 wei;
        spareparts['Kabel Kopling'] = 200000 wei;
        spareparts['Bohlam Depan'] = 7000 wei;
        spareparts['Bohlam Belakang'] = 6000 wei;
        spareparts['Ban Tubeless'] = 450000 wei;
        spareparts['Handgrip'] = 22000 wei;
        spareparts['Busi'] = 25000 wei;
        spareparts['Busi Iridium'] = 85000 wei;
        spareparts['Accu'] = 275000 wei;
        spareparts['Klakson'] = 115000 wei;
    }

    /*
        modifier cek ketersediaan sparepart
    */
    modifier cekSparepart (string memory _part) {
        require(spareparts[_part] != 0, "Sparepart tidak tersedia");
        require(msg.value >= spareparts[_part], "Uang Anda tidak cukup untuk membeli sparepart");
        _;
    }
}
