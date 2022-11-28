// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Wallet.sol";

contract WalletFactory {
    mapping(address => address[]) wallets;

    event Created(address wallet, address from, address to, uint256 createdAt);

    constructor() {
    }

    // Prevent factory from accidentally receiving wei by overriding fallback function
    fallback () external {
        revert();
    }

    function getWallets(address _user) public view returns(address[] memory) {
        return wallets[_user];
    }

    function createWallet(address _account) payable public returns(address walletAddress) {
        Wallet wallet = new Wallet(_account);
        walletAddress = address(wallet);
        wallets[_account].push(walletAddress);
        emit Created(walletAddress, msg.sender, _account, block.timestamp);
    }
}