# Technical Reference

## Smart Contract Interfaces

### INFTRental

```solidity
interface INFTRental {
  struct Rental {
      address lender;
      address renter;
      uint256 startTime;
      uint256 duration;
      uint256 price;
      uint256 collateral;
  }

  function listNFT(
      address nftContract,
      uint256 tokenId,
      uint256 price,
      uint256 duration
  ) external;

  function rentNFT(
      address nftContract,
      uint256 tokenId,
      uint256 duration
  ) external payable;

  function returnNFT(
      address nftContract,
      uint256 tokenId
  ) external;
}
```

### IFeeManager

```solidity
interface IFeeManager {
  function calculateFees(
      uint256 amount,
      address nftContract,
      uint256 tokenId
  ) external view returns (
      uint256 platformFee,
      uint256 creatorFee,
      uint256 referralFee
  );

  function distributeFees(
      address nftContract,
      uint256 tokenId,
      uint256 amount
  ) external;
}
```

## Configuration Parameters

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| PLATFORM_FEE | 250 (2.5%) | Platform fee percentage |
| CREATOR_FEE | 500 (5%) | Creator royalty percentage |
| REFERRAL_FEE | 100 (1%) | Referral fee percentage |
| MIN_RENTAL_DURATION | 1 hour | Minimum rental period |
| MAX_RENTAL_DURATION | 30 days | Maximum rental period |
| COLLATERAL_MULTIPLIER | 150 (1.5x) | Collateral ratio vs rental price |

## Events

```solidity
event NFTListed(
  address indexed nftContract,
  uint256 indexed tokenId,
  address indexed lender,
  uint256 price,
  uint256 duration
);

event NFTRented(
  address indexed nftContract,
  uint256 indexed tokenId,
  address indexed renter,
  uint256 duration
);

event NFTReturned(
  address indexed nftContract,
  uint256 indexed tokenId,
  address indexed renter
);
```