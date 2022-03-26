// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/*
How to swap tokens

1. Alice has 100 tokens from AliceCoin, which is a ERC20 token.
2. Bob has 100 tokens from BobCoin, which is also a ERC20 token.
3. Alice and Bob wants to trade 10 AliceCoin for 20 BobCoin.
4. Alice or Bob deploys TokenSwap
5. Alice approves TokenSwap to withdraw 10 tokens from AliceCoin
6. Bob approves TokenSwap to withdraw 20 tokens from BobCoin
7. Alice or Bob calls TokenSwap.swap()
8. Alice and Bob traded tokens successfully.
*/

contract TokenSwap {
    AggregatorV3Interface internal priceFeed;

    IERC20 public tokenA;
    address public ownerA;
    uint public amountA;
    IERC20 public tokenB;
    address public ownerB;
    uint public amountB;

    constructor(
        address _tokenA,
        address _ownerA,
        uint _amountA,
        address _tokenB,
        address _ownerB,
        uint _amountB
    ) {
        tokenA = IERC20(_tokenA);
        ownerA = _ownerA;
        amountA = _amountA;
        tokenB = IERC20(_tokenB);
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
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}