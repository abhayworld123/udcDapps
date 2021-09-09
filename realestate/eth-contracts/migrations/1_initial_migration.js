var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer,network,accounts) {
  console.log('networks:::'+network);
  console.log('ac:::'+accounts);


  deployer.deploy(Migrations);
};
