// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IState.sol";
import "./interfaces/IERC20.sol";

contract State is IState {
    address public immutable token;

    // todo: do we need to make it immutable?
    uint32 public immutable duration;

    /// @dev initialing a new State contract
    /// @param token_ address The tokens to be used in the state
    /// @param duration_ uint32 The duration that will be used in checking the Expiry
    constructor(address token_, uint32 duration_) {
        token = token_;
        duration = duration_;
    }

    /// Public
    function currentCycleExpiry() public view override returns (uint32) {
        // `expireedBy` value of a `receipt = roundUp(block.timestamp / duration) * duration`
        return uint32(((block.timestamp / duration) + 1) * duration);
    }

    /// Internal
    function recordKey(uint64 a_, uint64 b_) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(a_, "++", b_));
    }

    function getTokenBalance(address user_) internal view returns (uint256) {
        (bool success, bytes memory data) = token.staticcall(
            abi.encodeWithSelector(IERC20.balanceOf.selector, user_)
        );
        if (!success || data.length != 32) {
            // revert with balance error
            revert OnlyWithTokenBalance();
        }
        return abi.decode(data, (uint256));
    }
}
