// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/utils/ERC1155Receiver.sol";

contract marketPlace1155 is ReentrancyGuard, ERC1155Receiver {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemsSold;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct MarketItem {
        uint256 itemId;
        address nftContract;
        uint256 tokenIds;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    mapping(uint256 => MarketItem) private idToMarketItem;

    event MarketItemCreated(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenIds,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    event MarketItemSold(uint256 indexed itemId, address owner);

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function createMarketItem(
        address nftContract,
        uint256[] memory tokenIds,
        uint256 price,
        uint256[] memory amounts
    ) public payable nonReentrant {
        require(price > 0, "Price must be greater than 0");

        IERC1155(nftContract).safeBatchTransferFrom(
            msg.sender,
            address(this),
            tokenIds,
            amounts,
            ""
        );

        for (uint256 i = 0; i <= (tokenIds.length - 1); i++) {
            _itemIds.increment();
            uint256 itemId = _itemIds.current();

            idToMarketItem[itemId] = MarketItem(
                itemId,
                nftContract,
                tokenIds[i],
                payable(msg.sender),
                payable(address(0)),
                price,
                false
            );

            emit MarketItemCreated(
                itemId,
                nftContract,
                tokenIds[i],
                msg.sender,
                address(0),
                price,
                false
            );
        }
    }

    function createMarketSale(
        address nftContract,
        uint256 itemId,
        uint256[] memory _tokenIds,
        uint256[] memory amounts
    ) public payable nonReentrant {
        uint256 price = idToMarketItem[itemId].price;

        bool sold = idToMarketItem[itemId].sold;
        require(
            msg.value == price,
            "Please submit the asking price in order to complete the purchase"
        );
        require(sold != true, "This Sale has alredy finished");
        emit MarketItemSold(itemId, msg.sender);

        idToMarketItem[itemId].seller.transfer(msg.value);
        IERC1155(nftContract).safeBatchTransferFrom(
            address(this),
            msg.sender,
            _tokenIds,
            amounts,
            ""
        );
        idToMarketItem[itemId].owner = payable(msg.sender);
        _itemsSold.increment();
        idToMarketItem[itemId].sold = true;
    }

    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _itemIds.current();
        uint256 unsoldItemCount = _itemIds.current() - _itemsSold.current();
        uint256 currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(0)) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
}
