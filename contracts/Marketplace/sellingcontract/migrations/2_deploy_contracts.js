var sellingarticle = artifacts.require("./sellingarticle.sol");

module.exports = function(deployer) {
  deployer.deploy(sellingarticle);
};
