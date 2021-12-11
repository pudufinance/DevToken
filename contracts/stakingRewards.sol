// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

contract StakingRewards {
    using SafeMath for uint256;
    // using SafeERC20 for IERC20;
    IERC20 public rewardsToken;
    IERC20 public stakingToken;

    // added higher reward rate uint public rewardRate = 100;
    uint public rewardRate = 100000000000000000;
    uint public lastUpdateTime;
    uint public rewardPerTokenStored;

    mapping(address => uint) public userRewardPerTokenPaid;
    mapping(address => uint) public rewards;

    // added public, uint private _totalSupply;
    uint public _totalSupply;
    //added public, mapping(address => uint) private _balances;
    mapping(address => uint) public _balances;

    constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }

    event Earned(address indexed from, uint256 earnedMath);
    event WithDraw(uint256 val);

    //
    function rewardPerToken() public view returns (uint) {
        if (_totalSupply == 0) {
            return 0;
        }
        return
            rewardPerTokenStored +
            (((block.timestamp - lastUpdateTime) * rewardRate * 1e18) / _totalSupply);
    }

    // RETURNS THE AMOUNT OF REWARDS TOKENS EARNED
    function earned(address account) public view returns (uint) {
        return
            ((_balances[account] *
                (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) +
            rewards[account];
    }

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;
        // emit Earned(account, earned(account));
        rewards[account] = earned(account);
        userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }

    // STAKE
    function stake(uint _amount) external updateReward(msg.sender) {
        _totalSupply += _amount;
        _balances[msg.sender] += _amount;
      // transfer staking token  *invoker* to *this contract*
        stakingToken.transferFrom(msg.sender, address(this), _amount);
    }

    // WITHDRAW STAKE
    function withdraw(uint _amount) external updateReward(msg.sender) {
        _totalSupply -= _amount;
        // if (_amount == _balances[msg.sender]) {
          _balances[msg.sender] = 0;
        // } else {
        // _balances[msg.sender] -= _amount;
        // }
        emit WithDraw(_balances[msg.sender]);
        stakingToken.transfer(msg.sender, _amount);
    }

    // GET REWARD //
    function getReward() external updateReward(msg.sender) {
      uint reward = rewards[msg.sender];

        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);
        }
    }

    // added: need a function that returns total staked balance _balances (simple)
    function getStaked() public view returns (uint) {
        return 
          _balances[msg.sender];
    }

    // added: need a function that returns total supply aka _totalSupply (simple)
    function getTotalSupply() public view returns (uint) {
        return 
          _totalSupply;
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