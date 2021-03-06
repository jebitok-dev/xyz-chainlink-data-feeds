require("@nomiclabs/hardhat-waffle")
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle"); 
require("hardhat-gas-reporter");

// const { VRF_SUBSCRIPTION_ID, RINKEBY_RPC_URL, PRIVATE_KEY } = process.env

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

module.exports = {
  solidity: "^0.8.4",
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {
      // forking: {
      //   url: process.env.RINKEBY_RPC_URL,
      //   // blockNumber: FORKING_BLOCK_NUMBER,
      //   // enabled: false,
      // },
      // chainId: 4,
    },
    rinkeby: {
      url: process.env.RPC_URL || "",
      accounts: process.env.PRIVATE_KEY,
    },
  },
}
