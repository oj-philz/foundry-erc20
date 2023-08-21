// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";

contract TestMyToken is Test {
    DeployMyToken deploy;
    MyToken myToken;

    address bob = makeAddr("Bob");
    address alice = makeAddr("Alice");
    uint256 private startingBal = 100e18;

    function setUp() external {
        deploy = new DeployMyToken();
        myToken = deploy.run();
        myToken.mint(bob, startingBal);
    }

    function testBobBalance() external {
        console.log(myToken.balanceOf(bob));
        assert(myToken.balanceOf(bob) == startingBal);
    }

    function testAllowance() external {
        uint256 amount = 10e18;
        vm.prank(bob);
        myToken.approve(alice, amount);
        assertEq(myToken.allowance(bob, alice), amount);
    }

    function testTransfer() external {
        uint256 amount = 20e18;

        vm.prank(bob);
        myToken.transfer(alice, amount);

        assertEq(myToken.balanceOf(bob), startingBal - amount);
        assertEq(myToken.balanceOf(alice), amount);
    }

    function testTransferFrom() external {
        uint256 amount = 30e18;

        vm.prank(bob);
        myToken.approve(alice, amount);
        vm.prank(alice);
        myToken.transferFrom(bob, alice, amount);

        assertEq(myToken.balanceOf(bob), startingBal - amount);
        assertEq(myToken.balanceOf(alice), amount);
        assertEq(myToken.allowance(bob, alice), 0);
    }
}
