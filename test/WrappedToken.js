const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("WrappedToken", () => {
    let wrappedToken;
    let wrappedTokenAddress;
    let erc20;
    let erc20Address;
    let user;
    let user2;

    beforeEach(async () => {
        [user, user2] = await ethers.getSigners();
        wrappedToken = await ethers.deploy(WrappedToken, erc20Address, { from: user });
        wrappedTokenAddress = wrappedToken.address;
        erc20 = await ethers.getContractAt(ERC20, erc20Address, user);
    });

    it("should wrap ERC20 token", async () => {
        const initialBalance = await erc20.balanceOf(user.address);
        await erc20.transfer(wrappedTokenAddress, initialBalance, { from: user });
        await wrappedToken.wrap(erc20Address, { from: user });
        const newBalance = await erc20.balanceOf(user.address);
        expect(newBalance).to.equal(0);
    });

    it("should unwrap ERC721 token", async () => {
        const initialBalance = await erc20.balanceOf(user.address);
        await erc20.transfer(wrappedTokenAddress, initialBalance, { from: user });
        const tokenId = await wrappedToken.wrap(erc20Address, { from: user });
        await wrappedToken.unwrap(tokenId, { from: user });
        const newBalance = await erc20.balanceOf(user.address);
        expect(newBalance).to.equal(initialBalance);
    });

    it("should only allow owner to unwrap ERC721 token", async () => {
        const initialBalance = await erc20.balanceOf(user.address);
        await erc20.transfer(wrappedTokenAddress, initialBalance, { from: user });
        const tokenId = await wrappedToken.wrap(erc20Address, { from: user });
        await expect(wrappedToken.unwrap(tokenId, { from: user2 })).to.be.revertedWith("Sender is not the owner of the token");
    });
});