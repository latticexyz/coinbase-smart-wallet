deploy :; \
  source .env && \
  export FOUNDRY_PROFILE=deploy && \
  cast rpc -r $${RPC_URL} anvil_setCode 0x914d7Fec6aaC8cd542e72Bca78B30650d45643d7 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf3 && \
  forge script script/DeployFactory.s.sol \
    --rpc-url $${RPC_URL} \
    --private-key $${PRIVATE_KEY} \
    --broadcast
