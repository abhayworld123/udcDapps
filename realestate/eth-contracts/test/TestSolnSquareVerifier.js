var Verifier = artifacts.require('Verifier');
var solnSquareVerifier = artifacts.require('SolnSquareVerifier');

// - use the contents from proof.json generated from zokrates steps
var proof = require('../../zokrates/code/square/proof.json');




contract("TestSolnSquareVerifier", (accounts) => {
    const account_one = accounts[0];    // OWNER
    const account_two = accounts[1];    // TEST ACC
    describe("Can solutions be added or no", function () {
      beforeEach(async function () {
        this.contractVerifier = await Verifier.new({ from: account_one });
        this.contractSolnSquareVerifier = await solnSquareVerifier.new(
          this.contractVerifier.address,
          'RealEstateToken',
           'RST',
           'https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/',
          { from: account_one }
        );
      });



// contract("TestSolnSquareVerifier", (accounts) => {
   
//     const proofComputedHashKey = "0x0d40154b95ce2a4104cf32ef7d3ab4117477726f84de6d52d05c9c933292a714";
  

// Test if a new solution can be added for contract - SolnSquareVerifier
// describe(' New Verified Solution with SolnSquareVerifier', function () {
//     beforeEach(async function () {
//       // Initialize Contract
//       this.contractVerifier = await Verifier.new({ from: account_one });
//       this.contractSolnSquareVerifier = await SolnSquareVerifier.new(
//     this.contractVerifier.address,
//     'RealEstateToken',
//     'RST',
//     'https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/',
//     });

    
    it('Test if a new solution can be added for contract', async function () {
      const fnLogs = await this.contractSolnSquareVerifier.addSolution(22, account_one, proof.proof.A, proof.proof.A_p, proof.proof.B,proof.proof.B_p, proof.proof.C, proof.proof.C_p, proof.proof.H , proof.proof.K , proof.input);
      console.log(fnLogs.logs[0].event);
      assert.equal(fnLogs.logs[0].event, 'NewSolutionIsAdded', "New Solution was not added");
    });

    // Test if an ERC721 token can be minted for contract - SolnSquareVerifier


    it('Test if an ERC721 token can be minted for contract', async function () {
        const res = await this.contractSolnSquareVerifier.verifiedMinter.call(22, proof.proof.A, proof.proof.A_p, proof.proof.B,proof.proof.B_p, proof.proof.C, proof.proof.C_p, proof.proof.H , proof.proof.K , proof.input ,account_one);
        console.log(res);

        assert.equal(res, true, "Token wasn't minted successfully!");
      });


  });



})