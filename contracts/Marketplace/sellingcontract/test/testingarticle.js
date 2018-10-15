var sellingarticle = artifacts.require("./sellingarticle.sol");

//test suite
contract('sellingarticle',function(accounts){
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
})
