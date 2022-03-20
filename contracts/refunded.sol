// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4; //teniamo la stessa versione di solidity?
import "./totalhosp.sol"; //questo file non c'e'
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract Refunded is APIConsumer {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;

    constructor() {}

    struct RefundParameters {
        uint256 itemId;
        address nftContract;
        address owner;
        uint256 price;
        uint256 maxInfection;
        bool refunded;
    }

    mapping(uint256 => RefundParameters) private idRefundParameters;

    function addRefundParameters(
        address nftContract,
        uint256 maxInfection,
        uint256 price,
        uint256 itemId // perche' un singolo item id? l'item e' il singolo biglietto la tipologia?
    ) public {
        // chi chiama questa funzione?
        // Posso chiamare questa funzione per conto di qualcun altro?
        // Esempio: B ha un biglietto, A puo' chiamare questa funzione per il biglietto di B?
        // il price lo sceglie chi chiama questa funzione?
        require(idRefundParameters[itemId].itemId == (0));
        require(
            idRefundParameters[itemId].owner ==
                (0x0000000000000000000000000000000000000000) // address(0)?
        );
        require(
            idRefundParameters[itemId].nftContract ==
                (0x0000000000000000000000000000000000000000)
        );
        idRefundParameters[itemId] = RefundParameters(
            itemId,
            nftContract,
            (msg.sender), //chi lo chiama?
            price,
            maxInfection,
            false
        );
    }

    // come mai abbiamo solo un itemId?
    // chi sono i clients?
    function refundUsers(address payable[] memory clients, uint256 itemId)
        public
        payable
    {
        uint256 length = clients.length;
        require(idRefundParameters[itemId].owner == msg.sender);
        require(idRefundParameters[itemId].refunded == false);
        require(APIConsumer.volume <= idRefundParameters[itemId].maxInfection); // non dovremmo fare il refund quando i contagiati sono sopra a una certa soglia?
        idRefundParameters[itemId].refunded = true;
        for (uint256 i = 0; i < length; i++)
            // questa for puo' andare in out of gas
            // da dove arrivano i soldi? dovrebbero essere contenuti nella transazione -> serve un controllo che nella transazione ci siano soldi per tutti i clients
            // se i clients sono troppi? posso farlo due volte
            clients[i].transfer(idRefundParameters[itemId].price);
    }

    function fetchParameters(uint256 itemId)
        public
        view
        returns (RefundParameters memory)
    {
        //  uint itemCount = _itemIds.current(); //possiamo toglierlo?

        return idRefundParameters[itemId];
    }
}
