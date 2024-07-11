// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OurToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("CryptoConf", "CRCF") {
        _mint(msg.sender, initialSupply);
        // seetting the intial supply using the _mint function and sending it to the msg.sender during deploy
    }
}
