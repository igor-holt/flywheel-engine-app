// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// Preview sketch only. Do not deploy without audit and legal review.
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract ContributionVault {
    address public operator;
    IERC20 public rewardToken;
    uint256 public totalWeight;
    mapping(address => uint256) public weight;
    mapping(address => uint256) public claimed;

    event WeightSet(address indexed account, uint256 weight);
    event Claimed(address indexed account, uint256 amount);

    modifier onlyOperator() {
        require(msg.sender == operator, "not operator");
        _;
    }

    constructor(address token) {
        operator = msg.sender;
        rewardToken = IERC20(token);
    }

    function setWeight(address account, uint256 w) external onlyOperator {
        totalWeight = totalWeight - weight[account] + w;
        weight[account] = w;
        emit WeightSet(account, w);
    }

    function claimable(address account, uint256 pool) public view returns (uint256) {
        if (totalWeight == 0) return 0;
        uint256 gross = (pool * weight[account]) / totalWeight;
        if (gross <= claimed[account]) return 0;
        return gross - claimed[account];
    }

    function claim(uint256 poolSnapshot) external {
        uint256 amt = claimable(msg.sender, poolSnapshot);
        require(amt > 0, "nothing");
        claimed[msg.sender] += amt;
        require(rewardToken.transfer(msg.sender, amt), "transfer");
        emit Claimed(msg.sender, amt);
    }
}
