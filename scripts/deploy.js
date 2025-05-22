const hre = require("hardhat");

async function main() {
  console.log("Deploying NFT Marketplace to Core Testnet 2...");

  // Get the contract factory
  const NFTMarketplace = await hre.ethers.getContractFactory("NFTMarketplace");

  // Deploy the contract
  console.log("Deploying contract...");
  const nftMarketplace = await NFTMarketplace.deploy();

  // Wait for deployment to complete
  await nftMarketplace.waitForDeployment();

  const contractAddress = await nftMarketplace.getAddress();
  
  console.log("✅ NFT Marketplace deployed successfully!");
  console.log("📍 Contract Address:", contractAddress);
  console.log("🌐 Network: Core Testnet 2");
  console.log("🔗 RPC URL: https://rpc.test2.btcs.network");
  
  // Get deployment transaction details
  const deploymentTx = nftMarketplace.deploymentTransaction();
  if (deploymentTx) {
    console.log("📄 Deployment Transaction Hash:", deploymentTx.hash);
    console.log("⛽ Gas Used:", deploymentTx.gasLimit?.toString());
  }

  // Verify initial contract state
  const listingPrice = await nftMarketplace.getListingPrice();
  console.log("💰 Initial Listing Price:", hre.ethers.formatEther(listingPrice), "CORE");
  
  console.log("\n🚀 Contract is ready for interaction!");
  console.log("You can now:");
  console.log("1. List NFTs for sale using createMarketItem()");
  console.log("2. Purchase NFTs using createMarketSale()");
  console.log("3. Fetch available items using fetchMarketItems()");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:");
    console.error(error);
    process.exit(1);
  });
