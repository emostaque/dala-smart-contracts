/**
 * This smart contract code is Copyright 2017 TokenMarket Ltd. For more information see https://tokenmarket.net
 *
 * Licensed under the Apache License, version 2.0: https://github.com/TokenMarketNet/ico/blob/master/LICENSE.txt
 */

pragma solidity ^0.4.15;

import "./PricingStrategy.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./KrakenPriceTicker.sol";

/**
 * Fixed crowdsale pricing - everybody gets the same price.
 */
contract ForexPricing is PricingStrategy {

  using SafeMath for uint;


  KrakenPriceTicker public krakenPriceTicker;

  function ForexPricing() {
      krakenPriceTicker = new KrakenPriceTicker();
  }

  /**
   * Calculate the current price for buy in amount.
   *
   */
  function calculatePrice(uint value, uint weiRaised, uint tokensSold, address msgSender, uint decimals) public constant returns (uint) {
    uint multiplier = 10 ** decimals;
    uint ethToUsd = krakenPriceTicker.XETHZUSD().mul(multiplier);
    uint anaToUsd = 50;

    return value.mul(multiplier)
            .mul(ethToUsd)
            .mul(anaToUsd);
  }

}
