const HDWalletProvider = require('@truffle/hdwallet-provider')
const fs = require('fs')
const mnemonic = fs.readFileSync('.secret').toString().trim()

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1', // Localhost (default: none)
      port: 7545, // Standard BSC port (truffle port)
      network_id: '*' // Any network (default: none)
    },
    testnet: {
      // added FTM TESTNET HERE
      provider: () => new HDWalletProvider(mnemonic, `https://rpc.testnet.fantom.network`, 0, 9),
      network_id: 4002,
      confirmations: 0,
      // timeoutBlocks: 200,
      skipDryRun: true,
      from: '0x4390928e2F6aE6a9E3FB6476FB5cfbEC09e813FD'
    },
    // unused for now
    bsc: {
      provider: () => new HDWalletProvider(mnemonic, `https://bsc-dataseed1.binance.org`),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: '0.8.4' // A version or constraint - Ex. "^0.5.0"
    }
  }
}
