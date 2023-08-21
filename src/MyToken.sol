// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 _initialSupply) ERC20("MyToken", "MTK") {
        mint(msg.sender, _initialSupply);
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
