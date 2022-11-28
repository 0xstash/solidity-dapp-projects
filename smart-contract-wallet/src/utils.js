import { getDefaultProvider, Wallet, utils } from "ethers";
import { readFileSync } from "fs";

import { Wallet__factory } from "../typechain-types/factories/contracts/Wallet__factory";


function getWallet(address, network) {
    const provider = getDefaultProvider(network);

    const accountRawData = readFileSync("account.json", "utf8");
    const accountData = JSON.parse(accountRawData);
    const privateKey = Object.values(accountData.privateKey);

    const signer = new Wallet(privateKey, provider);
    const wallet = Wallet__factory.connect(address, signer);

    return wallet;
}