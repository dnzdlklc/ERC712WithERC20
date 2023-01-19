// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract WrappedToken is ERC721, SafeERC20 {
    // Map from ERC721 token ID to ERC20 token address
    mapping(uint256 => address) public wrappedTokens;

    // Map from ERC20 token address to ERC721 token ID
    mapping(address => uint256) public tokenOf;

    // ERC20 contract instance
    ERC20 public wrappedToken;

    constructor(address _wrappedToken) public {
        wrappedToken = ERC20(_wrappedToken);
    }

    // Wraps an ERC20 token into an ERC721 token
    function wrap(address _token) public {
        require(wrappedToken.transferFrom(msg.sender, address(this), 1), "Transfer failed");
        wrappedTokens[tokenId()] = _token;
        tokenOf[_token] = tokenId();
        emit TokenWrapped(_token, tokenId());
    }

    // Unwraps an ERC721 token into an ERC20 token
    function unwrap(uint256 _tokenId) public {
        require(msg.sender == ownerOf(_tokenId), "Sender is not the owner of the token");
        address _token = wrappedTokens[_tokenId];
        require(wrappedToken.transfer(msg.sender, 1), "Transfer failed");
        delete wrappedTokens[_tokenId];
        delete tokenOf[_token];
        emit TokenUnwrapped(_token, _tokenId);
    }

    function tokenId() private view returns (uint256) {
        return totalSupply() + 1;
    }
}
