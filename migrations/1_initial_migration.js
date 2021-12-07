
// Make sure the DevToken contract is included by requireing it.
const DevToken = artifacts.require('DevToken')

// THis is an async function, it will accept the Deployer account, the network, and eventual accounts.
module.exports = async function (deployer, network, accounts) {
  // await while we deploy the DevToken
  await deployer.deploy(DevToken, 'Cheese', 'CHEESE', 18, '50000000000000000000000')
  const devToken = await DevToken.deployed()
}
