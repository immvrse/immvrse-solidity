pragma solidity ^0.4.24;

contract Classifieds {
  //custom types
struct Article{
  uint id;
  address seller;
  address buyer;
  string name;
  string description;
  uint256 price;
}

  //state variables

mapping (uint => Article) public articles;
uint articleCounter;

  //events
  event LogSellArticle(
    uint indexed _id,
    address indexed _seller,
    string _name,
    uint256 _price
    );

    event LogBuyArticle(

      uint indexed _id,
      address indexed _seller,
      address indexed _buyer,
      string _name,
      uint _price
      );


  //sell an article
  function sellArticle(string _name, string _description, uint256 _price) public{
    // a new article
    articleCounter++;

    articles[articleCounter] = Article(
      articleCounter,
      msg.sender,
      0x0,
      _name,
      _description,
      _price
      );

    LogSellArticle(articleCounter, msg.sender, _name, _price);
  }

// fetch the number of articles in the contract
  function getNumberOfArticles() public view returns (uint){
    return articleCounter;
  }


  // fetch and return all artilce ids for articles still for scale
  function getArticlesForSale() public view returns (uint[]){
    //prepare output array
    uint[] memory articleIds = new uint[](articleCounter);

    uint numberofArticlesForSale = 0;

    // iterate over articles
    for(uint i=1; i <= articleCounter; i++){
      //keep the ID if the article is still for sale
      if(articles[i].buyer == 0x0){
        articleIds[numberofArticlesForSale] = articles[i].id;
        numberofArticlesForSale++;
      }
    }

    //copy the articleIDs array into a smaller forSale array

  uint[] memory forSale = new uint[](numberofArticlesForSale);
  for(uint j = 0; j < numberofArticlesForSale; j++){
    forSale[j] = articleIds[j];
  }
  return forSale;
  }



 //buy an article

 function buyArticle(uint _id) payable public{
    //we can check whether there is an article for sale
    require(articleCounter > 0);

    //we check that the artilce exists
    require(_id > 0 && _id <= articleCounter);

    //we retrieve the article from mapping

    Article storage article = articles[_id];

    //we check whether the article has not been sold yet
    require(article.buyer == 0x0);

    //we dont allow the seller to buy his own article
    require (msg.sender != article.seller);

  // we check the value sent corresponds to the price of the article
  require(msg.value == article.price);

  //keep buyers information
  article.buyer = msg.sender;

    // the buyer can pay the seller
    article.seller.transfer(msg.value);

    // trigger the events
    LogBuyArticle(_id, article.seller, article.buyer, article.name, article.price);
  }
}
