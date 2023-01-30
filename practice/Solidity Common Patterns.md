# Solidity Common Patterns

# EIPs

Some top ethereum improvement proposals

## Document

[https://medium.com/ngrave/top-ethereum-improvement-proposals-eips-explained-eip-20-eip-721-eip-1559-eip-3672-6f6a50c04b0a](https://medium.com/ngrave/top-ethereum-improvement-proposals-eips-explained-eip-20-eip-721-eip-1559-eip-3672-6f6a50c04b0a)

## Practice

### EIP-20 Token Standard

Based on the EIP-20 document, let's implement a token and deploy to Ethereum network. (*Please don’t use the Openzeppelin)*

### EIP-721 Non-Fungible Token Standard

Based on the EIP-721 document, let's implement an NFT token and deploy it to the Ethereum network, and view it in Opensea. (*Please don’t use the Openzeppelin)*


# Guard check

Using `require()` , `assert()` , `revert()` for guard check. 

## Document

[https://blog.logrocket.com/developers-guide-solidity-design-patterns/#guard-check](https://blog.logrocket.com/developers-guide-solidity-design-patterns/#guard-check)

# State machine

The state machine pattern simulates the behavior of a system based on its previous and current inputs. Developers use this approach to break down big problems into simple stages and transitions, which are then used to represent and control an application’s execution flow.

## Document

[https://blog.logrocket.com/developers-guide-solidity-design-patterns/#state-machine](https://blog.logrocket.com/developers-guide-solidity-design-patterns/#state-machine)

# Withdraw pattern (pull-over-push) pattern

The withdrawal pattern is also referred to as a **pull-over-push pattern**

This pattern allows ether or token to be removed from a contract by pull instead of push.

## Applicability

- Airdrop
- You want to avoid paying transaction fees.

## Document

[https://dev.to/jamiescript/design-patterns-in-solidity-1i28#withdrawal](https://dev.to/jamiescript/design-patterns-in-solidity-1i28#withdrawal)

## Practice

Implement a smart contract that only allows a white-label list of addresses can withdraw ETH / Token.

# Emergency Stop

Even heavily audited and tested code may contain bugs or defective code segments. Smart contracts are no exception to this. Often these bugs do not get discovered until they are used for an attack by an adversary. Once a critical flaw is discovered, it is hard to fix, because immutability is one of the core principles of the blockchain.

With the help of this pattern, we provide the possibility to pause a contract by blocking calls of critical functions, preventing attackers from continuing their work, 

## The applicability

- you want to have the ability to pause your contract.
- you want to guard critical functionality against the abuse of undiscovered bugs.
- you want to prepare your contract for potential failures.

## Document

[https://github.com/fravoll/solidity-patterns/blob/master/docs/emergency_stop.md](https://github.com/fravoll/solidity-patterns/blob/master/docs/emergency_stop.md)

# Factory creation pattern

A Contract Factory is a design pattern that creates contracts based on a template. Users can introduce values into a field which are used as input to initialize the state variables of the newly deployed contract

## The applicability

- Allow users to create liquidity pools: [Uniswap](https://docs.uniswap.org/protocol/V2/reference/smart-contracts/factory)
- Take advantage of Adidas 2 NFT mint limit per address: [Transaction](https://etherscan.io/tx/0x6a3d8584a6272a1d73ff297592b401fe10d3a90fd385efff55f68f32f29ecf61)
- Make interfaces to help users create their own tokens: [ThirdWeb](https://thirdweb.com/portal)
- [Others like: Business Process Management](https://www.researchgate.net/publication/303996559_Untrusted_Business_Process_Monitoring_and_Execution_Using_Blockchain) and [Health Care](https://arxiv.org/abs/1706.03700)

## Document

[https://medium.com/coinmonks/smart-contract-factories-how-to-create-a-contract-to-create-another-contract-248a120f331a](https://medium.com/coinmonks/smart-contract-factories-how-to-create-a-contract-to-create-another-contract-248a120f331a)

## Practice

Implement a simple liquidity pool smart contract.

- Users can add a new liquidity pair to the pool:
    - Select a pair of tokens
    - Enter fees for each transaction
- Users can swap a pair of tokens.

[What Are Liquidity Pools?](https://www.gemini.com/cryptopedia/what-is-a-liquidity-pool-crypto-market-liquidity)

[Uniswap V2 smart contract](https://docs.uniswap.org/contracts/v2/concepts/protocol-overview/smart-contracts)

# Meta Transaction

A *meta-transaction* is a regular Ethereum transaction that contains another transaction, the actual transaction. 

The actual transaction is signed by a user and then sent to an operator or something similar; no gas and blockchain interaction is required. 

The operator takes this signed transaction and submits it to the blockchain paying for the fees himself. 

The *forwarding* smart contract ensures there is a valid signature on the actual transaction and then executes it.

## Document

[https://medium.com/coinmonks/ethereum-meta-transactions-101-de7f91884a06](https://medium.com/coinmonks/ethereum-meta-transactions-101-de7f91884a06)

[https://betterprogramming.pub/ethereum-erc-20-meta-transactions-4cacbb3630ee](https://betterprogramming.pub/ethereum-erc-20-meta-transactions-4cacbb3630ee)

[https://coinsbench.com/how-to-get-started-with-gasless-meta-transactions-in-solidity-90e6d18f758](https://coinsbench.com/how-to-get-started-with-gasless-meta-transactions-in-solidity-90e6d18f758)

## Practice

Build a rely-on smart contract that supports end-users sending tokens/writing data to the Ethereum network without having ETH in their wallet.

# Other Solidity programming best practices

## Iterable map pattern

[https://solidity-by-example.org/app/iterable-mapping/](https://solidity-by-example.org/app/iterable-mapping/)

## **Free up unused storage**

[https://soliditydeveloper.com/design-pattern-solidity-free-up-unused-storage](https://soliditydeveloper.com/design-pattern-solidity-free-up-unused-storage)

## **Multiply before Dividing**

[https://soliditydeveloper.com/solidity-design-patterns-multiply-before-dividing](https://soliditydeveloper.com/solidity-design-patterns-multiply-before-dividing)

## Utilizing Bitmaps to dramatically save on Gas

[https://soliditydeveloper.com/bitmaps](https://soliditydeveloper.com/bitmaps)

# Other reading materials

[https://blog.logrocket.com/developers-guide-solidity-design-patterns/](https://blog.logrocket.com/developers-guide-solidity-design-patterns/)

[https://dev.to/jamiescript/design-patterns-in-solidity-1i28](https://dev.to/jamiescript/design-patterns-in-solidity-1i28)

[https://hackernoon.com/solidity-tutorial-understanding-design-patterns-part-1](https://hackernoon.com/solidity-tutorial-understanding-design-patterns-part-1)

[https://github.com/fravoll/solidity-patterns](https://github.com/fravoll/solidity-patterns)

[https://solidity-by-example.org/app/iterable-mapping/](https://solidity-by-example.org/app/iterable-mapping/)