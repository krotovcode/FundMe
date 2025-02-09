// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


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

    function getVersion() public view returns (uint256) {
        return    AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }



}