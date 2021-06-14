// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.5 <0.9.0;

contract Delance {

    address public employer;
    address public freelancer;
    uint public deadline;

    constructor(address _freelancer, uint _deadline) {
        employer = msg.sender;
        freelancer = _freelancer;
        deadline = _deadline;
    }
}
