// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Swap.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract Wallet {
    address payable public owner;

    constructor(address _owner) {
        owner = payable(_owner);
    }
    
    receive() external payable {}

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can take this action");
        _;
    }

    function getERC20Token(address _tokenContract) private pure returns(IERC20 token) {
        token = IERC20(_tokenContract);
        return token;
    }

    /*
        Balance Checking Methods
    */
    function getWeiBalance() external view returns (uint) {
        return address(this).balance;    
    }

    function getBalance(address _tokenContract) external view returns (uint) {
        IERC20 token = getERC20Token(_tokenContract);
        return token.balanceOf(address(this));    
    }

    /*
        Withdrawal Methods
    */
    function withdrawWei(uint _amount) external payable onlyOwner {
        require(_amount > 0, "Invalid amount");
        require(this.getWeiBalance() >= _amount, "Insufficient funds");
        payable(msg.sender).transfer(_amount);
    }

    function withdrawERC20(uint _amount, address _tokenContract) external payable onlyOwner {
        require(_amount > 0, "Invalid amount");
        require(this.getBalance(_tokenContract) >= _amount, "Insufficient funds");
        IERC20 token = getERC20Token(_tokenContract);
        token.transferFrom(address(this), msg.sender, _amount);
    }

    /*
        ERC-20 Sending Methods
    */
    function sendWei(uint _amount, address _recipient) payable external {
        require(_amount > 0, "Invalid amount");
        require(this.getWeiBalance() >= _amount, "Insufficient funds");
        payable(_recipient).transfer(_amount);
    }

    function sendToken(uint _amount, address _recipient, address _tokenContract) payable external {
        require(_amount > 0, "Invalid amount");
        require(this.getBalance(_tokenContract) >= _amount, "Insufficient funds");
        IERC20 token = getERC20Token(_tokenContract);
        token.transferFrom(address(this), _recipient, _amount);
    }

    /*
        NFT Sending Methods
    */
    function sendERC721(address _recipient, address _nftContract, uint256 _tokenId) payable external {
        IERC721 nft = IERC721(_nftContract);
        nft.safeTransferFrom(address(this), _recipient, _tokenId);
    }

    function sendERC1155(address _recipient, address _nftContract, uint256 _tokenId, uint _amount) payable external {
        IERC1155 nft = IERC1155(_nftContract);
        nft.safeTransferFrom(address(this), _recipient, _tokenId, _amount, "");
    }

    /*
        Swap Method
    */
    function swap(uint _amount, address _tokenIn, address _tokenOut) payable external returns (uint[] memory amounts) {
        require(_amount > 0, "Invalid amount");
        require(this.getBalance(_tokenIn) >= _amount, "Insufficient funds");
        Swap tokenSwap = new Swap();
        amounts = tokenSwap.swap(_tokenIn, _tokenOut, _amount);
    }
}