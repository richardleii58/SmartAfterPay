// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        // Sepolia ETH/USD Price Feed Address
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate with 18 decimals
        return uint256(answer * 1e10); // Adjust from 8 to 18 decimals
    }

    function getEthAmountFromUsd(
        uint256 usdAmount
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(); // ETH price in USD (18 decimals)
        uint256 ethAmount = (usdAmount * 1e18) / ethPrice;
        return ethAmount; // ETH amount in wei
    }
}
