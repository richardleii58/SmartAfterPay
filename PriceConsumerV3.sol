// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
     * @notice Constructor initializes the Chainlink price feed
     * @param _priceFeed Address of the Chainlink ETH/USD price feed contract
     */
    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    /**
     * @notice Returns the latest ETH/USD price
     * @return price ETH price in USD with 8 decimals
     */
    function getLatestPrice() public view returns (uint256 price, uint256 updatedAt) {
        (, int256 answer,, uint256 timeStamp,) = priceFeed.latestRoundData();
        require(answer > 0, "Invalid price data");
        price = uint256(answer);
        updatedAt = timeStamp;
    }
}
