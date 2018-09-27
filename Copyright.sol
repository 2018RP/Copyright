library Product { 
    struct Item {string _owner; string _productID; string _tag;}
}

pragma solidity ^0.4.17;

contract Copyright {
    mapping (string => string) Item;
    address public ownerbc;

//
// constructor
//
    constructor () public {
        ownerbc = msg.sender;
    }

    modifier restrictedOwner {
        require(msg.sender == ownerbc);
        _;
    }
//    
// Add new item
//
    function setItem (string key, string value) public restrictedOwner() {
        Item[key] = value;
    }
    
// retriving Item
    function getItemdata (string arg) public constant returns (string) {
        return Item[arg];
    }
    
//set price

}