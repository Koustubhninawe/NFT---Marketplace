# NFT Marketplace

## Project Description

NFT Marketplace is a decentralized marketplace smart contract built on Solidity that enables users to buy, sell, and trade Non-Fungible Tokens (NFTs) in a trustless environment. The marketplace provides a secure platform where creators can list their NFTs for sale, and collectors can purchase them directly through smart contract interactions, eliminating the need for intermediaries.

The contract implements core marketplace functionality including NFT listing, purchasing mechanisms, and comprehensive item management. Built with security best practices using OpenZeppelin libraries, it ensures safe transactions and prevents common vulnerabilities like reentrancy attacks.

## Project Vision

Our vision is to democratize digital asset trading by creating an accessible, secure, and decentralized NFT marketplace that empowers creators and collectors worldwide. We aim to build a platform that:

- **Empowers Creators**: Provides artists and content creators with direct access to global markets without traditional gatekeepers
- **Ensures Security**: Implements robust security measures to protect user assets and maintain transaction integrity
- **Promotes Decentralization**: Operates without central authority, giving users full control over their digital assets
- **Fosters Innovation**: Creates an ecosystem that encourages creative expression and digital art innovation
- **Builds Community**: Connects creators, collectors, and enthusiasts in a vibrant digital marketplace

## Key Features

### Core Functionality
- **NFT Listing**: List any ERC-721 NFT for sale with custom pricing
- **Secure Purchasing**: Buy NFTs with automatic escrow and ownership transfer
- **Market Overview**: Browse all available NFTs in the marketplace
- **Portfolio Management**: View owned NFTs and created listings

### Security Features
- **Reentrancy Protection**: Prevents malicious contract attacks
- **Access Control**: Owner-only functions for administrative tasks
- **Safe Transfers**: Secure NFT and ETH transfer mechanisms
- **Input Validation**: Comprehensive checks for all user inputs

### Smart Contract Features
- **Gas Optimized**: Efficient code structure to minimize transaction costs
- **Event Logging**: Comprehensive event emission for frontend integration
- **Modular Design**: Clean, maintainable code architecture
- **OpenZeppelin Integration**: Utilizes battle-tested security libraries

### User Experience
- **Simple Interface**: Easy-to-use functions for all marketplace operations
- **Transparent Fees**: Clear listing fee structure (0.025 ETH)
- **Real-time Updates**: Instant marketplace state updates
- **Multi-wallet Support**: Compatible with various Ethereum wallets

## Future Scope

### Phase 1: Enhanced Features
- **Auction System**: Implement timed auctions with automatic settlement
- **Royalty Distribution**: Automatic creator royalties on secondary sales
- **Collection Support**: Organized NFT collections and series
- **Advanced Filtering**: Search and filter by price, category, and creator

### Phase 2: DeFi Integration
- **Fractional Ownership**: Enable shared ownership of high-value NFTs
- **NFT Staking**: Stake NFTs to earn marketplace tokens
- **Lending Protocol**: Use NFTs as collateral for loans
- **Yield Farming**: Liquidity mining for marketplace participants

### Phase 3: Cross-Chain Expansion
- **Multi-Chain Support**: Expand to Polygon, BSC, and other networks
- **Bridge Integration**: Cross-chain NFT transfers and trading
- **Layer 2 Solutions**: Implement on Arbitrum and Optimism for lower fees

### Phase 4: Advanced Ecosystem
- **Creator Tools**: Built-in minting and metadata management
- **Social Features**: User profiles, following, and social interactions
- **Analytics Dashboard**: Trading statistics and market insights
- **Mobile Application**: Native mobile app for iOS and Android

### Phase 5: Enterprise Solutions
- **White-label Platform**: Customizable marketplace for businesses
- **API Integration**: RESTful APIs for third-party integrations
- **Enterprise Support**: Dedicated support for large-scale implementations
- **Compliance Tools**: KYC/AML integration for regulated markets

## Installation & Setup

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd nft-marketplace
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Environment Setup**
   ```bash
   cp .env.example .env
   # Add your private key to .env file
   ```

4. **Compile Contracts**
   ```bash
   npm run compile
   ```

5. **Deploy to Core Testnet 2**
   ```bash
   npm run deploy
   ```

## Usage

### Contract Interaction

#### Listing an NFT
```solidity
// Approve marketplace to transfer your NFT first
nftContract.approve(marketplaceAddress, tokenId);

// List NFT for sale
marketplace.createMarketItem(nftContract, tokenId, price, {value: listingPrice});
```

#### Purchasing an NFT
```solidity
// Purchase NFT by sending exact price
marketplace.createMarketSale(itemId, {value: price});
```

#### Viewing Marketplace Items
```solidity
// Get all available items
MarketItem[] memory items = marketplace.fetchMarketItems();
```

## Smart Contract Architecture

### Core Functions
1. **createMarketItem()**: List NFT for sale with listing fee
2. **createMarketSale()**: Purchase NFT from marketplace
3. **fetchMarketItems()**: Retrieve all unsold marketplace items

### Security Measures
- ReentrancyGuard from OpenZeppelin
- Ownable access control
- Input validation and error handling
- Safe transfer mechanisms

## Testing & Development

### Run Tests
```bash
npm run test
```

### Local Development
```bash
# Start local Hardhat node
npm run node

# Deploy to local network
npm run deploy:local
```

## Network Configuration

- **Network**: Core Testnet 2
- **RPC URL**: https://rpc.test2.btcs.network
- **Chain ID**: 1115
- **Currency**: CORE

## Contributing

We welcome contributions from the community! Please read our contribution guidelines and submit pull requests for any improvements.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact & Support

For questions, support, or partnership inquiries, please reach out through our official channels or create an issue in the repository.
![image](https://github.com/user-attachments/assets/907f8fe4-b758-45f8-b07f-d83856090cfa)
