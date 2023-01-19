// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract DynamicSupplyERC20 is SafeERC20 {
    mapping(address => uint256) public balanceOf;
    string public name = "Dynamic Supply ERC20 Token";
    string public symbol = "DSET";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    constructor() public {
        totalSupply = 0;
    }

    function mint(address _to, uint256 _value) public {
        require(_value > 0, "Cannot mint 0 tokens");
        require(msg.sender == msg.sender, "Only the owner of the contract can mint tokens");
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Transfer(address(0), _to, _value);
    }

    function burn(address _from, uint256 _value) public {
        require(_value > 0, "Cannot burn 0 tokens");
        require(balanceOf[_from] >= _value, "Sender does not have enough balance");
        require(msg.sender == msg.sender, "Only the owner of the contract can burn tokens");
        totalSupply -= _value;
        balanceOf[_from] -= _value;
        emit Transfer(_from, address(0), _value);
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "Cannot transfer to the zero address");
        require(_value <= balanceOf[msg.sender], "Sender does not have enough balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
