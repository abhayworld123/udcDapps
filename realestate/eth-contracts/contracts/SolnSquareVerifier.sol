pragma solidity >=0.4.21 <0.6.0;
import "./Verifier.sol";
import "./ERC721Mintable.sol";

// TODO define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>


// TODO define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is AbERC721Token {
 Verifier verifier;


// define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
  // ++ instantiated inside CONSTRUCTOR
 

  constructor(
    address solVerifier,
    string memory _name, string memory _symbol, string memory _baseTokenURI
  ) public AbERC721Token(_name, _symbol, _baseTokenURI) {
    verifier = Verifier(solVerifier);
  }

  // define a solutions struct that can hold an index & an address
  struct Solution {
    uint256 index;
    address solVerified;
  }

  // define an array of the above struct
  Solution[] SolutionsArray;


  // define a mapping to store unique solutions submitted
  mapping(bytes32 => Solution) uniqueSolutions;


  // Create an event to emit when a solution is added
  event NewSolutionIsAdded(uint256 index, address solVerified, bytes32 hashKey);
    event Tempevent(bytes32 hashKey);



  // Create a function to add the solutions to the array and emit the event
  function addSolution(uint256 index, address solVerified ,uint[2] memory a,
            uint[2] memory a_p,
            uint[2][2] memory b,
            uint[2] memory b_p,
            uint[2] memory c,
            uint[2] memory c_p,
            uint[2] memory h,
            uint[2] memory k,
            uint[2] memory input) public {
    Solution memory newSolution = Solution(index, solVerified);

    // Add Solution struct instance to addedSolutions array
   
    bytes32 hashKey = keccak256(abi.encodePacked(a, a_p, b, b_p, c, c_p, h , k ,input));


    // Add new Solution struct instance to map
    uniqueSolutions[hashKey] = newSolution;
     SolutionsArray.push(newSolution);
    // Emit Event
    emit NewSolutionIsAdded(index, solVerified, hashKey);
  }


  // Create a function to mint new NFT only after the solution has been verified
  function verifiedMinter(
            uint256 tokenId,
            uint[2] memory a,
            uint[2] memory a_p,
            uint[2][2] memory b,
            uint[2] memory b_p,
            uint[2] memory c,
            uint[2] memory c_p,
            uint[2] memory h,
            uint[2] memory k,
            uint[2] memory input,
           address solVerified
    
   
    ) public returns(bool isMinted) {
      isMinted = false;
      bytes32 hashKey = keccak256(abi.encodePacked(a, a_p, b, b_p, c, c_p, h , k ,input));
      //  - make sure the solution is unique (has not been used before)
      require(uniqueSolutions[hashKey].solVerified == address(0), "Solution  has been used before");

      // Verify Tx Proof
      bool isVerified = verifier.verifyTx(a, a_p, b, b_p, c, c_p, h ,k , input);
      require(isVerified, "Proof invalid");

        // mint(solVerified, tokenId);
        if(isVerified){
             addSolution(tokenId, msg.sender, a, a_p, b, b_p, c, c_p, h, k, input);
             isMinted = mint(solVerified, tokenId);
             return isMinted; 
        }
              
    }

}























