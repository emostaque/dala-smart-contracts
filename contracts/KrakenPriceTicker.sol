/*
   Kraken-based ETH/XBT price ticker

   This contract keeps in storage an updated ETH/XBT price,
   which is updated every ~60 seconds.
*/

pragma solidity ^0.4.15;
import "installed_contracts/oraclize/contracts/usingOraclize.sol";

contract KrakenPriceTicker is usingOraclize {

    uint public XETHZUSD;

    event newOraclizeQuery(string description);
    event newKrakenPriceTicker(uint price);


    function KrakenPriceTicker() {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
        update();
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) {
            throw;
        }

        XETHZUSD = parseInt(result);
        newKrakenPriceTicker(XETHZUSD);
        update();
    }

    function update() payable {
        if (oraclize_getPrice("URL") > this.balance) {
            newOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query(60, "URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHUSD).result.XETHZUSD.c.0");
        }
    }
}