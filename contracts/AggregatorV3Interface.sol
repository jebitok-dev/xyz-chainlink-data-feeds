// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;
// import "hardhat/console.sol";

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {
    0xf7342e09CA8D04039Ab399899D2ADc3407dB9724 
    0x558F366c49E08CAbecA8f33d6584Fb7AdB5bA54B


    AggregatorV3Interface internal priceFeed;
    address1 = 0xf7342e09CA8D04039Ab399899D2ADc3407dB9724
    address2 = 0x515070a3103d2051ae5833c9d337740c68aaa2
    /**
     * Network: Rinkeby
     * Aggregator: AAVE/USD
     * Address: 0x547a514d5e3769680Ce22B2361c10Ea13619e8a9
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x558F366c49E08CAbecA8f33d6584Fb7AdB5bA54B);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}

0xf7342e09CA8D04039Ab399899D2ADc3407dB9724 
0x558F366c49E08CAbecA8f33d6584Fb7AdB5bA54B
