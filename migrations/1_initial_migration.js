
// Make sure the DevToken contract is included by requireing it.
const StakingToken = artifacts.require('StakingToken')
const RewardsToken = artifacts.require('RewardsToken')
const StakingRewards = artifacts.require('stakingRewards')

// THis is an async function, it will accept the Deployer account, the network, and eventual accounts.
module.exports = async function (deployer, network, accounts) {
  // // await while we deploy the DevToken
  // await deployer.deploy(StakingToken, 'Stake', 'steak', '90000000000000000000000')
  // await deployer.deploy(RewardsToken, 'Rewards', 'rews', '1000000000000000000')
  await deployer.deploy(StakingRewards, '0xBe186F245Dda151D0d2CFd6E2AF47434361e200b', '0xF2bCaD067D11d802768CD7c07C53624Fc0986246')
  // const stakingToken = await StakingToken.deployed()
  // const rewardsToken = await RewardsToken.deployed()
  const sR = await StakingRewards.deployed()
}
