// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";

contract DeployOurToken is Script, Test {

    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    
    
    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ourtoken = new OurToken(INITIAL_SUPPLY);
        // deploying the token with 1000 supply
        // getting msg.sender have the Default Sender  value cause we didn't provided any private key
        // and meaning no matter the nesting depth we will be using def address now matter what
        // without the vm.startBroadcast(); the Script address would the owner
        vm.stopBroadcast();
        // but if you vm.startBroadcast() a call in a script that later call another script that now actually deploy a contract,
        // the The foundry default sender would be the sender of the first transaction that call the other script 
        // and the script contract where the contract is deployed will be the owner of the deployed contract 

        console.log(address(this));
        console.log(msg.sender);
        return ourtoken;
    
    }

}