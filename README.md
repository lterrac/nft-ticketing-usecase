# nft-ticketing-usecase
In this repo there are 4 different Smart Contract for the Paaspo PoC.

- Marketplace.sol
- Mint_721_Collection.sol
- Iexec_Oracle_Call.sol
- Iexec_Abstract.sol

Two of them are related to the iexec oracle call. The Abstract Contract defines the function that an be used to retrieve data while the actual oracle call is made in the Iexec_Oracle_call.sol. The Marketplace.sol contract orchestrate the Sale and Buy operation in the marketplace.
The Mint_721_Collection.sol is used to mint a new erc-721 collection.
