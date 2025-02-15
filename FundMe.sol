// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public adressToAmountFunded;


    function fund() public payable {
        require(msg.value.getConversionRate() >= minUsd, "not enough");
        funders.push(msg.sender);
        adressToAmountFunded[msg.sender] = adressToAmountFunded[msg.sender] + msg.value;
    }

}
