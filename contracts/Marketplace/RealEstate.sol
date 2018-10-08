pragma solidity ^0.4.25;

//This is a contract for selling and buying where seller can set a specific price in wei and 
  the buyer has to buy it at that price
contract MarketPlace {
    address public seller;
    address public buyer;
    string public streetAddress;
    string title;
    uint256 public price; 
    
    
    function MarketPlace (){
        
    
    //who is the seller?
    seller = msg.sender;
    //what is the address
    streetAddress= "221B Baker Street";
    //what is the title
    title="holmes house";
    //what is the price
    price=12000000000000000000;  //12 ether equivalent to wei(price of the asset)
    //This function requires to be variable from the frontend, to be set by the user
    }
    
//making a buy function
function buyHouse() payable public{
    require(seller != 0x0); // check if seller address exists
    require(buyer == 0x0);  // buyer is not set yet
    require(msg.sender != seller); // buyer and seller accounts are different
    require(msg.value == price);    //prices match
    
    
    buyer = msg.sender;
    seller.transfer(msg.value); //sends the value is the msg sender is the value put in box
    //duplicate this code to be paid using ERC20, using tokencontract and safemath lib
    


    }
}
