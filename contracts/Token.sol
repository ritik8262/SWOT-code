// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  constructor() ERC20("Token", "TO") {}

  function mint() public {
    _mint(msg.sender, 1000 * 10**18);
  }

  function approval(address _to) payable public returns (bool) {
    approve(_to, msg.value);
    return true;
  }
}
