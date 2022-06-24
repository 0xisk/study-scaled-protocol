// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IStateBLS {
    struct Account {
        uint128 balance;
        uint32 nonce;
    }

    struct Record {
        uint16 seqNo;
    }

    struct Withdrawal {
        uint128 amount;
        uint32 validAfter;
    }
}