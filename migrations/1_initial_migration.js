
// Make sure the DevToken contract is included by requireing it.
const StakingToken = artifacts.require('StakingToken')
const RewardsToken = artifacts.require('RewardsToken')
const StakingRewards = artifacts.require('stakingRewards')

// THis is an async function, it will accept the Deployer account, the network, and eventual accounts.
module.exports = async function (deployer, network, accounts) {
  // await while we deploy the DevToken
  await deployer.deploy(StakingToken, 'Stake', 'STK', '90000000000000000000000')
  await deployer.deploy(RewardsToken, 'Rewards', 'RWRD', '9')
  await deployer.deploy(StakingRewards, '0xA362c5B6865DeDA7891f3EB31BeD650c06A50321', '0x43FD9218B484cDA15c55743756f5e05bd4E88F63')
  const stakingToken = await StakingToken.deployed()
  const rewardsToken = await RewardsToken.deployed()
  const sR = await StakingRewards.deployed()
}
