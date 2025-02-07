// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface AggregatorV3Interface {
    
}

contract FundMe {

    uint256 public myValue = 1;

    function fund() public payable  {   
        myValue = myValue + 2;
        require(msg.value > 1e18, "not enough");
    }

    function getPrice() public {

    }

    function getConversionRate() public {
        //0x694AA1769357215DE4FAC081bf1f309aDC325306

    }



}