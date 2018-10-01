pragma solidity ^0.4.17;

contract Copyright {
    mapping (string => string) private Item;
    address public owner;
    address[] public paidUsers;
    uint256 public price = 20000000000000000;
    string private accessKey;


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
    
    
// retriving Item
    function getItemdata (string key) public constant returns (string) {
        return Item[key];
    }
    
// purchase. if a buyer purchase item with exact price, put the user into the paidUsers array.
    function purchase () public payable returns (string) {
        require (msg.value == price);
        paidUsers.push(msg.sender);
        return Item[accessKey];
    }
	
// collecting money
	function transfer () public restrictedOwner {
	    msg.sender.transfer(address(this).balance);
	}
	
// Cheking balance	
     function getBalance() public view returns (uint256)  {
        return address(this).balance;
    }

// for testing purposes, to check paidUser is listed up or not.    
    function getUsers(uint256 num) public view returns (address[]){
        if (num <= paidUsers.length-1) {
        return paidUsers;
        } 
    }
}