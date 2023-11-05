/*remix.ethereum.org*/
/*3-name-Bank.sol*/

//SPDX-License-Identifier:MIT
pragma solidity ^0.6.8;

contract Bank{
    int balance;
    constructor() public {
        balance=0;
    }

    function withdraw(int amount) public{
        if (balance>amount)
        {
            balance = balance - amount;
        }
       
        
    }
    function bal()  public view returns(int) {
        return balance;
    }
    function despo(int amount) public{
        balance = balance+amount;
    }

}
