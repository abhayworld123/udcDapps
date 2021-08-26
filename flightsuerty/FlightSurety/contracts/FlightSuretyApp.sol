// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;
import "./FlightSuretyData.sol";


// It's important to avoid vulnerabilities due to numeric overflow bugs
// OpenZeppelin's SafeMath library, when used correctly, protects agains such bugs
// More info: https://www.nccgroup.trust/us/about-us/newsroom-and-events/blog/2018/november/smart-contract-insecurity-bad-arithmetic/

import "../node_modules/@openzeppelin/contracts/math/SafeMath.sol";
/************************************************** */
/* FlightSurety Smart Contract                      */
/************************************************** */
contract FlightSuretyApp {
    using SafeMath for uint256; // Allow SafeMath functions to be called for all uint256 types (similar to "prototype" in Javascript)

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/

    // Flight status codes
    uint8 private constant STATUS_CODE_UNKNOWN = 0;
    uint8 private constant STATUS_CODE_ON_TIME = 10;
    uint8 private constant STATUS_CODE_LATE_AIRLINE = 20;
    uint8 private constant STATUS_CODE_LATE_WEATHER = 30;
    uint8 private constant STATUS_CODE_LATE_TECHNICAL = 40;
    uint8 private constant STATUS_CODE_LATE_OTHER = 50;


    uint8 private constant REGISTERED = 20;
      // Airlines satus codes
    uint8 private constant UN_REGISTERED = 0; // this must be 0
    uint8 private constant S_IN_PROCESS = 10;
   

    address private contractOwner;          // Account used to deploy contract
     uint8 private constant FUNDED = 30;

    struct Flight {
        bool isRegistered;
        uint8 statusCode;
        uint256 updatedTimestamp;        
        address airline;
    }

    mapping(bytes32 => Flight) private flights;
    //flight operations status
    bool private operational = true;

    FlightSuretyData private flight_SuretyData;  

    /////Airlines structure defined/////

       struct Airline {
        uint8 status;
        uint256 votes;
    }
    // airlines Mapper
    mapping(address => Airline) private mapAirlines;
    // all airlines arrY
    address[] private airlines_arr = new address[](0); 

    // max number of airlines when 50% multiparty consensus required
    uint8 private constant MAX_NO_BEFORE_CONSENSUS = 4;


    uint256 private num_Airlines_Consensus;
    // number of funded arilines

    // mapping of airlines in the process of being registered
    mapping(address => address[]) private inProcessAirlines;   
 
    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    // Modifiers help avoid duplication of code. They are typically used to validate something
    // before a function is allowed to be executed.

    /**
    * @dev Modifier that requires the "operational" boolean variable to be "true"
    *      This is used on all state changing functions to pause the contract in 
    *      the event there is an issue that needs to be fixed
    */
    modifier requireIsOperational() 
    {
         // Modify to call data contract's status
        require(true, "Contract is currently not operational");  
        _;  // All modifiers require an "_" which indicates where the function body will be added
    }

    /**
    * @dev Modifier that requires the "ContractOwner" account to be the function caller
    */
    modifier requireContractOwner()
    {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }

      /// @dev Modifier that requires the caller to be a funded with some amount (10ETH)
    modifier requireFundedAirline(){
        require(mapAirlines[msg.sender].status == FUNDED, "Caller of app is not a funded airline");
        _;
    }

    
    /**
    * @dev Modifier that requires the "caller" also to be registered
    */
       modifier requireRegisteredAirline()
    {
        require(mapAirlines[msg.sender].status== REGISTERED, "Caller is not registered airline");
        _;
    }

    /********************************************************************************************/
    /*                                       CONSTRUCTOR                                        */
    /********************************************************************************************/

    /**
    * @dev Contract constructor
    *
    */

     constructor(address dataContractAddress, address firstAirline) public {
        require(dataContractAddress != address(0));
        contractOwner = msg.sender;
        // initialize
        flight_SuretyData = FlightSuretyData(dataContractAddress);  
        // register first airline
        AirlineRegistration(firstAirline);
        // register first airline in arraylist 
        airlines_arr.push(firstAirline);
    }
     /**
    * @dev Contract fallback
    *
    */

     fallback() external {
    }
    /********************************************************************************************/
    /*                                      UTILITY FUNCTIONS                                   */
    /********************************************************************************************/

    function isOperational() 
                            public 
                            view 
                            returns(bool) 
    {
       return operational;  // Modify to call data contract's status
    }


    /// @dev Sets operations status (status)
    function setOperatingStatus(bool mode) external requireContractOwner {
        operational = mode;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/
   

  


 /**
    * @notice Attempts to register and airline. For the first MAX_NO_BEFORE_CONSENSUS
    * airlines this is a simple request from a funded airline. After that it becomes a multiparty
    * consensus where a number of funded airlines at least equal to 50% of the number of registered
    * airlines need to request the airline registration.
    
    * @return success a bool indicating if the airline is registered
    * @return votes a uint256 with the number of votes
    */


  /// @dev Registeration of an airline
    function AirlineRegistration(address airline)
        private 
        requireIsOperational  
        returns(bool success)                         
    {
        
        require(mapAirlines[airline].status == UN_REGISTERED || mapAirlines[airline].status == S_IN_PROCESS);
        // set status airline registered
        mapAirlines[airline].status = REGISTERED;
        // increment number of airlines for checking Multipart consesus
        num_Airlines_Consensus++;
        if(inProcessAirlines[airline].length != 0)
            delete inProcessAirlines[airline];
        return true;
    }
  
   /**
    * @dev Add an airline to the registration queue
    *
    */   
    function registerAirline
                            (  address airline 
                            )
                            external
                            requireIsOperational
                            requireFundedAirline
                            returns(bool success, uint256 votes)
    {
        // return (success, 0);
 
         // first time register the airline, passed
        if(mapAirlines[airline].status == UN_REGISTERED){
            mapAirlines[airline] = Airline({ status: UN_REGISTERED, votes : 0 });
            airlines_arr.push(airline);        
        }

         // decide whether to use multiparty consensus or not
         //if number is less than limit
        if(num_Airlines_Consensus < MAX_NO_BEFORE_CONSENSUS){            
            success = AirlineRegistration(airline);
            mapAirlines[airline].status = REGISTERED;
        }
        //For Voting process
        else{
            uint256 VotesStats = inProcessAirlines[airline].length;
            if(VotesStats == 0){
                inProcessAirlines[airline] = new address[](0);
                inProcessAirlines[airline].push(msg.sender);
                success = false;
                votes = 1;
                mapAirlines[airline].status = S_IN_PROCESS;
                mapAirlines[airline].votes = votes;
               }

           else{
                    // no double voting by the same airline
                uint256 count = 0;
                for(; count < VotesStats; count++){
                    if(inProcessAirlines[airline][count] == msg.sender) // check double voting 
                        break;
                }
                if(count == VotesStats) 
                    inProcessAirlines[airline].push(msg.sender); // add vote
                // update votes
                votes = inProcessAirlines[airline].length;

               
                if(votes >= num_Airlines_Consensus/2){
                    //Airline voted success and registering airline
                    success = AirlineRegistration(airline);
                    mapAirlines[airline].status = REGISTERED;
                    mapAirlines[airline].votes  = votes;
                }else{
                    success = false;
                    mapAirlines[airline].votes  = votes;
                }
               }
        }
         return (success, votes);
    }


   /**
    * @dev Register a future flight for insuring.
    *
    */  
    function registerFlight
                                (address airline
                                )
                                external
                                pure
    {

    }

  

      /// @dev allow a registered airline to fund required
      /// should be operational and registered  
    function newfund()
        external
        payable
        requireIsOperational    
        requireRegisteredAirline
    {
        require(msg.value == 10 ether);
        // update airline status
        mapAirlines[msg.sender].status = FUNDED;

        // forward funds to data contract
        flight_SuretyData.fund{value:msg.value}(msg.sender);
    }

  //if funded
    function isFundedAirline(address airline) external view returns(bool) {
        return mapAirlines[airline].status == FUNDED;
    }
    // Return airlines  array
    function getAirlines() external view returns(address[] memory) {
        return airlines_arr;
    }

    // Return airline status
    function getAirlineStatus(address airline) external view returns(uint8) {
        return mapAirlines[airline].status;
    }

     // method to  check if an airline is registered (returns registered)
    function isRegisteredAirline(address airline) external view returns(bool) {
        return mapAirlines[airline].status == REGISTERED;
    }

    
    // Check if an airline is in the registration process (returns inprocess)
    function isAirlineRegistryinProcess(address airline) external view returns(bool) {
        return  mapAirlines[airline].status == S_IN_PROCESS;
    }

   
    
   /**
    * @dev Called after oracle has updated flight status
    *
    */  
    function processFlightStatus
                                (
                                    address airline,
                                    string memory flight,
                                    uint256 timestamp,
                                    uint8 statusCode
                                )
                                internal
                                pure
    {

         if (statusCode == STATUS_CODE_UNKNOWN) {
             return;
         }
        if (statusCode == STATUS_CODE_LATE_AIRLINE) {
            //give some insurance 
        }
        if (statusCode == STATUS_CODE_LATE_WEATHER){
           //give some insurance 
        }
        if (statusCode == STATUS_CODE_LATE_TECHNICAL){
            //give some insurance 
        }
        if (statusCode == STATUS_CODE_LATE_OTHER){
           //give some insurance 
        }


    }


    // Generate a request for oracles to fetch flight information
    function fetchFlightStatus
                        (
                            address airline,
                            string memory flight,
                            uint256 timestamp                            
                        )
                        external
    {
        uint8 index = getRandomIndex(msg.sender);

        // Generate a unique key for storing the request
        bytes32 key = keccak256(abi.encodePacked(index, airline, flight, timestamp));


        oracleResponses[key] = ResponseInfo({
                                                requester: msg.sender,
                                                isOpen: true
                                            });

        emit OracleRequest(index, airline, flight, timestamp);
    } 
    

    //Passenger buy insuranvce

        function buy(address airline, string memory flight, uint256 timestamp)
        external
        payable
    {
        // passenger to pay upto 1ether 
        require(msg.value <= 1 ether);
        // check that the insurance is funded
        require(mapAirlines[airline].status == FUNDED);
        // call buy from  data contract and send funds


        flight_SuretyData.buy{value:msg.value}(airline, flight, timestamp, msg.sender);        
    }


    //call pay function from data contract 
    function pay() external {        
        flight_SuretyData._pay(msg.sender);
    }

    //return cretit to insurers
    function getCredit() view external returns(uint256) {
        return flight_SuretyData.getCredit(msg.sender);
    }


   // insurance get 
    function getInsurance(address airline, string memory flight, uint256 timestamp) view external returns(uint256) {
        return flight_SuretyData.getInsurance(msg.sender, airline, flight, timestamp);
    }


   


// region ORACLE MANAGEMENT

    // Incremented to add pseudo-randomness at various points
    // uint8 private nonce = 0;    
    uint8 private nonce = 250;    

    // Fee to be paid when registering oracle
    uint256 public constant REGISTRATION_FEE = 1 ether;

    // Number of oracles that must respond for valid status
    uint256 private constant MIN_RESPONSES = 3;


    struct Oracle {
        bool isRegistered;
        uint8[3] indexes;        
    }

    // Track all registered oracles
    mapping(address => Oracle) private oracles;

    // Model for responses from oracles
    struct ResponseInfo {
        address requester;                              // Account that requested status
        bool isOpen;                                    // If open, oracle responses are accepted
        mapping(uint8 => address[]) responses;          // Mapping key is the status code reported
                                                        // This lets us group responses and identify
                                                        // the response that majority of the oracles
    }

    // Track all oracle responses
    // Key = hash(index, flight, timestamp)
    mapping(bytes32 => ResponseInfo) private oracleResponses;

    // Event fired each time an oracle submits a response
    event FlightStatusInfo(address airline, string flight, uint256 timestamp, uint8 status);

    event OracleReport(address airline, string flight, uint256 timestamp, uint8 status);

    // Event fired when flight status request is submitted
    // Oracles track this and if they have a matching index
    // they fetch data and submit a response
    event OracleRequest(uint8 index, address airline, string flight, uint256 timestamp);


    // Register an oracle with the contract
    function registerOracle
                            (
                            )
                            external
                            payable
    {
        // Require registration fee
        require(msg.value >= REGISTRATION_FEE, "Registration fee is required");

        uint8[3] memory indexes = generateIndexes(msg.sender);

        oracles[msg.sender] = Oracle({
                                        isRegistered: true,
                                        indexes: indexes
                                    });
    }

    function getMyIndexes
                            (
                            )
                            view
                            external
                            returns(uint8[3] memory) 
    {
        require(oracles[msg.sender].isRegistered, "Not registered as an oracle");

        return oracles[msg.sender].indexes;
    }




    // Called by oracle when a response is available to an outstanding request
    // For the response to be accepted, there must be a pending request that is open
    // and matches one of the three Indexes randomly assigned to the oracle at the
    // time of registration (i.e. uninvited oracles are not welcome)
    function submitOracleResponse
                        (
                            uint8 index,
                            address airline,
                            string  memory flight ,
                            uint256 timestamp,
                            uint8 statusCode
                        )
                        external
    {
        require((oracles[msg.sender].indexes[0] == index) || (oracles[msg.sender].indexes[1] == index) || (oracles[msg.sender].indexes[2] == index), "Index does not match oracle request");


        bytes32 key = keccak256(abi.encodePacked(index, airline, flight, timestamp)); 
        require(oracleResponses[key].isOpen, "Flight or timestamp do not match oracle request");

        oracleResponses[key].responses[statusCode].push(msg.sender);

        // Information isn't considered verified until at least MIN_RESPONSES
        // oracles respond with the *** same *** information
        emit OracleReport(airline, flight, timestamp, statusCode);
        if (oracleResponses[key].responses[statusCode].length >= MIN_RESPONSES) {

            emit FlightStatusInfo(airline, flight, timestamp, statusCode);

            // Handle flight status as appropriate
            processFlightStatus(airline, flight, timestamp, statusCode);

        }
    }

   //return flight key generated
    function getFlightKey
                        (
                            address airline,
                            string memory flight,
                            uint256 timestamp
                        )
                        pure
                        internal
                        returns(bytes32) 
    {
        return keccak256(abi.encodePacked(airline, flight, timestamp));
    }

    // Returns array of three non-duplicating integers from 0-9
    function generateIndexes
                            (                       
                                address account         
                            )
                            internal
                            returns(uint8[3] memory)
    {
        uint8[3] memory indexes;
        indexes[0] = getRandomIndex(account);
        
        indexes[1] = indexes[0];
        while(indexes[1] == indexes[0]) {
            indexes[1] = getRandomIndex(account);
        }

        indexes[2] = indexes[1];
        while((indexes[2] == indexes[0]) || (indexes[2] == indexes[1])) {
            indexes[2] = getRandomIndex(account);
        }

        return indexes;
    }

    // Returns array of three non-duplicating integers from 0-9
    function getRandomIndex
                            (
                                address account
                            )
                            internal
                            returns (uint8)
    {
        uint8 maxValue = 10;

        // Pseudo random number...the incrementing nonce adds variation
        uint8 random = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - nonce++), account))) % maxValue);

        if (nonce > 250) {
            nonce = 0;  // Can only fetch blockhashes for last 256 blocks so we adapt
        }

        return random;
    }

// endregion

}   
