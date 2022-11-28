const { mnemonicToEntropy } = require("ethereum-cryptography/bip39");
const { wordlist } = require("ethereum-cryptography/bip39/wordlists/english");
const { HDKey } = require("ethereum-cryptography/hdkey");
const { getPublicKey } = require("ethereum-cryptography/secp256k1");
const { keccak256 } = require("ethereum-cryptography/keccak");
const { writeFileSync } = require("fs");

async function restoreAccount(_mnemonic) {
  const entropy = mnemonicToEntropy(_mnemonic, wordlist);
  const hdRootKey = HDKey.fromMasterSeed(entropy);
  const privateKey = hdRootKey.deriveChild(0).privateKey;
  const publicKey = getPublicKey(privateKey);
  const address = keccak256(publicKey).slice(-20);
  console.log('Address: 0x${bytesToHex(address)}');

  const account = {
    privateKey: privateKey,
    publicKey: publicKey,
    address: address,
  };
  const accountData = JSON.stringify(account);
  writeFileSync("account.json", accountData);
}

restoreAccount(process.argv[2])
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});