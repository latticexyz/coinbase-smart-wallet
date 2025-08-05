// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {SafeSingletonDeployer} from "safe-singleton-deployer-sol/src/SafeSingletonDeployer.sol";

import {CoinbaseSmartWallet, CoinbaseSmartWalletFactory} from "../src/CoinbaseSmartWalletFactory.sol";

contract DeployFactoryScript is Script {
    address constant EXPECTED_IMPLEMENTATION =
        0x1d8a44516C3B3Dc1306b140106EA1b73f4FEAC2a;
    address constant EXPECTED_FACTORY =
        0x08e62719a7da36830c50a2903517c2B13d4c8204;

    function isDeployed(address addr) public view returns (bool) {
        // Check if there is a contract at the address
        return addr.code.length > 0;
    }

    function run() public {
        console2.log("Deploying on chain ID", block.chainid);

        if (isDeployed(EXPECTED_IMPLEMENTATION)) {
            console2.log("implementation already deployed");
        } else {
            address implementation = SafeSingletonDeployer.broadcastDeploy({
                creationCode: type(CoinbaseSmartWallet).creationCode,
                salt: 0x3438ae5ce1ff7750c1e09c4b28e2a04525da412f91561eb5b57729977f591fbb
            });
            console2.log("implementation", implementation);
            assert(implementation == EXPECTED_IMPLEMENTATION);
        }

        if (isDeployed(EXPECTED_FACTORY)) {
            console2.log("factory already deployed");
        } else {
            address factory = SafeSingletonDeployer.broadcastDeploy({
                creationCode: type(CoinbaseSmartWalletFactory).creationCode,
                args: abi.encode(EXPECTED_IMPLEMENTATION),
                salt: 0x278d06dab87f67bb2d83470a70c8975a2c99872f290058fb43bcc47da5f0390c
            });
            console2.log("factory", factory);
            assert(factory == EXPECTED_FACTORY);
        }
    }
}
