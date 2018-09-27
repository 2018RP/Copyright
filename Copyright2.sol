pragma solidity ^0.4.17;

contract Copyright {
    mapping (string => {string, uint}) private Item;
    address public owner;
    address[] public paidUsers;
    uint public price = 100000000000000;
    string errorMsg = "error";
    
//
// constructor
//
    constructor () public {
        owner = msg.sender;
    }

    modifier restrictedOwner {
        require(msg.sender == owner);
        _;
    }

//    
// Add new item
    function setItem (string key, string value) public restrictedOwner() {
        Item[key]= value;
    }
    
    
// retriving Item
    function getItemdata (string arg) public constant returns (string) {
        return Item[arg];
    }
    
// purchase. if a buyer purchase item with exact price, put the user into the paidUsers array.
    function purchase () public payable returns (string) {
        require (msg.value == price);
        paidUsers.push(msg.sender);
        //would like to send item information here...since the user purchased here.
    }

// for testing purposes, to check paidUser is listed up or not.    
    function getUsers(uint256 num) public view returns (address[]){
        if (num <= paidUsers.length-1) {
        return paidUsers;
        } 
    }
}