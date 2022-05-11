// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract LotToken {
	// Constructor
	// Set the total number of tokens
	// Read the total number of tokens
	uint256 public totalSupply;
	mapping(address => uint256) public balanceOf;
	// account A approve account B to spend {value}
	mapping(address => mapping(address => uint256)) public allowance;
	// Name
	string public name = "Lot Token";
	// Symbol
	string public symbol = "Lot";
	// standard
	string public standard = "Lot Token v1.0";

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
	);

	constructor(uint256 _initialSupply) {
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
		// alocate the initial supply
	}

	// Transfer 
	function transfer(address _to, uint256 _value) public returns (bool success) {
        // Exception if account doesn't have enough
        require(balanceOf[msg.sender] >= _value);
        // Transfer the balance
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
	    // Return a boolean
	    emit Transfer(msg.sender, _to, _value);
	    // Transfer Event

	    return true;
	}

	// approve
	function approve(address _spender, uint256 _value) public returns (bool success) {
		// allowance
		allowance[msg.sender][_spender] = _value;

		//Approve event
		emit Approval(msg.sender, _spender, _value);
		return true;
	}

	// transferFrom
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		// Require _from has enough tokens
		require(_value <= balanceOf[_from]);
		// Require allowance is big enough
		require(_value <= allowance[_from][msg.sender]);
		// Change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		// Update the allowance
		allowance[_from][msg.sender] -= _value;
		// Transfer event
		emit Transfer(_from, _to, _value);
		return true;
	}

}