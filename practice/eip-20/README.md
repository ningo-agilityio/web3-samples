# AVAILABLE COMMANDS

| Command          | Action                                                                         |
| :--------------- | :----------------------------------------------------------------------------- |
| `npx hardhat run deploy.js`   | Deploy the smart contract                                                          |

# ISSUES
## Compile with solidity 0.4.21: [link](https://stackoverflow.com/questions/53622973/i-get-a-parser-error-expected-identifier-got-lparen-constructor-in-remix)

**Error**: 

```
contracts/index.sol:61:14: ParserError: Expected identifier, got 'LParen'
  constructor(uint256 _initialAmount) {
             ^

Error HH600: Compilation failed
```

**Solution**: Upgrade version of solidity to 0.4.25
