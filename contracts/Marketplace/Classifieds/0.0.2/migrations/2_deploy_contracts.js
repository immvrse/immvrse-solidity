var Classifieds = artifacts.require("./Classifieds.sol");

module.exports = function(deployer) {
  deployer.deploy(Classifieds);
};
