var ERC721MintableComplete = artifacts.require('AbERC721Token');

contract('TestERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];

    const baseurl = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/" 

    describe('match erc721 spec', function () {
        beforeEach(async function () { 
             this.contract = await ERC721MintableComplete.new('RealEstateToken', 'RST', baseurl, { from: account_one });

            // TODO: mint multiple tokens

            await this.contract.mint(account_one, 1, {from: account_one});
            await this.contract.mint(account_one, 2, {from: account_one});
            await this.contract.mint(account_one, 5, {from: account_one});
            await this.contract.mint(account_one, 7, {from: account_one});
            await this.contract.mint(account_one, 8, {from: account_one});
            await this.contract.mint(account_one, 9, {from: account_one});
            await this.contract.mint(account_one, 11, {from: account_one});
            await this.contract.mint(account_one, 12, {from: account_one});
            await this.contract.mint(account_one, 14, {from: account_one});
            await this.contract.mint(account_two, 320, {from: account_one});








        })

        it('should return total supply', async function () { 

            let resTokens = await this.contract.totalSupply.call();
            assert.equal(resTokens.toNumber(), 10, 'Total token supply not proper');
        })

        it('should get token balance', async function () { 
            let firstAcc_tokenBalance = await this.contract.balanceOf.call(account_one);
            let secAcc_tokenBalance = await this.contract.balanceOf.call(account_two);
            assert.equal(firstAcc_tokenBalance.toNumber(), 9, 'Sorry balance not correct for first account');
            assert.equal(secAcc_tokenBalance.toNumber(), 1, 'Sorry balance not correct for second account');
        })

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('should return token uri', async function () { 
            let tokenUri = await this.contract.tokenURI.call(320, { from: account_two });
            let expectedUri = "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/320";
            assert.equal(tokenUri, expectedUri, 'token uri incorrect');
        })

        it('should transfer token from one owner to another', async function () { 
            await this.contract.transferFrom(account_one, account_two, 2, {from: account_one});
            const newTokenOwner = await this.contract.ownerOf.call(2);
            assert.equal(newTokenOwner, account_two, 'Token not transferred correctly');


        })
    });

    describe('have ownership properties', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new('RealEstateToken2', 'RST1', baseurl, { from: account_one });
        })

        it('should fail when minting when address is not contract owner', async function () { 
            
            try{
                await this.contract.mint(account_one, 2, {from: account_two});
            }
            catch(error){
                assert.equal(error.reason, "wrong owner");

            }

        })

        it('should return contract owner', async function () { 
            let ContractOwner = await this.contract.getter_owner.call();
            assert.equal(ContractOwner, account_one, 'Contract owner not genuine');
        })

    });
})