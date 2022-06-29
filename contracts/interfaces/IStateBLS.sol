// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IStateBLS {
    struct Record {
        uint16 seqNo;
    }

    struct Withdrawal {
        uint128 amount;
        uint32 validAfter;
    }

    function register(
        address userAddress,
        uint256[4] calldata blsPk,
        uint256[2] calldata sk
    ) external;
}
