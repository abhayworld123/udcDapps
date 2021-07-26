# Supply chain & data auditing

This repository containts an Ethereum DApp that demonstrates a Supply Chain flow between a Seller and Buyer. The user story is similar to any commonly used supply chain process. A Seller can add items to the inventory system stored in the blockchain. A Buyer can purchase such items from the inventory system. Additionally a Seller can mark an item as Shipped, and similarly a Buyer can mark an item as Received.

The DApp User Interface when running should look like...

![truffle test](images/ftc_product_overview.png)

![truffle test](images/ftc_farm_details.png)

![truffle test](images/ftc_product_details.png)

![truffle test](images/ftc_transaction_history.png)

![truffle test](images/ftc_dep.png)

  Deploying Migrations...
  ... 0x0075006132d9bd7d5414c1a4116ba30db7b47928c5d003bd46b7702fd17b1a70
  Migrations: 0x1116757c823ffa8a68acc50c0b9002ca2f370ac0
Saving successful migration to network...
  ... 0xc394b5f96f469b1b93b5ad60c600cd205c22db9b039346257d8cbf388a7fc88e
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying FarmerRole...
  ... 0x01b7af9f8662143269037af894eac3d4f0bb495198b48182dbb18ce1551890b6
  FarmerRole: 0xd3f2c35f276384b9a19a831bd5aeca8ac2351c07
  Deploying DistributorRole...
  ... 0x467c3cbf51d05b4e63c028dc50d621fe102b4ec9ed6ee5e13c34e831318881d4
  DistributorRole: 0xa9f5faa965a5c8be52f1de74e7334766f64f2cf6
  Deploying RetailerRole...
  ... 0xd9d3e3c5bb5e6a6d7123c90d4c6b45261bc87d36ca21c25b98d4af9d266cbb8b
  RetailerRole: 0xf2eb4c09ee69742d1cee4f11a599bd0a449d66ef
  Deploying ConsumerRole...
  ... 0x005d3122a80bc14e8ccf74ff104ac26bdd8d5863f80de3fde00c087bcba658cd
  ConsumerRole: 0xf785cbcae0823ca91eae6e1bb8d6ba65f8c2d069
  Deploying SupplyChain...
  ... 0xf1fa4c5061f892a5bbf67308e615c3660fe911b70679cb46a7b134026bf548c4
  SupplyChain: 0x9802d06b95031cd0a570fccf4930510b9be9b429
Saving successful migration to network...
  ... 0x07abd89fbdd8e0b2006337e2a5fd4d74ca885c6c49d77e747cc1746702bd990a
Saving artifacts...


## Design


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




## Getting Started





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
  transactions to be executed on our deployed contract on  Testnets (Rinkeby, Ropsten) and optionally on a local blockchain.
  If you already have a Metamask account, I recommend creating and using a *development* vault that
  doesn't have real Ether in yet. This way you won't accidentally lose any real money. You can always re-create/import your original wallet using the seed phrase/mnemonic of the wallet you created earlier.

  Unfortunately, Metamask doesn't provide an easy way to create a second vault if you already have one.The only
  way I know is to uninstall and reinstall Metamask. Once you have multiple vaults, switching between them
  is relatively painless by importing the account into Metamask using its seed phrase. 

  You can/should also import the accounts/vaults for your local Ganache blockchain using the seed phrase it
  emits when the local blockchain is started.

  By default there is only one account in the Metamask vault. Create at least five accounts by clicking on 
  the *Create Account* link in the Metamask window.

  ![Metamask account](images/create_metamask_account.png)

6. Request some test Ether funds from https://www.rinkeby.io/#faucet or from https://faucet.metamask.io. 
   Once you have some test Ether in your
   account make sure to distribute funds (at-least for some gas cost) to other accounts using 
   *Send Money* and then select *transfer between accounts* option in the Metamask window.

7. Create a free [Infura](https://infura.io) account if you don't have one already. Create a new Infura project or use an existing project. Note and copy the `PROJECT_ID`. The project id is 32 hexadecimal digits. 

![infura project id](images/infura_product_key.png)






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




Your terminal should look something like this:

![truffle test](images/truffle_compile.png)

This will create the smart contract artifacts in folder ```build\contracts```.

Migrate smart contracts to the locally running blockchain, ganache-cli:

```
truffle migrate
```

Your terminal should look something like this:

![truffle test](images/truffle_migrate.png)

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

## Built With

* [Ethereum](https://www.ethereum.org/) - Ethereum is a decentralized platform that runs smart contracts
* [IPFS](https://ipfs.io/) - IPFS is the Distributed Web | A peer-to-peer hypermedia protocol
to make the web faster, safer, and more open.
* [Truffle Framework](http://truffleframework.com/) - Truffle is the most popular development framework for Ethereum with a mission to make your life a whole lot easier.


## Acknowledgments

* Solidity
* Ganache-cli
* Truffle
* Infura
* IPFS
