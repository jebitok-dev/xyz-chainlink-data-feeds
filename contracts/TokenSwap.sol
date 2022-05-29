// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IERC20.sol";

contract TokenSwap {
    AggregatorV3Interface internal priceFeed;
    uint8 decimals;
    uint248 swapIndex;
    int256 currentRate;
    address internal daiAdd  = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
    address internal USDCAdd = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;

    struct Swap {
        uint256 amount;
        address owner;
        uint8 currencyDecimal;
        bool status;
    }

    mapping(uint => Swap) swapOrder;
    IERC20 DAI = IERC20(daiAdd);
    IERC20 USDC = IERC20(usdcAdd);

    constructor(address _address) {
        priceFeed = AggregatorV3Interface(_address);
    }

    function swapDaiToUSDC(address _fromAddress, uint256 _amount) public {
        uint256 swapAmount = (_amount * uint256(currentRate))/10**decimals;
        // require(msg.sender == ownerA || msg.sender == ownerB, "owners can only swap");
        require(
            DAI.balanceOf(_fromAddress) >= 20,
            "Insufficient balance"
        );
       Swap storage swap_ = swapOrder[swapIndex];
       swap_.amountIn = _amount;
       swap_.currencyDecimal = decimals;
       swap_.owner = _fromAddress;
       swapIndex++;
       (bool status) = DAI.transferFrom(_fromAddress, address(this), _amount);
       require(status, "Transaction Failed!");
       (bool status) = USDC.transfer(_fromAddress, swapAmount);
       require(status!, "Transaction Failed!");
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

    function getRate() public view returns(int256, uint8) {
        return (currentRate, decimals);
    }

    function addLiquidity(address _address, address _tokenAddress, uint256 amount) public returns (bool success) {
        success = IERC20(_tokenAddress).transferFrom(_address, address(this), amount);
        require(success != true, "Transaction Unsuccessful!");
    }

    function checkTokenBalance(address _tokenAddress) external view returns (uint256 _Balance) {
        _Balance = IERC20(_tokenAddress).balanceOf(address(this));
    }

    function retrieveOrder(uint256 index) public view returns (Swap memory) {
        Swap storage swap_ = swapOrder[index];
        return(swap_);
    }
}