// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public adressToAmountFunded;


    function fund() public payable {
        require(getConversionRate(msg.value) >= minUsd, "not enough");
        funders.push(msg.sender);
        adressToAmountFunded[msg.sender] = adressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUsd;
    }
}
