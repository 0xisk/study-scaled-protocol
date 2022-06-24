// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IStateBLS.sol";
import "./State.sol";

contract StateBLS is State, IStateBLS {

    mapping (uint64 => address) public addresses;
    mapping (uint64 => uint256[4]) public blsPublicKeys;
    mapping (uint64 => Account) public accounts;
    mapping (uint64 => uint256) public securityDeposits;
    mapping (uint64 => Withdrawal) public pendingWithdrawals;
    mapping (bytes32 => Record) public records;

    uint64 public userCount;
    uint256 public reserves;

    bytes32 public constant blsDomain = keccak256(abi.encodePacked("test");)
    uint32 public constant bufferPeriod = uint32(1 days);

    // duration is a week in seconds
    uint32 constant duration = 604800;

    constructor(address token_, uint32 duration_) State(token_, duration_) {
    }
}