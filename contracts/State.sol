// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract State {
    address public immutable token;

    constructor(address _token) {
        token = _token;
    }
}
