# Deployment Guide

## Prerequisites

- Node.js >= 20.18.1
- Hardhat environment configured
- Access to Ethereum node (Infura/Alchemy)
- Etherscan API key for verification

## Environment Setup

1. Create `.env` file:
```bash
PRIVATE_KEY=your_private_khttps://discord.com/channels/336322535052541952/336322535052541952ey
SEPOLIA_RPC_URL=your_sepolia_rpc_url
MAINNET_RPC_URL=your_mainnet_rpc_url
ETHERSCAN_API_KEY=your_etherscan_key
COINMARKETCAP_API_KEY=your_coinmarketcap_key
```

## Deployment Steps

1. **Deploy Access Control**
```bash
npx hardhat deploy --tags AccessControl --network sepolia
```

2. **Deploy Fee Manager**
```bash
npx hardhat deploy --tags FeeManager --network sepolia
```

3. **Deploy Lending Terms**
```bash
npx hardhat deploy --tags LendingTerms --network sepolia
```

4. **Deploy NFT Rental**
```bash
npx hardhat deploy --tags NFTRental --network sepolia
```

## Contract Verification

```bash
npx hardhat verify --network sepolia DEPLOYED_CONTRACT_ADDRESS
```

## Post-Deployment Configuration

1. Set up roles:
```typescript
const accessControl = await ethers.getContract("AccessControl");
await accessControl.grantRole(ADMIN_ROLE, adminAddress);
```

2. Configure fees:
```typescript
const feeManager = await ethers.getContract("FeeManager");
await feeManager.setPlatformFee(250); // 2.5%
```

3. Set lending terms:
```typescript
const lendingTerms = await ethers.getContract("LendingTerms");
await lendingTerms.setDefaultTerms({
  minDuration: 3600,  // 1 hour
  maxDuration: 2592000, // 30 days
  collateralMultiplier: 150 // 1.5x
});
```

## Security Checklist

- [ ] All contracts verified on Etherscan
- [ ] Admin roles properly assigned
- [ ] Fee parameters configured
- [ ] Lending terms set
- [ ] Emergency pause tested
- [ ] Initial security audit completed
