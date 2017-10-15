var SafeMath = artifacts.require('zeppelin-solity/contracts/math/SafeMath.sol');
var UsingOraclize = artifacts.require('installed_contracts/oraclize/contracts/usingOraclize.sol');

module.exports = function(deployer){
    //deployer.deploy(SafeMath);
    deployer.deploy(UsingOraclize);
}