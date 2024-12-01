# Smart Contract Interaction Guide

## Overview

This document provides detailed instructions for interacting with the NFT Rental Protocol smart contracts, including code examples and best practices.

## Contract Addresses

| Network | Contract | Address |
|---------|----------|---------|
| Mainnet | NFTRental | `0x...` |
| Mainnet | FeeManager | `0x...` |
| Mainnet | LendingTerms | `0x...` |
| Sepolia | NFTRental | `0x...` |
| Sepolia | FeeManager | `0x...` |
| Sepolia | LendingTerms | `0x...` |

## Setup

```typescript
import { ethers } from 'ethers';
import {
NFTRental__factory,
FeeManager__factory,
LendingTerms__factory
} from '../typechain-types';

// Initialize provider
const provider = new ethers.providers.JsonRpcProvider(RPC_URL);

// Initialize signer
const signer = new ethers.Wallet(PRIVATE_KEY, provider);

// Contract instances
const nftRental = NFTRental__factory.connect(NFT_RENTAL_ADDRESS, signer);
const feeManager = FeeManager__factory.connect(FEE_MANAGER_ADDRESS, signer);
const lendingTerms = LendingTerms__factory.connect(LENDING_TERMS_ADDRESS, signer);
```

## Common Operations

### Listing an NFT

```typescript
const listNFT = async (
nftAddress: string,
tokenId: number,
pricePerDay: BigNumber,
minRentalDays: number,
maxRentalDays: number
) => {
const tx = await nftRental.listNFT(
  nftAddress,
  tokenId,
  pricePerDay,
  minRentalDays,
  maxRentalDays
);
await tx.wait();
return tx;
};
```

### Renting an NFT

```typescript
const rentNFT = async (
listingId: number,
rentalDays: number
) => {
const listing = await nftRental.getListing(listingId);
const rentalPrice = listing.pricePerDay.mul(rentalDays);

const tx = await nftRental.rentNFT(
  listingId,
  rentalDays,
  { value: rentalPrice }
);
await tx.wait();
return tx;
};
```

### Returning an NFT

```typescript
const returnNFT = async (rentalId: number) => {
const tx = await nftRental.returnNFT(rentalId);
await tx.wait();
return tx;
};
```

## Event Listening

```typescript
// Listen for new listings
nftRental.on('NFTListed', (owner, nftAddress, tokenId, event) => {
console.log(`New NFT Listed by ${owner}`);
});

// Listen for new rentals
nftRental.on('NFTRented', (renter, listingId, rentalId, event) => {
console.log(`NFT Rented by ${renter}`);
});
```

## Error Handling

```typescript
try {
await rentNFT(listingId, rentalDays);
} catch (error) {
if (error.code === 'INSUFFICIENT_FUNDS') {
  console.error('Not enough ETH to cover rental cost');
} else if (error.code === 'LISTING_NOT_AVAILABLE') {
  console.error('NFT is not available for rent');
} else {
  console.error('Unknown error:', error);
}
}
```

## Gas Optimization Tips

1. Batch operations when possible
2. Use callStatic to simulate transactions
3. Implement proper error handling
4. Monitor gas prices for optimal transaction timing

## Security Considerations

1. Always verify contract addresses
2. Check allowances before transactions
3. Implement proper error handling
4. Use multi-sig for admin functions
5. Monitor events for important changes

## Advanced Features

### Fee Management

```typescript
const getFees = async (amount: BigNumber) => {
const platformFee = await feeManager.calculatePlatformFee(amount);
const creatorFee = await feeManager.calculateCreatorFee(amount);
const referralFee = await feeManager.calculateReferralFee(amount);

return {
  platformFee,
  creatorFee,
  referralFee,
  total: platformFee.add(creatorFee).add(referralFee)
};
};
```

### Lending Terms Management

```typescript
const updateTerms = async (
minRentalDays: number,
maxRentalDays: number,
collateralMultiplier: number
) => {
const tx = await lendingTerms.updateTerms(
  minRentalDays,
  maxRentalDays,
  collateralMultiplier
);
await tx.wait();
return tx;
};
```

## Testing and Validation

```typescript
// Validate listing parameters
const validateListing = async (
nftAddress: string,
tokenId: number,
pricePerDay: BigNumber
) => {
await nftRental.callStatic.listNFT(
  nftAddress,
  tokenId,
  pricePerDay
);
};
```

## Troubleshooting

Common issues and solutions:

1. **Transaction Reverted**
 - Check allowances
 - Verify parameters
 - Ensure sufficient funds

2. **High Gas Costs**
 - Use batch operations
 - Monitor gas prices
 - Optimize function calls

3. **Permission Errors**
 - Verify caller address
 - Check role assignments
 - Review access controls