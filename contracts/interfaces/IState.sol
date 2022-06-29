// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IState {
    struct Account {
        uint128 balance;
        uint32 nonce;
    }

    /// Only accepted with balance
    error OnlyWithTokenBalance();

    function currentCycleExpiry() external view returns (uint32);

    function fundAccount(uint64 toIndex) external;
}
