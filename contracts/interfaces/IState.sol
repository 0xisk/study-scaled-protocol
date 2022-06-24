// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IState {
    /// Only accepted with balance
    error OnlyWithTokenBalance();

    function currentCycleExpiry() external view returns (uint32);
}