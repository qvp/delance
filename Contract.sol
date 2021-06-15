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

    event RequestCreated(string title, uint256 amount, bool locked, bool paid);
    event RequestUnlocked(uint256 index);

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

    modifier onlyEmployer() {
        require(msg.sender == employer, "Only employer!");
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

        emit RequestCreated(_title, _amount, request.locked, request.paid);
    }

    function getAllRequests() public view returns (Request[] memory) {
        return requests;
    }

    function unlockRequest(uint256 _index) public onlyEmployer {
        Request storage request = requests[_index];
        require(request.locked, "Already unlocked!");
        request.locked = false;

        emit RequestUnlocked(_index);
    }
}
