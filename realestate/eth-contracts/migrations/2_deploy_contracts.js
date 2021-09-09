// migrating the appropriate contracts
var Verifier = artifacts.require("./verifier.sol");
var SolnSquareVerifier = artifacts.require("./SolnSquareVerifier.sol");

module.exports = async function(deployer) {
  await deployer.deploy(Verifier);

  await deployer.deploy(
    SolnSquareVerifier,
    Verifier.address,
    'RealEstateToken',
    'RST',
    'https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/',
  );
};
