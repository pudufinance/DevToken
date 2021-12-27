
// Make sure the DevToken contract is included by requireing it.
const StakingToken = artifacts.require('StakingToken')
const RewardsToken = artifacts.require('RewardsToken')
const StakingRewards = artifacts.require('stakingRewards')
const Reserve = artifacts.require('Reserve')

// THis is an async function, it will accept the Deployer account, the network, and eventual accounts.
module.exports = async function (deployer, network, accounts) {
  // // await while we deploy the everything

  let add1
  let add2
  let add3
  let add4
  // Deploy staking token
  await deployer.deploy(StakingToken, 'Stake', 'steak', '900000000000000000000000').then(res => {
    console.log('res 1', res.address)
    add1 = res.address
  })
  // Deploy rewards token
  await deployer.deploy(RewardsToken, 'Rewards', 'rews', '900000000000000000000000').then(res => {
    console.log('res 2', res.address)

    add2 = res.address
  })
  // Deploy staking rewards contract that takes both tokens as args
  await deployer.deploy(StakingRewards, add1, add2).then(res => {
    add3 = res.address
  })

  // Deploy Reserve contract that takes both tokens as args
  await deployer.deploy(Reserve, add1, add2).then(res => {
    add4 = res.address
  })
  // const stakingToken = await StakingToken.deployed()
  // const rewardsToken = await RewardsToken.deployed()
  // const sR = await StakingRewards.deployed()
  console.log('add1:StakingToken', add1, 'add2:RewardsToken', add2, 'add3:StakingRewards', add3, 'add4:Reserve', add4)
}
