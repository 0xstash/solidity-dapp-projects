// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "../node_modules/uniswap/uniswap-contracts-moonbeam/contracts/periphery/interfaces/IUniswapV2Router02.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Swap {
    address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    IUniswapV2Router02 private router = IUniswapV2Router02(UNISWAP_V2_ROUTER);

    function swap(address _tokenIn, address _tokenOut, uint256 _amountIn) payable external returns (uint[] memory amounts) {
        // Transfer input amount from sender to this contract
        require(IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn), "Tokens could not be transferred from the sender");
        
        // Approve Uniswap v2 Router so that it's allowed to spend tokens in this contract
        require(IERC20(_tokenIn).approve(UNISWAP_V2_ROUTER, _amountIn), "Approval request failed");

        // Store token contract addresses in an indexed array
        address[] memory addresses = getAddressArray(_tokenIn, _tokenOut);

        // Calculate min out amount
        uint256 amountOutMin = getAmountOutMin(_tokenIn, _tokenOut, _amountIn);

        amounts = router.swapExactTokensForTokens(_amountIn, amountOutMin, addresses, msg.sender, block.timestamp);
    }
    
    /*
        Helper Functions
    */
    function getAmountOutMin(address _tokenIn, address _tokenOut, uint256 _amountIn) private view returns (uint256) {
        address[] memory addresses = getAddressArray(_tokenIn, _tokenOut);
        uint256[] memory amountOutMins = router.getAmountsOut(_amountIn, addresses);
        return amountOutMins[addresses.length-1];  
    }

    function getAddressArray(address a1, address a2) private pure returns (address[] memory addresses) {
        address[] memory addressArr = new address[](2);
        addressArr[0] = a1;
        addressArr[1] = a2;
        addresses = addressArr;
    }
}