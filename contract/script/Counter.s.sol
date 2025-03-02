// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Library} from "../src/Library.sol";

contract LibraryScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Library lib = new Library();
        lib.addBook("Solidity Basics"); // Example interaction
        vm.stopBroadcast();
    }
}