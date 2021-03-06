# Supply chain & data auditing

This repository containts an Ethereum DApp that demonstrates a Supply Chain flow between a Seller and Buyer. The user story is similar to any commonly used supply chain process. A Seller can add items to the inventory system stored in the blockchain. A Buyer can purchase such items from the inventory system. Additionally a Seller can mark an item as Shipped, and similarly a Buyer can mark an item as Received.




## Designing


### Activity Diagram

The  activity diagram shows the behavior of the system. It represents the flow 
from one activity to another in the system. We use the activity diagram to discover Actors and interactions in the supply chain.

![activity diagram](images/act.png)

### Sequence Diagram

The sequence diagram shows the  functions and events in the system It shows the interaction between
various objects in order of the sequence in which the interaction takes place. 

![sequence diagram](images/seq.png)

### State Diagram 

Shows the possible states the transition from one state to another. 

![state diagram](images/state.png)

### Data model

 It models relationship and attributes ofthe supply chain smart contract. 

![Data model](images/datamodel.png)




## Versions Used

```

contract address : 0x8fcB821C82F0531b695b7EC81AdB26364d49B053
node version number: v12.14.1

Truffle version number:  v4.1.14

Solidity: v0.4.24

web3 version number: 0.20.6

```

### Prerequisites

You must be familiar with the basic concepts and tools related to developing decentralized 
applications on Ethereum Blockchain.

