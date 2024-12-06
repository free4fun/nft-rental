import "@nomiclabs/hardhat-etherscan";
import { HardhatUserConfig } from "hardhat/types";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-gas-reporter";
import "solidity-coverage";
import "hardhat-deploy";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
solidity: {
  version: "0.8.19",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200,
    },
  },
},
networks: {
  hardhat: {
    forking: {
      enabled: process.env.FORKING_ENABLED === "true",
      url: process.env.MAINNET_URL || "",
      blockNumber: process.env.FORK_BLOCK_NUMBER === "latest" 
        ? undefined 
        : Number(process.env.FORK_BLOCK_NUMBER),
    },
  },
  mainnet: {
    url: process.env.MAINNET_URL || "",
    accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
  },
  goerli: {
    url: process.env.GOERLI_URL || "",
    accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
  },
  polygon: {
    url: process.env.POLYGON_URL || "",
    accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
  },
  mumbai: {
    url: process.env.MUMBAI_URL || "",
    accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
  },
},
gasReporter: {
  enabled: process.env.REPORT_GAS === "true",
  currency: "USD",
  coinmarketcap: process.env.COINMARKETCAP_API_KEY,
},
etherscan: {
  apiKey: {
    mainnet: process.env.ETHERSCAN_API_KEY || "",
    goerli: process.env.ETHERSCAN_API_KEY || "",
    polygon: process.env.POLYGONSCAN_API_KEY || "",
    polygonMumbai: process.env.POLYGONSCAN_API_KEY || "",
  },
},
namedAccounts: {
  deployer: {
    default: 0,
  },
},
paths: {
  sources: "./contracts",
  tests: "./test",
  cache: "./cache",
  artifacts: "./artifacts",
},
mocha: {
  timeout: 40000,
},
};

export default config;