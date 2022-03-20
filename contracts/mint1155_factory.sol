// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import 1155 token contract from Openzeppelin

import "./mint1155.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract PaasPopTickets {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    address public owner;

    constructor() {}

    event ContractCreated(
        address newAddress,
        string metadata,
        string name,
        string image,
        address owner,
        bool refunded,
        uint256 maxInfected,
        uint256 itemID
    );

    function deployCollection(
        string memory uri,
        uint256[] memory ids,
        uint256[] memory amount,
        string memory name,
        string memory image,
        uint256 maxInfected
    ) public {
        _itemIds.increment();
        uint256 itemId = _itemIds.current();

        // qui chi chiama la funzione (chiunque potenzialmente) diventa owner della factory. Non penso sia corretto proporrei piuttosto che solo l'owner del contratto possa chiamare deployCollection(). A questo punto inizializzerei owner nel costruttore
        owner = msg.sender;

        // Vedendo questa riga forse non serve un owner della factory
        NFTContract Collection = new NFTContract(uri, ids, amount, owner);
        emit ContractCreated(
            address(Collection),
            uri,
            name,
            image,
            owner,
            false,
            maxInfected,
            itemId
        );
    }
}
 