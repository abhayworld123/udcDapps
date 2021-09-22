// var HDWalletProvider = require("truffle-hdwallet-provider");
var HDWalletProvider = require("@truffle/hdwallet-provider");

var mnemonic =
  "candy maple cake lick pudding creamy honey rich lolly candy sweet treat";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      websockets: true,
      network_id: "*", // Match any network  rinkeby id
    },
  },
  compilers: {
    solc: {
      version: "^0.6.2",
    },
  },
};
