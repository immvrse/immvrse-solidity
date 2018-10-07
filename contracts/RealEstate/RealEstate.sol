pragma solidity ^0.4.25;

contract RealEstate {
    address public seller;
    address public buyer;
    string public streetAddress;
    string title;
    uint256 public price; 
    
    
    function RealEstate (){
        
    
    //who is the seller?
    seller = msg.sender;
    //what is the address
    streetAddress= "221B Baker Street";
    //what is the title
    title="holmes house";
    //what is the price
    price=12000000000000000000;  //12 ether to wei(price of the property)
    }
    
//making a buy function
function buyHouse() payable public{
    require(seller != 0x0); // check if seller address exists
    require(buyer == 0x0);  // buyer is not set yet
    require(msg.sender != seller); // buyer and seller accounts are different
    require(msg.value == price);    //prices match
    
    
    buyer = msg.sender;
    seller.transfer(msg.value); //sends the value is the msg sender is the value put in box
    


    }
}
