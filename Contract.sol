// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.5 <0.9.0;

struct Request {
    string title;
    uint256 amount;
    bool locked;
    bool paid;
}

contract Delance {

    address public employer;
    address public freelancer;
    uint public deadline;
    uint public price;
    Request[] public requests;

    constructor(address _freelancer, uint _deadline) payable {
        employer = msg.sender;
        freelancer = _freelancer;
        deadline = _deadline;
        price = msg.value;
    }

    receive() external payable {
        price += msg.value;
    }

    modifier onlyFreelancer() {
        require(msg.sender == freelancer, "Only freelancer!");
        _;
    }

    function createRequest(string memory _title, uint256 _amount) public onlyFreelancer {
        Request memory request = Request({
            title: _title,
            amount: _amount,
            locked: true,
            paid: false
        });

        requests.push(request);
    }

    function getAllRequests() public view returns (Request[] memory) {
        return requests;
    }
}
