// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyNFT is ERC721 {
  address owner;

  uint256 public rate = 50 * 10**18;

  IERC20 public tokenAddress;
  using Counters for Counters.Counter;
  Counters.Counter private _tokenId;

  constructor(IERC20 _tokenAddress) ERC721("Task", "TSK") {
    tokenAddress = _tokenAddress;
  }

  // Minting MFT's

  function mint() public {
    uint256 tokenId = _tokenId.current();
    _safeMint(msg.sender, tokenId);
    _tokenId.increment();
  }

  // When user buys NFT's
  function buy() public payable {
    //   uint256 amount=0.01*10**18;
    // uint256 tokenId=_tokenId.current();
    tokenAddress.transferFrom(msg.sender, address(this), rate);
  }

  modifier onlyOwner() {
    owner = msg.sender;
    _;
  }

  function sell() public onlyOwner {
    tokenAddress.transfer(msg.sender, balanceOf(address(this)));
  }
}
