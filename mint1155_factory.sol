// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import 1155 token contract from Openzeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract PaasPopTickets {

  address public owner;

    constructor() {

     }    

 function deployCollection(string memory uri, uint256 quantity)
        public
        returns(address)

    {
        owner = msg.sender; 
    new NFTContract (quantity, uri, owner);  

    }

}

contract NFTContract is ERC1155, Ownable {
    using SafeMath for uint256;

    constructor(
         uint256 quantity,
         string memory uri,
         address owner
    )
        ERC1155( uri
            // "https://ipfs.moralis.io:2053/ipfs/QmS7izjgMprD3ZvP8aDBRiXbMZnxBsrUK4PJTwkcDFauij" 
            )
    {

   for ( uint i=0; i < quantity; i++) { 

        _mint(owner, i, 1, "");
    }
    }


}


///************************************* Da valutare se conviene usare questo contratto con il batchmint al posto del ciclo for *******************************************


//pragma solidity ^0.8.0;


// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


// contract PaasPopTickets {

//   address public owner;

//     constructor() {
        
//      }    
     
//  function deployCollection(string memory uri,uint256[] memory ids, uint256[] memory amount)
//         public
//         returns(address)
        
//     {
//         owner = msg.sender; 
//     new NFTContract ( uri, ids,amount,owner);  
      
//     }

// }

// contract NFTContract is ERC1155, Ownable {
//     using SafeMath for uint256;

//     constructor(
         
//          string memory uri,
//          uint256[] memory ids,
//          uint256[] memory amount,
//          address owner
//     )
//         ERC1155( uri
//             // "https://ipfs.moralis.io:2053/ipfs/QmS7izjgMprD3ZvP8aDBRiXbMZnxBsrUK4PJTwkcDFauij" 
//             )
//     {
        

//   _mintBatch(owner, ids,amount,"");
//     }


// }

