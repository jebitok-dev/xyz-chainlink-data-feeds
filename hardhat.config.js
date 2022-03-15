require("@nomiclabs/hardhat-waffle")
require("dotenv").config()

const { VRF_SUBSCRIPTION_ID, RINKEBY_RPC_URL, PRIVATE_KEY } = process.env

module.exports = {
  solidity: "0.8.4",
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {
      forking: {
        url: RINKEBY_RPC_URL,
        // blockNumber: FORKING_BLOCK_NUMBER,
        enabled: true,
      },
      chainId: 31337,
    },
    rinkeby: {
      url: `https://eth-rinkeby.alchemyapi.io/v2/${RINKEBY_RPC_URL}`,
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: `${VRF_SUBSCRIPTION_ID}`
    },
  },
}
