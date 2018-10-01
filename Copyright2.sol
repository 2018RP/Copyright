pragma solidity ^0.4.17;

contract Copyright {
    mapping (string => string) private Item;
    mapping (address => bool) public paidUsers;
    address public owner;
    string private accessKey;
    uint public totalPaidUsers;
    uint256 private price = 20000000000000000;

// constructor
    constructor () public {
        owner = msg.sender;
    }

// security function only owner can access
    modifier restrictedOwner {
        require(msg.sender == owner);
        _;
    }

// Add new item
    function setItem (string key, string value) public restrictedOwner() {
        Item[key]= value;
        accessKey = key;
    }
    
// retrieving Item
    function getItemdata (string key) public constant returns (string) {
        require(paidUsers[msg.sender] == true || msg.sender == owner);
        return Item[key];
    }
    
// purchase. if a buyer purchase item with exact price, put the user into the paidUsers array.
    function purchase () public payable returns (string) {
        require (msg.value == price);
        paidUsers[msg.sender] = true;
        totalPaidUsers++;
        return Item[accessKey];
    }
	
// collecting money
	function transfer () public restrictedOwner {
	    msg.sender.transfer(address(this).balance);
	}
	
// Checking balance	
     function getBalance() public view returns (uint256)  {
        return address(this).balance;
    }
}