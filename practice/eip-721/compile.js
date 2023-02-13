const path = require("path");
const fs = require("fs");
const solc = require("solc");

const eip721Path = path.resolve(__dirname, "contracts", "index.sol");
const source = fs.readFileSync(eip721Path, "utf8");

const input = {
  language: 'Solidity',
  sources: {
    'index.sol': {
      content: source
    }
  },
  settings: {
    outputSelection: {
      '*': {
        '*': [ '*' ]
      }
    }
  }
}   

function findImports (path) {
  if (path === 'index.sol')
    return { contents: source }
  else
    return { error: 'File not found' }
}

const output = JSON.parse(solc.compile(JSON.stringify(input), findImports));
const contracts = output.contracts['index.sol']["ERC721"]

module.exports = {
  abi: contracts.abi,
  bytecode: contracts.evm.bytecode.object,
};

