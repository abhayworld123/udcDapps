const mnemonic = "rigth pausi raasndom gsrief orphaan payment price thank settle crumble museum ";
const HDWallet = require('truffle-hdwallet-provider');
const infuraKey = "";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777" // Match any network id
    },
    rinkeby: {
      provider: () => new HDWallet(mnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
        network_id: 4,       // rinkebys id
        gas: 4500000,        // rinkeby has a lower block limit than mainnet
        gasPrice: 10000000000,
        networkCheckTimeout: 999999,
    },
  }
};
