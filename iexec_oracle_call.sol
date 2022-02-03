pragma solidity ^0.8.0;

import "./Oracle.sol";

contract Getdata{
    int256  public status;
     uint256 public updatedate;
    
    function getOracleData() public returns (int256 ) {
        
        bytes32 oracleId = 0x8f34ff4d2442e5803cc1ac2a55eeb069604d255e18aa0ec41ba52b03366f891a;
        address oracleAddress = 0x8ecEDdd1377E52d23A46E2bd3dF0aFE35B526D5F;
        Oracle oracleContract = Oracle(oracleAddress);
        (int256  value, uint256 date) = oracleContract.getInt(
            oracleId
        );
        status = value;
        updatedate = date;
       
        return value;
    }
}