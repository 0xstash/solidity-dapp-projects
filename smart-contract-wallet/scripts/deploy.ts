import { ethers } from "hardhat";

async function main() {
  const WalletFactory = await ethers.getContractFactory("WalletFactory");
  const factory = await WalletFactory.deploy();
  await factory.deployed();
  console.log(`Deployed to ${factory.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
