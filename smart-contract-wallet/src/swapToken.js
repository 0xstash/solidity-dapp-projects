import { getWallet } from "./utils.js"


async function swapToken(address, network, amount, tokenIn, tokenOut) {
  const wallet = getWallet(address, network);
  await wallet.swapToken(amount, tokenIn, tokenOut);
}

swapToken(process.argv[2], process.argv[3], process.argv[4], process.argv[5], process.argv[6])
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});