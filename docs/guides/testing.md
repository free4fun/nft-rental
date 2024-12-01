# Testing Guide

## Test Environment Setup

1. **Install Dependencies**
```bash
npm install
```

2. **Compile Contracts**
```bash
npx hardhat compile
```

## Running Tests

### Unit Tests

```bash
npx hardhat test
```

### Coverage Report

```bash
npx hardhat coverage
```

## Test Structure

```typescript
describe("NFTRental", function() {
  describe("Listing", function() {
      it("Should list NFT successfully")
      it("Should revert if price is zero")
      it("Should revert if duration is invalid")
  })

  describe("Renting", function() {
      it("Should rent NFT successfully")
      it("Should collect correct fees")
      it("Should handle collateral properly")
  })

  describe("Returns", function() {
      it("Should process normal returns")
      it("Should handle late returns")
      it("Should calculate penalties correctly")
  })
})
```

## Gas Usage Report

Enable gas reporting in hardhat.config.ts:
```typescript
gasReporter: {
  enabled: true,
  currency: 'USD',
  outputFile: 'gas-report.txt',
  noColors: true,
  coinmarketcap: process.env.COINMARKETCAP_API_KEY
}
```

## Test Coverage Requirements

| Contract | Coverage Target |
|----------|----------------|
| NFTRental | 95% |
| FeeManager | 90% |
| LendingTerms | 90% |
| AccessControl | 85% |

## Continuous Integration

GitHub Actions workflow runs:
- Unit tests
- Coverage report
- Gas usage analysis
- Slither security analysis
