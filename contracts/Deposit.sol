// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Deposit {

  // address public operatorAddress;
  mapping(address => uint256) public deposits;

  constructor(/*address _operatorAddress*/) {
    // operatorAddress = _operatorAddress;
  }

  event SuccessDeposit(string trnasactionId, uint256 amount, address receiver, address sender);

  function deposit(address _receiver, string memory transactionId) payable public {
    deposits[_receiver] += msg.value;
    // require(payable(operatorAddress).send(msg.value));
    emit SuccessDeposit(transactionId, msg.value, _receiver, msg.sender);
  }

  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }

  function getBalance2(address addr) public view returns (uint256) {
    return address(addr).balance;
  }
}