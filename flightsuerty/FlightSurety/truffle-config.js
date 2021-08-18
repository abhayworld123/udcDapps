// var HDWalletProvider = require("truffle-hdwallet-provider");
var HDWalletProvider = require("@truffle/hdwallet-provider");

var mnemonic =
  "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      websockets: true,
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "^0.6.2",
    },
  },
};
