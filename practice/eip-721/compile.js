const path = require("path");
const fs = require("fs");
const solc = require("solc");

const eip721Path = path.resolve(__dirname, "contracts", "index.sol");
const source = fs.readFileSync(eip721Path, "utf8");
const contract = solc.compile(source, 1).contracts[":ERC721"]
module.exports = contract;
