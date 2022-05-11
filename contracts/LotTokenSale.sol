// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./LotToken.sol";

contract LotTokenSale {
	// no public: we don't want to expose address of admin
	address payable admin;
	LotToken public tokenContract;
	uint256 public tokenPrice;
	uint256 public tokensSold;

	event Sell(address _buyer, uint256 _amount);

	constructor(LotToken _tokenContract, uint256 _tokenPrice) {
		// Assign an admin
		admin = payable(msg.sender);
		// Token Contract
		tokenContract = _tokenContract;
		// Token Price
		tokenPrice = _tokenPrice;
	}

    // multiply
    function multiply(uint x, uint y) internal pure returns (uint z) {
    	require(y == 0 || (z = x * y) / y == x);
    }

	// Buy tokens
	function buyTokens(uint256 _numberOfTokens) public payable {
		// Require that value is equal to tokens
		require(msg.value == multiply(_numberOfTokens, tokenPrice));
		// Require that the contract has enough tokens
		require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
		// Require that a transfer is successful
		require(tokenContract.transfer(msg.sender, _numberOfTokens));
		// Keep track of tokensSold
		tokensSold += _numberOfTokens;
		// Trigger sell event
		emit Sell(msg.sender, _numberOfTokens);
	}

	function endSale() public {
		// Require admin
		require(msg.sender == admin);
		// Transfer reamining dapp tokens to admin
		require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
		// Destroy contract
		admin.transfer(address(this).balance);
	}
}