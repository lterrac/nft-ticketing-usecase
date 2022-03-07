# nft-ticketing-usecase
In this repo there are 3 different Smart Contract for the Paaspo PoC.

- Marketplace1155.sol
- Mint1155_factory.sol
- Mint1155.sol
- Refunded.sol
- GetInfected.sol

 The Iexec_Abstract.sol is composed by two contracts. The first one defined is an abstract contract in which the function to retrieve the data is defined. ( At the moment only getInt is implemented because is the only function needed for the Vaccine Counter Oracle). The second contract of the Iexec_Abstract.sol is used to make the actual oracle call to the Vaccine Counter Oracle. 
The Marketplace.sol contract orchestarte the Buy and Sell Operations of the marketplace, while emitting events that will be retrieve bu the Web3App in order to organize the front end.
The Mint_721_Collection.sol is used to mint a new erc-721 collection. This Contract is composed by two contracts in order to deploy different collection from one contract address. This auto-deployment feature was needed in order managing the Dapp back end
