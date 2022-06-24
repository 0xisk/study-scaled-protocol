// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IERC20.sol";
import "./libraries/Transfers.sol";
import "./interfaces/IStateBLS.sol";
import "./State.sol";

/// Old implementation without BLS.
/// Optimizes heavily to reduce calldata.
contract StateBLS is State, IStateBLS {
    constructor()
}
