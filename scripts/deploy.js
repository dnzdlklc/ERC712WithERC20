const { deployments } = require("hardhat");
const WrappedToken = require("../contracts/WrappedToken.sol");
const ERC20 = require("../contracts/DynamicSupplyERC20.sol");

async function main() {
    // Deploy the ERC20 token
    const erc20 = await deployments.deploy(ERC20);
    const erc20Address = erc20.address;

    // Deploy the WrappedToken contract
    const wrappedToken = await deployments.deploy(WrappedToken, erc20Address);
    console.log("WrappedToken deployed at:", wrappedToken.address);
    console.log("Wrapped ERC20 token at:", erc20Address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
