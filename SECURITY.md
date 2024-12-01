# Security Policy - WIP

## Supported Versions

Versions of the project currently being supported with security updates.

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take the security of NFT Rental Protocol seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Please do NOT:

- Open a public issue on GitHub
- Publish the vulnerability before it has been fixed
- Use the vulnerability for attacks
- Share the vulnerability with others

### Please DO:

1. Email us at free4fun@riseup.net with:
 - Description of the vulnerability
 - Steps to reproduce
 - Possible impact
 - Any additional details that could help us address the issue

2. Give us reasonable time to respond and fix the issue before disclosure

### What to expect:

1. **Acknowledgment**: We will acknowledge your email within 24 hours

2. **Updates**: We will keep you informed of our progress
 - Initial assessment: 48 hours
 - Regular updates every 72 hours
 - Final resolution timeline provided within a week

3. **Resolution**: Once the vulnerability is fixed
 - We will notify you
 - We will issue a security advisory
 - You will be credited for the discovery (unless you prefer to remain anonymous)

## Bug Bounty Program

We run a bug bounty program for our smart contracts. Rewards are based on severity:

| Severity | Description | Reward |
|----------|-------------|--------|
| Critical | Funds can be stolen/locked | Up to 25 Sepolia ETH |
| High | Protocol functionality severely impacted | Up to 12 Sepolia ETH |
| Medium | Limited impact on protocol security | Up to 6 Sepolia ETH |
| Low | Minor issues with minimal impact | Up to 1 Sepolia ETH |

### Scope

#### In scope:
- All deployed smart contracts
- Frontend interactions with smart contracts
- Economic attacks
- Logic bugs
- Access control issues

#### Out of scope:
- Already reported issues
- Issues in dependencies
- Issues requiring > $100k for exploitation
- Theoretical issues without proof of concept
- Front-end issues not affecting smart contract interaction

## Security Measures

### Smart Contract Security

1. **Audits**
 - Regular audits by leading firms
 - Public audit reports available
 - Continuous monitoring

2. **Testing**
 - 100% test coverage requirement
 - Extensive integration tests
 - Automated security scans

3. **Access Controls**
 - Multi-signature requirements
 - Time-locks on critical functions
 - Role-based access control

### Incident Response

In case of a security incident:

1. **Immediate Actions**
 - Pause affected contracts if possible
 - Notify affected users
 - Begin incident investigation

2. **Communication**
 - Regular updates via official channels
 - Transparent post-mortem reports
 - Clear remediation steps

3. **Recovery**
 - Implementation of fixes
 - Third-party verification
 - Gradual system restoration

## Contact

- Security Email: free4fun@riseup.net
- PGP Key: [Download PGP Key](https://your-protocol.com/pgp-key.asc)
- Discord Security Channel: [Join Discord](https://discord.gg/your-discord)

## Recent Security Advisories

| Date | Description | Status |
|------|-------------|--------|
| 2024-01-01 | Project started | Working |

_Last updated: December 1, 2024_
