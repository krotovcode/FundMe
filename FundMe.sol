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
        adressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            adressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        payable(msg.sender).transfer(address(this).balance);
        bool sendSuccess = payable (msg.sender).send(address(this).balance);
        require(sendSuccess, "not success");
        (bool callSuccess,) = payable (msg.sender).call{value: address(this).balance}('');
        require(callSuccess, "no transfer");

    }

}
