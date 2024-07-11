// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";
import {OurToken} from "src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourtoken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        // creating a new instance of the deloy contract and assigning it's value to the var
        ourtoken = deployer.run();
        // running the deploy script and assigning the returned OurToken object value
        // to the ourtoken var for the testing purposes since it returns the deployed token instance
        // function run() external returns (OurToken)

        vm.prank(msg.sender);
        // if we hadn't the vm broadvast the correct prank would be
        // vm.prank(address(deployer));
        console.log("message sender after prank ", address(this));
        ourtoken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, ourtoken.balanceOf(bob));
        // utilizing the balanceOf inherited function to the check that balance checksum is correct
    }

    function testAllowances() public {
        // checking if transfer from works correctly
        uint256 initialAllowance = 1000;

        // bob approves alice to spend tokens on  her behalf
        vm.prank(bob);
        ourtoken.approve(alice, initialAllowance);
        // pranking bob setting the alice access to the spending inirialAllowance value from his account

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourtoken.transferFrom(bob, alice, transferAmount);
        // sending from the 500 tokens from bob to alice (but with the alice as tnx initiator)

        // if would call ourtoken.transferFrom(bob, alice, transferAmount); for e.x
        // whoever call this tnx will be set as _from param meaning it would like for the evm
        // ourtoken.transfer(alice, transferAmount);
        // meaning the msg.sender (aka we) will be sending our tokens to the alice
        // but keep in mind that transferFrom will only work if the specied specified initiator is approved by sender it calls

        assertEq(ourtoken.balanceOf(alice), transferAmount);
        assertEq(ourtoken.balanceOf(bob), STARTING_BALANCE - transferAmount);
        // we dealt the bob starting balance in the top of our test which gives opportunity to checksum is after the tnx
    }
}