1. Download and install [Node Version Manager]( https://github.com/nvm-sh/nvm#installation-and-update ) 
  (optional but highly recommended)

2. Download and install npm and [ nodejs ]( https://nodejs.org/en/ ). If you are using NVM, then 
  the latest version nodejs can be installed as: 
    ```
    nvm install node
    ```
3. Install [Ganache](https://www.trufflesuite.com/docs/ganache/quickstart)  development blockchain.

4. Install the command line version of Ganache as well.
    ```
    npm install -g ganache-cli
    ```

5. Install [Metamask](https://metamask.io/) Wallet for your browser. We will use Metamask wallet to sign
  transactions to be executed on our deployed contract on  Testnets (Rinkeby) and optionally on a local blockchain.
  If you already have a Metamask account, I recommend creating and using a *development* vault that
  doesn't have real Ether in yet. This way you won't accidentally lose any real money. You can always re-create/import your original wallet using the seed phrase/mnemonic of the wallet you created earlier.
  By default there is only one account in the Metamask vault. 



6. Request some test Ether funds from https://www.rinkeby.io/#faucet or from https://faucet.metamask.io. 
   Once you have some test Ether in your
   account make sure to distribute funds (at-least for some gas cost) to other accounts using 
   *Send Money* and then select *transfer between accounts* option in the Metamask window.

7. Create a free [Infura](https://infura.io) account if you don't have one already. Create a new Infura project or use an existing project. Note and copy the `PROJECT_ID`. The project id is 32 hexadecimal digits. 

![infura project id](images/infura_product_key.jpg)






### Installing

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

- Clone this repository.
    ```
    git clone https://github.com/abhayworld123/udcDapps

    go to dapps_for_tracking/project6/
    ```

    The project directory is like this 

    - **`src:`**  UI client code (Javascript/ES6, HTML, CSS) 
    - **`contracts/coffeeaccesscontrol:`** Contract library code the provides roles (farmer,distributor etc.)
    - **`contracts/coffeebase:`**  Supply chain contract
    - **`contracts/cofeeecore:`**  Base contract that provides ownership functionality
    - **`build/contracts:`**  Contract JSON ABI to be used by the client app
    - **`test:`** contract functionality tests
    - **`truffle-config.js`:** Truffle configuration file.
    - **`migrations`:** Directory for scriptable deployment files.
    - **`images:`** Supply chain contract UML diagrams
    - **`dist:`**  Webpack distribution output directory
    


- Install all requisite npm packages .
    ```
    npm install
    ```


```
Truffle compile
```

This will create the smart contract artifacts in folder ```build\contracts```.

Migrate smart contracts to the locally running blockchain, ganache-cli:

```
truffle migrate   (for Local)
truffel migrate --network rinkeby --reset    (for rinkeby)
```

Your terminal should look something like this:

```
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Replacing FarmerRole...
  ... 0xc4490b3ea7dd70306f858084ba044b93c5ed44ea75a6fbe0f7cf9a62c2eb9714
  FarmerRole: 0x20fdd8cd78a1383b140f75f69af51c5be7490905
  Replacing DistributorRole...
  ... 0x0ed203fa216ed05905e95687cea3f1e4843dc54e604933bba577fa778b3a4bc2
  DistributorRole: 0x678fa3fb828175aead1fd5716121c3215739a342
  Replacing RetailerRole...
  ... 0xe3d4be1f0c49adf747f0539bc97e464f4ebd0b9b444a4d8061154f8f57d8e7c8
  RetailerRole: 0x79013679c98017f33a14f2655ee5a66b2e78a18b
  Replacing ConsumerRole...
  ... 0x890b1cc8c37f82641b48556306a0465590c8f91aaadf2831171047c9447a973a
  ConsumerRole: 0x003c67b78c6303fadfdf85723d722469e842131d
  Replacing SupplyChain...
  ... 0x35c8622df96b9010625b051588c37ba71a2e6a8b0ee4ceffe22182c64708b5e8
  SupplyChain: 0x8114befddfe0c3154411b92ab19e819b1ab573fb
Saving successful migration to network...
  ... 0x50e9427bdf7e0193988e95a2b4a3e4259405f849e12cf607e4744f1966c97787
Saving artifacts...

```


Test smart contracts:

```
truffle test
```


All 10 tests should pass.

![truffle test](images/truffle_test.png)

In a separate terminal window, launch the DApp:

```
npm run dev
```




## working

The DApp User Interface when running should look like...

![truffle test](images/ftc_product_overview.png)

![truffle test](images/ftc_farm_details.png)

![truffle test](images/ftc_product_details.png)

![truffle test](images/ftc_transaction_history.png)

![truffle test](images/ftc_dep.png)



ProcessItem

blockHash: "0x39fbe8d902155db1911ed9be778fe23cf9ad6911af598ac5f37cf289f4ee461a"
blockNumber: 9004145
contractAddress: null
cumulativeGasUsed: 129415
effectiveGasPrice: "0x3b9aca08"
from: "0x4224762d69b2e0af39deab2395ceb38d2f4c2abf"
gasUsed: 21439
logs: []
logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
status: "0x1"
to: "0x9802d06b95031cd0a570fccf4930510b9be9b429"
transactionHash: "0x3dc0b4ea9ddbb5e3eaaba2def00bfa0c8fa2ebebc8392f47303c14361f8a8666"
transactionIndex: 3
type: "0x0"

PackItem
receipt:
blockHash: "0x39fbe8d902155db1911ed9be778fe23cf9ad6911af598ac5f37cf289f4ee461a"
blockNumber: 9004145
contractAddress: null
cumulativeGasUsed: 5910264
effectiveGasPrice: "0x3b9aca08"
from: "0x4224762d69b2e0af39deab2395ceb38d2f4c2abf"
gasUsed: 21593
logs: []
logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
status: "0x1"
to: "0x9802d06b95031cd0a570fccf4930510b9be9b429"
transactionHash: "0x4f48a36bb341392e2950a5286f69800f96a8310ebe4c25537a70e07923c19975"
transactionIndex: 26
type: "0x0"

ForSAle

receipt:
blockHash: "0xcca098cb3c0ef954684ac91e60eee1b6ea094ca0bdfa858e70a0b940c055e396"
blockNumber: 9004160
contractAddress: null
cumulativeGasUsed: 4397658
effectiveGasPrice: "0x3b9aca09"
from: "0x4224762d69b2e0af39deab2395ceb38d2f4c2abf"
gasUsed: 21564
logs: []
logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
status: "0x1"
to: "0x9802d06b95031cd0a570fccf4930510b9be9b429"
transactionHash: "0x271192764fb6b64422983a88bc5df07914659edf884c175b6798332efa9451d5"
transactionIndex: 3
type: "0x0"

shipItem
receipt:
blockHash: "0xfafe6d422efac8a7a22fdd8292dbeee4ec5d790b64a6f5c5919414f78deae341"
blockNumber: 9004173
contractAddress: null
cumulativeGasUsed: 194927
effectiveGasPrice: "0x3b9aca08"
from: "0x4224762d69b2e0af39deab2395ceb38d2f4c2abf"
gasUsed: 21615
logs: []
logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
status: "0x1"
to: "0x9802d06b95031cd0a570fccf4930510b9be9b429"
transactionHash: "0x9a4c4948eac27005a57005a25fa58fab9e6830d71138dd460c9be0292f70d212"
transactionIndex: 3
type: "0x0"


recieveItem

blockHash: "0xb6bc6e7495bea759d3476a4f5ca4f8aade0794f6e38a0a76e0ff214debf03757"
blockNumber: 9004184
contractAddress: null
cumulativeGasUsed: 717811
effectiveGasPrice: "0x3b9aca09"
from: "0x4224762d69b2e0af39deab2395ceb38d2f4c2abf"
gasUsed: 21505
logs: []
logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
status: "0x1"
to: "0x9802d06b95031cd0a570fccf4930510b9be9b429"
transactionHash: "0x44599301bc259ab5db1bfcaf063860caef64cefda3a7f5cc287d8c149610a5ca"
transactionIndex: 5
type: "0x0"



## Built With

* [Ethereum](https://www.ethereum.org/) - Ethereum is a decentralized platform that runs smart contracts
* [Infura](https://Infura.io/) 

* [Truffle Framework](http://truffleframework.com/) - Truffle is the most popular development framework for Ethereum with a mission to make your life a whole lot easier.


## Acknowledgments

* Solidity
* Ganache-cli   
* Truffle
* Infura

