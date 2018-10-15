pragma solidity ^0.4.24;

contract productlist {
  //state variables
  address seller;
  string name;
  string description;
  uint256 price;

  //sell an product
  function sellarticle(string _name, string _description, uint256 _price) public{
    seller = msg.sender;
    name = _name;
    description = _description;
    price = _price;
  }

  //get an sellproduct
  function getarticle() public view returns (address _seller, string _name, string _description, uint256 _price)
  {
    return(seller, name, description, price);
  }
}
