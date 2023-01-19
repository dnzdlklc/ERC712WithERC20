# Sample Hardhat Project

This contract uses the SafeERC721 and SafeERC20 contracts from the OpenZeppelin library to ensure that it adheres to the ERC721 and ERC20 standards and takes care of vulnerabilities like reentrancy. The contract has two main functions: wrap(), which wraps an ERC20 token into an ERC721 token, and unwrap(), which unwraps an ERC721 token into an ERC20 token. The contract also keeps track of the mapping between ERC721 token IDs and ERC20 token addresses, as well as the mapping between ERC20 token addresses and ERC721 token IDs.

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
