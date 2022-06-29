// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IState.sol";
import "./interfaces/IERC20.sol";

contract State is IState {
    address public immutable token;

    mapping(uint64 => uint256) public securityDeposits;
    mapping(uint64 => Account) public accounts;

    uint256 public reserves;

    // todo: do we need to make it immutable?
    uint32 public immutable duration;

    /// @dev initialing a new State contract
    /// @param token_ address The tokens to be used in the state
    /// @param duration_ uint32 The duration that will be used in checking the Expiry
    constructor(address token_, uint32 duration_) {
        token = token_;
        duration = duration_;
    }

    /// External
    function depositSecurity(uint64 toIndex) external {
        //  get amount deposited
        uint256 balance = _getTokenBalance(address(this));
        uint256 amount = balance - reserves;
        reserves = balance;

        securityDeposits[toIndex] += amount;
    }

    function fundAccount(uint64 toIndex) external {
        // get amount deposited
        uint256 balance = _getTokenBalance(address(this));
        uint256 amount = balance - reserves;
        reserves = balance;

        // console.log("Funding account of user with address: ", addresses[toIndex], "with amount", amount);

        Account memory account = accounts[toIndex];
        account.balance += uint128(amount);
        accounts[toIndex] = account;
    }

    /// Public
    function currentCycleExpiry() public view override returns (uint32) {
        // `expireedBy` value of a `receipt = roundUp(block.timestamp / duration) * duration`
        return uint32(((block.timestamp / duration) + 1) * duration);
    }

    /// Internal
    function _getUpdateAtIndex(uint256 i)
        internal
        pure
        returns (
            // 8 bytes
            uint64 bIndex,
            // 16 bytes
            uint128 amount
        )
    {
        uint256 offset = 78 + (i * 24);
        assembly {
            bIndex := shr(192, calldataload(offset))

            offset := add(offset, 8)
            amount := shr(128, calldataload(offset))
        }
    }

    function _recordKey(uint64 a_, uint64 b_) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(a_, "++", b_));
    }

    function _getTokenBalance(address user_) internal view returns (uint256) {
        (bool success, bytes memory data) = token.staticcall(abi.encodeWithSelector(IERC20.balanceOf.selector, user_));
        if (!success || data.length != 32) {
            // revert with balance error
            revert OnlyWithTokenBalance();
        }
        return abi.decode(data, (uint256));
    }
}
