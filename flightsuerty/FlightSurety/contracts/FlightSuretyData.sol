
// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "../node_modules/@openzeppelin/contracts/math/SafeMath.sol";

contract FlightSuretyData {
    using SafeMath for uint256;

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/
    mapping(address => bool) private IsFundedAirlines;                    // funded (and thus also approved) airlines
    mapping(address => bool) private authorizedCallers;   
    address private contractOwner;                                      // Account used to deploy contract
    bool private operational = true;                             // Operational
    mapping(bytes32 => InsuranceData) private insuranceDetails; 
    bytes32[] private insuranceKeys;
    address[] private allP_Insurees;
    mapping(bytes32 => mapping(address => uint256)) private insurance;
    mapping(address => uint256) private credit;                       

    struct InsuranceData {        
            address airline;
            string flight;
            uint256 timestamp;        
        }

    /********************************************************************************************/
    /*                                       EVENT DEFINITIONS                                  */
    /********************************************************************************************/


    /**
    * @dev Constructor
    *      The deploying account becomes contractOwner
    */
    constructor
                                (
                                ) 
                                public 
    {
        contractOwner = msg.sender;
    }


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
        require(operational, "Contract is currently not operational");
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

    modifier requireAuthorizedCaller(){
        require(authorizedCallers[msg.sender], "Caller of FlightSuretyData is not authorized");
        _;
    }


    /********************************************************************************************/
    /*                                       UTILITY FUNCTIONS                                  */
    /********************************************************************************************/

    /**
    * @dev Get operating status of contract
    *
    * @return A bool that is the current operating status
    */      
    function isOperational() 
                            public 
                            view 
                            returns(bool) 
    {
        return operational;
    }


    /**
    * @dev Sets contract operations on/off
    *
    * When operational mode is disabled, all write transactions except for this one will fail
    */    
    function setOperatingStatus
                            (
                                bool mode
                            ) 
                            external
                            requireContractOwner 
    {
        operational = mode;
    }


      //authorize  caller address  (flightsurety js)
    function authorizeCaller(address _address) external requireContractOwner {
        authorizedCallers[_address] = true;
    }



    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

   /**
    * @dev Add an airline to the registration queue
    *      Can only be called from FlightSuretyApp contract
    *
    */   
    function registerAirline
                            (   
                            )
                            external
                            pure
    {
    }


   /**
    * @dev Buy insurance for a flight
    *
    */   
    function buy
                            (    address airline, 
                                 string memory flight,
                                 uint256 timestamp,
                                 address insuree                         
                            )
                            external
                            payable
                            requireAuthorizedCaller
    {
      // get key
        bytes32 key = getFlightKey(airline, flight, timestamp);
        // only one insurance allowed per
        require(insurance[key][insuree] == 0) ; // only one insurance allowed per passenger per flight


          // store insurance metadata
        insuranceDetails[key] = InsuranceData({airline : airline, flight : flight, timestamp : timestamp}); 

        insurance[key][insuree] = msg.value;
        // add key to list of keys
        uint256 i=0;
        for(i=0; i<insuranceKeys.length; i++)
            if(insuranceKeys[i]==key)
                break;
        if(i==insuranceKeys.length) 
            insuranceKeys.push(key);

        // add insuree to list of passenger insurees
        for(i=0; i<allP_Insurees.length; i++)
            if(allP_Insurees[i]==insuree)
                break;
        if(i==allP_Insurees.length) 
            allP_Insurees.push(insuree); 
 
    }

    /**
     *  @dev Credits payouts to insurees
    */
    function creditInsurees
                                (
                                     address airline,
                                     string memory flight,
                                     uint256 timestamp
                                )
                                external
                                requireAuthorizedCaller
    {
        // get flight key
        bytes32 key = getFlightKey(airline, flight, timestamp);
        // loop on insurees
        for (uint256 i=0; i<allP_Insurees.length; i++){
            address insuree = allP_Insurees[i];
            // multiply paid premium by payOff
            uint256 payout = (insurance[key][insuree]).div(3).mul(2);
            // set insured amount for flight to 0
            insurance[key][insuree] = 0;
            // update insuree credit
            credit[insuree] = credit[insuree].add(payout);
    }
    }
    
    

    /**
     *  @dev Transfers eligible payout funds to insuree
     *
    */
    function _pay(address passenger) external requireAuthorizedCaller{
        uint256 amt_paid = credit[passenger];
        credit[passenger] = 0;
        payable(passenger).transfer(amt_paid);
    }



     
    function clearInsurance(address airline, string memory flight, uint256 timestamp) external requireAuthorizedCaller{
        // get key
        bytes32 key = getFlightKey(airline, flight, timestamp);
        for (uint256 i=0; i<allP_Insurees.length; i++){
            address insuree = allP_Insurees[i];
            // set insured amount for flight to 0
            insurance[key][insuree] = 0;
        }        
    }

   /**
    * @dev Initial funding for the insurance. Unless there are too many delayed flights
    *      resulting in insurance payouts, the contract should be self-sustaining
    *
    */   
 
    function fund(address airline) external payable requireAuthorizedCaller 
       {
            
            require(IsFundedAirlines[airline] == false);
            require(msg.value == 10 ether);// check  funding  amount
            IsFundedAirlines[airline] = true;// marking airline as funded
       }

     /**
     *  @dev Returns credit of a passenger
     *
    */
    function getCredit(address passenger) view external requireAuthorizedCaller returns(uint256){
        return credit[passenger];        
    }



    function getFlightKey(
                            address airline,
                            string memory flight,
                            uint256 timestamp)
                            pure
                        internal
                        returns(bytes32) 
    {
        return keccak256(abi.encodePacked(airline, flight, timestamp));
    }

      /**
     *  @dev Returns amount of passenger's insurance
     *
    */
    function getInsurance(address passenger, address airline, string memory flight, uint256 timestamp) view external requireAuthorizedCaller returns(uint256){
        // get flight key
        bytes32 key = getFlightKey(airline, flight, timestamp);
        return insurance[key][passenger];
    }

   // get insurance data 
    function getInsuranceData(bytes32 key) view external requireAuthorizedCaller returns(address airline, string memory flight, uint256 timestamp){
        InsuranceData memory data = insuranceDetails[key];
        return (data.airline, data.flight, data.timestamp);
    }



    fallback() external {
    }

    /**
    * @dev Fallback function for funding smart contract.
    *
    */
    // function() 
    //                         external 
    //                         payable 
    // {
    //     fund();
    // }


}

