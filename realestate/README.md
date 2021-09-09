# Udacity Blockchain Capstone

The capstone will build upon the knowledge you have gained in the course in order to build a decentralized housing product. 


For starting
- go to **https://github.com/abhayworld123/udcDapps/realestate**
Do npm install for installing all the dependencies

- For tests, used ganache , then on another terminal go to  **udcDapps\realestate\eth-contracts**, then type **truffle test**.


```
  Contract: TestERC721Mintable
    match erc721 spec
      √ should return total supply (379ms)
      √ should get token balance (645ms)
      √ should return token uri (223ms)
      √ should transfer token from one owner to another (1010ms)
  Contract: TestSolnSquareVerifier
    Can solutions be added or no
NewSolutionIsAdded
      √ Test if a new solution can be added for contract (529ms)
true
      √ Test if an ERC721 token can be minted for contract (4817ms)

  Contract: TestSquareVerifier
    Test cases Verification
[9,1]
one true
      √ correct proof (3946ms)
two false
      √ incorrect proof (2917ms)


  10 passing (1m)
```






```
$truffle version
	Truffle v5.1.61 (core: 5.1.61)
	Solidity - 0.5.7
	Node v14.12.0
	Web3.js v1.2.9
    Zokrates: 0.4.6
```

For Zokrates 

1. Start Docker Desktop
2. Execute following in terminal
```shell
cd /Users/xeuser/Desktop/blockchain_nanodegree/projects/final-project
docker run -v Your path/zokrates/code:/home/zokrates/code -ti zokrates/zokrates0.4.6 /bin/bash
cd code/square 

zokrates compile -i square.code     # compile
zokrates compute-witness -a 8 64    # Here we usually use a root and its square
zokrates generate-proof             # generate a proof of computation
zokrates export-verifier            # export a solidity verifier

used 
--proving-scheme pghr13
```


* In order to deploy my contracts on the Rinkeby Test Network, I used **truffle migrate --reset --network rinkeby**.

Summary
=======
> Total deployments:   3
> Final cost:          0.050587 ETH





Starting migrations...
======================
> Network name:    'rinkeby'
> Network id:      4
> Block gas limit: 30000000 (0x1c9c380)


1_initial_migration.js
======================
networks:::rinkeby
ac:::0x4224762D69b2E0Af39DEAB2395cEB38D2f4C2aBF

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x0808b3967de08e9a6407a8b9219b6aba98215bac72b6ca1823e7d2dd1edd004c
   > Blocks: 1            Seconds: 18
   > contract address:    0x9816b62E94a4AAC488Cd8e8aF0bE18bFa76825d3
   > block number:        9263516
   > block timestamp:     1631207084
   > account:             0x4224762D69b2E0Af39DEAB2395cEB38D2f4C2aBF
   > balance:             18.701453630001512
   > gas used:            224605 (0x36d5d)
   > gas price:           10 gwei
   > value sent:          0 ETH
   > total cost:          0.00224605 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00224605 ETH


2_deploy_contracts.js
=====================

   Deploying 'Verifier'
   --------------------
   > transaction hash:    0x4ca3714a55205b6f2f8fd8f4421d340d81527ba11a51eff54604773bf3d1b3eb
   > Blocks: 2            Seconds: 22
   > contract address:    0x71f17fF5eecE4722F8DB121e6ee9806d158dC6e1
   > block number:        9263519
   > block timestamp:     1631207129
   > account:             0x4224762D69b2E0Af39DEAB2395cEB38D2f4C2aBF
   > balance:             18.687072920001512
   > gas used:            1392308 (0x153eb4)
   > gas price:           10 gwei
   > value sent:          0 ETH
   > total cost:          0.01392308 ETH


   Deploying 'SolnSquareVerifier'
   ------------------------------
   > transaction hash:    0x5034a240af073ad1b22704f3025a87b7c8a9cbb50522427f41412b32788773ff
   > Blocks: 1            Seconds: 18
   > contract address:    0x591Adb44204299d960d1af41121c120C3FDb7dD8
   > block number:        9263521
   > block timestamp:     1631207159
   > account:             0x4224762D69b2E0Af39DEAB2395cEB38D2f4C2aBF
   > balance:             18.650697050001512
   > gas used:            3637587 (0x378153)
   > gas price:           10 gwei
   > value sent:          0 ETH
   > total cost:          0.03637587 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.05029895 ETH


Summary
=======
> Total deployments:   3
> Final cost:          0.052545 ETH




** Collection listed on OpenseaMarketPlace for sale **
https://testnets.opensea.io/collection/unidentified-contract-cdlkhbcgca

- **Original Owner:** 0x4224762D69b2E0Af39DEAB2395cEB38D2f4C2aBF

- **Purchased from (New Owner):**0xAcC782ac8165d33b9E91823826AA2fA49f3C8563

- **All tokens on RinkebyEtherscan**

https://rinkeby.etherscan.io/address/0x4224762d69b2e0af39deab2395ceb38d2f4c2abf#tokentxnsErc721

---**-----**

First purchase 
Tokenid 2
https://rinkeby.etherscan.io/tx/0x1fafa032d8c812162e002260eee73ee099e79f13af8c5b57b5c5514ca1dba2f1

Second puchase
Tokenid 9
https://rinkeby.etherscan.io/tx/0xc671644b88fb4cc66c99c3185e94d795302d0410603e200c3d4a8c89b4f6cc67

Third purchase
Tokenid 14
https://rinkeby.etherscan.io/tx/0x5fa221a9840578282a9574a35fb99f330bdb2f493da56c82597e7f702a05c836

Fourth purchase
Tkoen 8
https://rinkeby.etherscan.io/tx/0x3f0c1ccb88a9b8f7b9d9a3a1678274ed73d5353788027394759228e1cf0b46a4

Fifth purchase 
Tokenid 1
https://rinkeby.etherscan.io/tx/0xb380dc3a17bbd25eed262e25d35fdc7acd190e2d752ae93237fa1bd219460037






# Project Resources

* [Remix - Solidity IDE](https://remix.ethereum.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Truffle Framework](https://truffleframework.com/)
* [Ganache - One Click Blockchain](https://truffleframework.com/ganache)
* [Open Zeppelin ](https://openzeppelin.org/)
* [Interactive zero knowledge 3-colorability demonstration](http://web.mit.edu/~ezyang/Public/graph/svg.html)
* [Docker](https://docs.docker.com/install/)
* [ZoKrates](https://github.com/Zokrates/ZoKrates)
