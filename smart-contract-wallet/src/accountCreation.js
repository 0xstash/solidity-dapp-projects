import { generateMnemonic, mnemonicToEntropy } from "ethereum-cryptography/bip39/index.js";
import { wordlist } from "ethereum-cryptography/bip39/wordlists/english.js";
import { HDKey } from "ethereum-cryptography/hdkey.js";
import { keccak256 } from "ethereum-cryptography/keccak.js";
import { writeFileSync } from "fs";

const { bytesToHex } = require("ethereum-cryptography/utils");
const { getPublicKey } = require("ethereum-cryptography/secp256k1");
const { getDefaultProvider, Wallet } = require("ethers");

function _generateMnemonic() {
  const strength = 128;
  const mnemonic = generateMnemonic(wordlist, strength);
  const entropy = mnemonicToEntropy(mnemonic, wordlist);
  return { mnemonic, entropy };
}

function _getHdRootKey(_mnemonic) {
  return HDKey.fromMasterSeed(_mnemonic);
}

function _generatePrivateKey(_hdRootKey, _accountIndex) {
  return _hdRootKey.deriveChild(_accountIndex).privateKey;
}

function _getPublicKey(_privateKey) {
  return getPublicKey(_privateKey);
}

function _getEthAddress(_publicKey) {
  return keccak256(_publicKey).slice(-20);
}

function _store(_privateKey, _publicKey, _address) {
  const account = {
    privateKey: _privateKey,
    publicKey: _publicKey,
    address: _address,
  };
  const accountData = JSON.stringify(account);
  writeFileSync("account.json", accountData);
}

async function createAccount(network, factoryAddress) {
  const { mnemonic, entropy } = _generateMnemonic();
  console.log(`Seed Phrase: ${mnemonic}`);

  const hdRootKey = _getHdRootKey(entropy);
  const privateKey = _generatePrivateKey(hdRootKey, 0);
  const publicKey = _getPublicKey(privateKey);
  const address = _getEthAddress(publicKey);
  console.log(`Account address: 0x${bytesToHex(address)}`);

  _store(privateKey, publicKey, address);

  const provider = getDefaultProvider(network);
  const signer = new Wallet(privateKey, provider);
  const factory = ethers.getContractFactory("WalletFactory").connect(factoryAddress, signer);
  const walletAddress = factory.createWallet(signer.getAddress());
  console.log(`Wallet address: ${walletAddress}`);
}

createAccount(process.argv[2], process.argv[3])
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});