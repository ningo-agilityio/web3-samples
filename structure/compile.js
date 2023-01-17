const path = require("path");
const fs = require("fs");
const solc = require("solc");

const eip20Path = path.resolve(__dirname, "eip-20", "contracts", "index.sol");
const source = fs.readFileSync(eip20Path, "utf8");
const contract = solc.compile(source, 1).contracts[":EIP20"]
module.exports = contract;
