// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
// import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
// import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

/**
* @notice DevToken is a development token that we use to learn how to code solidity 
* and what BEP-20 interface requires
*/
contract RewardsToken is ERC20, ERC20Burnable {
 

    constructor( 
      string memory name,
      string memory symbol,
      uint256 initialSupply
    ) ERC20(name, symbol) {

      _mint(msg.sender, initialSupply);

    }

}