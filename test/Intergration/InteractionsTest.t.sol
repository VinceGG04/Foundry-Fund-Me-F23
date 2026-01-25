pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract IntegrationsTest is Test {
    FundMe fundMe;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
    }

    function testUserCanFundAndWithdraw() public {
        // simulate a real user
        address user = makeAddr("user");
        vm.deal(user, 10 ether);

        vm.prank(user);
        fundMe.fund{value: 0.1 ether}();

        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        assertEq(address(fundMe).balance, 0);
    }
}
