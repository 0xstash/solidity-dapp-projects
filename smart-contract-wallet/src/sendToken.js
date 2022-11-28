import { getWallet } from "./utils.js"


async function sendToken(address, network, target, tokenAddress, amount) {
  const wallet = getWallet(address, network);
  await wallet.sendToken(amount, target, tokenAddress);
}

sendToken(process.argv[2], process.argv[3], process.argv[4], process.argv[5], process.argv[6])
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});