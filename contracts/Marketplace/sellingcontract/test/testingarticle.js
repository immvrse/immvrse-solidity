var sellingarticle = artifacts.require("./sellingarticle.sol");

//test suite
contract('sellingarticle',function(accounts){
  var sellingarticleInstance;
  var seller = accounts[1];
  var articleName ="article 1";
  var articleDescription = "Description for article 1'";
  var articlePrice = 10;

  it("should be initialized with empty values", function(){
    return sellingarticle.deployed().then(function(instance){
      return instance.getarticle();
    }).then(function(data){
      assert.equal(data[0],0x0, "seller must be empty");
      assert.equal(data[1],"", "article name must be empty");
      assert.equal(data[2],"", "article description be empty");
      assert.equal(data[3].toNumber(), 0, "article price must be zero");
    })
  })

  it("should sell an article", function(){
    return sellingarticle.deployed().then(function(instance){
      sellingarticleInstance = instance;
      return sellingarticleInstance.sellarticle(articleName, articleDescription, web3.toWei(articlePrice, "ether"),{from: seller});
    }).then(function(){
      return sellingarticleInstance.getarticle();
    }).then(function(data){
      assert.equal(data[0], seller, "seller must be " + seller);
      assert.equal(data[1], articleName, "article name must be " +articleName);
      assert.equal(data[2], articleDescription, "article description be " +articleDescription);
      assert.equal(data[3].toNumber(), web3.toWei(articlePrice, "ether"), "article price must be " + web3.toWei(articlePrice, "ether"));
    })
  })
})
