/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../common";
import type { Swap, SwapInterface } from "../../contracts/Swap";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_tokenIn",
        type: "address",
      },
      {
        internalType: "address",
        name: "_tokenOut",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_amountIn",
        type: "uint256",
      },
    ],
    name: "getAmountOutMin",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "_tokenIn",
        type: "address",
      },
      {
        internalType: "address",
        name: "_tokenOut",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_amountIn",
        type: "uint256",
      },
    ],
    name: "swap",
    outputs: [
      {
        internalType: "uint256[]",
        name: "amounts",
        type: "uint256[]",
      },
    ],
    stateMutability: "payable",
    type: "function",
  },
];

const _bytecode =
  "0x6080604052737a250d5630b4cf539739df2c5dacb4c659f2488d6000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555034801561006457600080fd5b50610df1806100746000396000f3fe6080604052600436106100295760003560e01c80633c50eec11461002e578063df791e501461006b575b600080fd5b34801561003a57600080fd5b50610055600480360381019061005091906106bd565b61009b565b604051610062919061071f565b60405180910390f35b610085600480360381019061008091906106bd565b610261565b60405161009291906107f8565b60405180910390f35b600080600267ffffffffffffffff8111156100b9576100b861081a565b5b6040519080825280602002602001820160405280156100e75781602001602082028036833780820191505090505b50905084816000815181106100ff576100fe610849565b5b602002602001019073ffffffffffffffffffffffffffffffffffffffff16908173ffffffffffffffffffffffffffffffffffffffff1681525050838160018151811061014e5761014d610849565b5b602002602001019073ffffffffffffffffffffffffffffffffffffffff16908173ffffffffffffffffffffffffffffffffffffffff168152505060008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663d06ca61f85846040518363ffffffff1660e01b81526004016101e6929190610936565b600060405180830381865afa158015610203573d6000803e3d6000fd5b505050506040513d6000823e3d601f19601f8201168201806040525081019061022c9190610aa5565b9050806001835161023d9190610b1d565b8151811061024e5761024d610849565b5b6020026020010151925050509392505050565b60608373ffffffffffffffffffffffffffffffffffffffff166323b872dd3330856040518463ffffffff1660e01b81526004016102a093929190610b60565b6020604051808303816000875af11580156102bf573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906102e39190610bcf565b610322576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161031990610c7f565b60405180910390fd5b8373ffffffffffffffffffffffffffffffffffffffff1663095ea7b3737a250d5630b4cf539739df2c5dacb4c659f2488d846040518363ffffffff1660e01b8152600401610371929190610c9f565b6020604051808303816000875af1158015610390573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906103b49190610bcf565b6103f3576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016103ea90610d14565b60405180910390fd5b6000600267ffffffffffffffff8111156104105761040f61081a565b5b60405190808252806020026020018201604052801561043e5781602001602082028036833780820191505090505b509050848160008151811061045657610455610849565b5b602002602001019073ffffffffffffffffffffffffffffffffffffffff16908173ffffffffffffffffffffffffffffffffffffffff168152505083816001815181106104a5576104a4610849565b5b602002602001019073ffffffffffffffffffffffffffffffffffffffff16908173ffffffffffffffffffffffffffffffffffffffff168152505060003073ffffffffffffffffffffffffffffffffffffffff16633c50eec18787876040518463ffffffff1660e01b815260040161051e93929190610b60565b602060405180830381865afa15801561053b573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061055f9190610d34565b905060008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166338ed173985838533426040518663ffffffff1660e01b81526004016105c2959493929190610d61565b6000604051808303816000875af11580156105e1573d6000803e3d6000fd5b505050506040513d6000823e3d601f19601f8201168201806040525081019061060a9190610aa5565b925050509392505050565b6000604051905090565b600080fd5b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b600061065482610629565b9050919050565b61066481610649565b811461066f57600080fd5b50565b6000813590506106818161065b565b92915050565b6000819050919050565b61069a81610687565b81146106a557600080fd5b50565b6000813590506106b781610691565b92915050565b6000806000606084860312156106d6576106d561061f565b5b60006106e486828701610672565b93505060206106f586828701610672565b9250506040610706868287016106a8565b9150509250925092565b61071981610687565b82525050565b60006020820190506107346000830184610710565b92915050565b600081519050919050565b600082825260208201905092915050565b6000819050602082019050919050565b61076f81610687565b82525050565b60006107818383610766565b60208301905092915050565b6000602082019050919050565b60006107a58261073a565b6107af8185610745565b93506107ba83610756565b8060005b838110156107eb5781516107d28882610775565b97506107dd8361078d565b9250506001810190506107be565b5085935050505092915050565b60006020820190508181036000830152610812818461079a565b905092915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b600081519050919050565b600082825260208201905092915050565b6000819050602082019050919050565b6108ad81610649565b82525050565b60006108bf83836108a4565b60208301905092915050565b6000602082019050919050565b60006108e382610878565b6108ed8185610883565b93506108f883610894565b8060005b8381101561092957815161091088826108b3565b975061091b836108cb565b9250506001810190506108fc565b5085935050505092915050565b600060408201905061094b6000830185610710565b818103602083015261095d81846108d8565b90509392505050565b600080fd5b6000601f19601f8301169050919050565b6109858261096b565b810181811067ffffffffffffffff821117156109a4576109a361081a565b5b80604052505050565b60006109b7610615565b90506109c3828261097c565b919050565b600067ffffffffffffffff8211156109e3576109e261081a565b5b602082029050602081019050919050565b600080fd5b600081519050610a0881610691565b92915050565b6000610a21610a1c846109c8565b6109ad565b90508083825260208201905060208402830185811115610a4457610a436109f4565b5b835b81811015610a6d5780610a5988826109f9565b845260208401935050602081019050610a46565b5050509392505050565b600082601f830112610a8c57610a8b610966565b5b8151610a9c848260208601610a0e565b91505092915050565b600060208284031215610abb57610aba61061f565b5b600082015167ffffffffffffffff811115610ad957610ad8610624565b5b610ae584828501610a77565b91505092915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b6000610b2882610687565b9150610b3383610687565b9250828203905081811115610b4b57610b4a610aee565b5b92915050565b610b5a81610649565b82525050565b6000606082019050610b756000830186610b51565b610b826020830185610b51565b610b8f6040830184610710565b949350505050565b60008115159050919050565b610bac81610b97565b8114610bb757600080fd5b50565b600081519050610bc981610ba3565b92915050565b600060208284031215610be557610be461061f565b5b6000610bf384828501610bba565b91505092915050565b600082825260208201905092915050565b7f546f6b656e7320636f756c64206e6f74206265207472616e736665727265642060008201527f66726f6d207468652073656e6465720000000000000000000000000000000000602082015250565b6000610c69602f83610bfc565b9150610c7482610c0d565b604082019050919050565b60006020820190508181036000830152610c9881610c5c565b9050919050565b6000604082019050610cb46000830185610b51565b610cc16020830184610710565b9392505050565b7f417070726f76616c2072657175657374206661696c6564000000000000000000600082015250565b6000610cfe601783610bfc565b9150610d0982610cc8565b602082019050919050565b60006020820190508181036000830152610d2d81610cf1565b9050919050565b600060208284031215610d4a57610d4961061f565b5b6000610d58848285016109f9565b91505092915050565b600060a082019050610d766000830188610710565b610d836020830187610710565b8181036040830152610d9581866108d8565b9050610da46060830185610b51565b610db16080830184610710565b969550505050505056fea26469706673582212204bf3b19e2c8edf7190a101434800d998155f35c730f0a6dae43de65e1f3b780364736f6c63430008110033";

type SwapConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: SwapConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Swap__factory extends ContractFactory {
  constructor(...args: SwapConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<Swap> {
    return super.deploy(overrides || {}) as Promise<Swap>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): Swap {
    return super.attach(address) as Swap;
  }
  override connect(signer: Signer): Swap__factory {
    return super.connect(signer) as Swap__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): SwapInterface {
    return new utils.Interface(_abi) as SwapInterface;
  }
  static connect(address: string, signerOrProvider: Signer | Provider): Swap {
    return new Contract(address, _abi, signerOrProvider) as Swap;
  }
}