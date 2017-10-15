var ForexPricing = artifacts.require('./ForexPricing.sol');

module.exports = function (deployer, network) {
  if (network == 'development') {
    deployer.deploy(ForexPricing);
  }
  if (network == 'ropsten') {

    deployer.deploy(ForexPricing);
  }
};
