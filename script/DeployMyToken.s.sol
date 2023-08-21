// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script {
    uint256 private initialSupply = 1000000e18;
    uint256 private constant DEFAULT_ANVIL_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 deployerKey;

    function run() external returns (MyToken) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        vm.startBroadcast(deployerKey);
        MyToken myToken = new MyToken(initialSupply);
        vm.stopBroadcast();
        return myToken;
    }
}
