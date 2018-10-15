var chainlist = artifacts.require("./productlist.sol");

module.exports = function(deployer) {
  deployer.deploy(chainlist);
};
