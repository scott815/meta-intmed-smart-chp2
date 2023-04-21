// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public charity =
        payable(0xF4944e7ea9e5210a75EEcdcAbBa286ADd4074C8c);

    address payable public owner;
    uint256 public balance;
    uint256 public numDeposits;
    uint256 public numWithdrawals;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function depositCount() public view returns (uint256) {
        return numDeposits;
    }

    function withdrawCount() public view returns (uint256) {
        return numWithdrawals;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // increment deposit counter
        numDeposits++;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // increment withdrawal counter
        numWithdrawals++;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }

    function donate22(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        require(
            address(this).balance >= _withdrawAmount,
            "Insufficient balance"
        );

        // send the withdrawn amount to the charity address
        bool success = charity.send(_withdrawAmount);
        require(success, "Failed to send Ether to charity address");

        // update the balance of the contract
        balance -= _withdrawAmount;

        // increment withdrawal counter
        numWithdrawals++;

        // assert the balance is correct
        assert(balance == address(this).balance);

        // emit the event
        emit Withdraw(_withdrawAmount);
    }

    function donate222(uint256 _withdrawAmount) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = charity.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
        // update the balance of the contract
        balance -= _withdrawAmount;

        // increment withdrawal counter
        numWithdrawals++;

        // assert the balance is correct
        assert(balance == address(this).balance);
    }

    //address payable public constant recipient = 0xF4944e7ea9e5210a75EEcdcAbBa286ADd4074C8c;
    address payable constant receiver =
        payable(0xF4944e7ea9e5210a75EEcdcAbBa286ADd4074C8c);

    function donate2() public payable {
        // require(msg.value == 1 ether, "You must send exactly 1 ETH");
        receiver.transfer(1000000000000000000);
    }

    function getCharityBalance() public view returns (uint256) {
        return address(charity).balance;
    }
}
