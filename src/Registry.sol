// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

error AlreadyAdded();

/// @title  Registry contract :: Checking if a token's legit
/// @notice This contract can be called by our main contract for checking if the ERC20 token address is legit

contract Registry is Ownable {
    mapping(address => bool) isLegit;

    event TokenSetTo(address indexed, bool value);

    function setIsLegit(address tokenAddress, bool _bool) public onlyOwner {
        if (_bool == true) {
            isLegit[tokenAddress] = true;
            emit TokenSetTo(tokenAddress, true);
        } else {
            delete isLegit[tokenAddress];
            emit TokenSetTo(tokenAddress, false);
        }
    }

    struct BatchedData {
        uint8 n;
        address[] addressesList;
        bool[] valueList;
    }

    function setIsLegitBatched(BatchedData memory _BatchedData)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < _BatchedData.n; i++) {
            setIsLegit(_BatchedData.addressesList[i], _BatchedData.valueList[i]);
        }
    }
}
