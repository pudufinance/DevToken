// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Reserve {
    using SafeMath for uint256;
    IERC20 public rewardsToken;
    IERC20 public stakingToken;

    constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    
    }
    event Redeem(uint256 paid, uint256 recieved);

  // ADDED
  // still need to prevent anything other than gpudu from 
  //working with this
    // Redeem
    function redeem(uint _amount) external {
      // transfer staking token  *invoker* to *this contract*
        rewardsToken.transferFrom(msg.sender, address(this), _amount);
        uint256 redeemAmount = _amount / 10;
        stakingToken.transfer(msg.sender, redeemAmount);
        emit Redeem(_amount, redeemAmount);
    }
  
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}