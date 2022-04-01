// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    AggregatorV3Interface internal priceFeed;

    IERC DAI;
    address  daiAdd  = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
    uint  amountA;
    IERC20 USDC;
    address  USDCAdd = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
    uint  amountB;

    constructor(
        address _daiAdd,
        uint _amountA,
        address _USDCAdd,
        uint _amountB
    ) {
        daiAdd = IERC20(_tokenA);
        ownerA = _ownerA;
        amountA = _amountA;
        USDCAdd = IERC20(_tokenB);
        ownerB = _ownerB;
        amountB = _amountB;

      /**
     * Network: Rinkeby
     * Aggregator: AAVE/USD
     * Address: 0x547a514d5e3769680Ce22B2361c10Ea13619e8a9
     */
        priceFeed = AggregatorV3Interface(0x547a514d5e3769680Ce22B2361c10Ea13619e8a9);
    }

    function swap() public {
        require(msg.sender == ownerA || msg.sender == ownerB, "owners can only swap");
        require(
            tokenA.allowance(ownerA, address(this)) >= 20,
            "your token balance is too low"
        );
        require(
            tokenB.allowance(ownerB, address(this)) >= 20,
            "your token balance too low"
        );

        _safeTransferFrom(tokenA, ownerA, ownerB, amountA);
        _safeTransferFrom(tokenB, ownerB, ownerA, amountB);
    }

    function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }

    function getLatestPrice(IERC20 token) public view returns (int) {
        (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        currentRate = price;
        decimals = priceFeed.decimals();
        return price;
    }
}