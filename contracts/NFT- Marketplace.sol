// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ReentrancyGuard, Ownable {
    // State variables
    uint256 private _itemIds;
    uint256 private _itemsSold;
    
    uint256 public listingPrice = 0.025 ether;
    
    struct MarketItem {
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }
    
    mapping(uint256 => MarketItem) private idToMarketItem;
    
    // Events
    event MarketItemCreated(
        uint256 indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );
    
    event MarketItemSold(
        uint256 indexed itemId,
        address indexed buyer,
        uint256 price
    );
    
    constructor() Ownable(msg.sender) {}
    
    /**
     * @dev Core Function 1: List NFT for sale
     * @param nftContract Address of the NFT contract
     * @param tokenId Token ID of the NFT
     * @param price Price in wei
     */
    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        require(price > 0, "Price must be greater than 0");
        require(msg.value == listingPrice, "Must pay listing price");
        
        _itemIds++;
        uint256 itemId = _itemIds;
        
        idToMarketItem[itemId] = MarketItem(
            itemId,
            nftContract,
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );
        
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        
        emit MarketItemCreated(
            itemId,
            nftContract,
            tokenId,
            msg.sender,
            address(0),
            price,
            false
        );
    }
    
    /**
     * @dev Core Function 2: Purchase NFT from marketplace
     * @param itemId ID of the market item
     */
    function createMarketSale(uint256 itemId) public payable nonReentrant {
        uint256 price = idToMarketItem[itemId].price;
        uint256 tokenId = idToMarketItem[itemId].tokenId;
        address nftContract = idToMarketItem[itemId].nftContract;
        
        require(msg.value == price, "Must submit the asking price");
        require(!idToMarketItem[itemId].sold, "Item already sold");
        
        idToMarketItem[itemId].seller.transfer(msg.value);
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        
        idToMarketItem[itemId].owner = payable(msg.sender);
        idToMarketItem[itemId].sold = true;
        _itemsSold++;
        
        payable(owner()).transfer(listingPrice);
        
        emit MarketItemSold(itemId, msg.sender, price);
    }
    
    /**
     * @dev Core Function 3: Get all unsold market items
     * @return Array of unsold market items
     */
    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _itemIds;
        uint256 unsoldItemCount = _itemIds - _itemsSold;
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
    
    // Additional utility functions
    function fetchMyNFTs() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _itemIds;
        uint256 itemCount = 0;
        uint256 currentIndex = 0;
        
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }
        
        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
    
    function fetchItemsCreated() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _itemIds;
        uint256 itemCount = 0;
        uint256 currentIndex = 0;
        
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }
        
        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
    
    function updateListingPrice(uint256 _listingPrice) public onlyOwner {
        listingPrice = _listingPrice;
    }
    
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }
}
