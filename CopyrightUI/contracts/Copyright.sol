
//0xe0E264FDBEc877d7Dc4f3d8374aaA3eF0b8218Ff    contract address on rinkeby
//deployed using remix 
pragma solidity ^0.4.17;

contract Copyright {
    mapping (address => bool) public paidUsers;
    address public owner;
    uint public totalPaidUsers;
    uint256 private price = 10000;
    string ipfsHash;
 

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
    function sendHash(string x) public restrictedOwner() {
    ipfsHash = x;
     }
     
    function getHash() public view returns (string x)  {
     require (msg.sender == owner);
     return ipfsHash;
    }
    
// purchase. if a buyer purchase item with exact price, put the user into the paidUsers array.
    function purchase () public payable returns (string) {
        require (msg.value == price);
        paidUsers[msg.sender] = true;
        totalPaidUsers++;
        return ipfsHash;
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