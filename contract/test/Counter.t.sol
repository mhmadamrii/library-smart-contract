// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Library} from "../src/Library.sol";

contract CounterTest is Test {
    Library lib;

    function setUp() public {
        lib = new Library();
    }

    function test_add_book() public {
        lib.addBook("Solidity basics");
        assertEq(lib.bookCount(), 1);
        (uint id, string memory title, bool isAvailable) = lib.books(1);
        assertEq(id, 1);
        assertEq(title, "Solidity basics");
        assertTrue(isAvailable);
    }
}
