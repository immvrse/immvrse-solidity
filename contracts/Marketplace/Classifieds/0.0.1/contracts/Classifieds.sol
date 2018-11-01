pragma solidity ^0.4.24;

contract Classifieds {
  //state variables
  address seller;
  address buyer;
  string name;
  string description;
  uint256 price;

  //events
  event LogSellArticle(
    address indexed _seller,
    string _name,
    uint256 _price
    );



  //sell an article
  function sellArticle(string _name, string _description, uint256 _price) public{
    seller = msg.sender;
    name = _name;
    description = _description;
    price = _price;

    LogSellArticle(seller, name, price);
  }



  //get an article
  function getArticle() public view returns (address _seller, string _name, string _description, uint256 _price)
  {
    return(seller, name, description, price);
  }

 //buy an article

 function buyArticle() payable public{
 //we can check whether there is an article for sale
    require(seller != 0x0);

    //we check whether the article ahas not been sold yet
    require(buyer == 0x0);

    //we dont allow the seller to buy his own article
    require (msg.sender != seller);

  // we check the value sent corresponds to the price of the article
  require(msg.value == price);

  //keep buyers information
  buyer = msg.sender;

    // the buyer can pay the seller
    seller.transfer(msg.value);
  }
}
