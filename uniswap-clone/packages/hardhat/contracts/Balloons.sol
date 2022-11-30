pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Balloons is ERC20 {

    event contractApproved(address spender, uint256 amount, string message);

    constructor() ERC20("Balloons", "BAL") {
        _mint(msg.sender, 1000 ether); // mints 1000 balloons!
    }

    function emitContractApproved(address sender, uint256 amount, string calldata message) public {
        emit contractApproved(sender, amount, message);
    }
}
