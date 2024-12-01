# Contributing to NFT Rental Protocol

First off, thank you for considering contributing to the NFT Rental Protocol. It's people like you that make this protocol a great tool for the Web3 community.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* Use a clear and descriptive title
* Describe the exact steps which reproduce the problem
* Provide specific examples to demonstrate the steps
* Describe the behavior you observed after following the steps
* Explain which behavior you expected to see instead and why
* Include screenshots if possible

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When you are creating an enhancement suggestion, please include:

* Use a clear and descriptive title
* Provide a step-by-step description of the suggested enhancement
* Provide specific examples to demonstrate the steps
* Describe the current behavior and explain which behavior you expected to see instead
* Explain why this enhancement would be useful

### Pull Requests

* Fill in the required template
* Do not include issue numbers in the PR title
* Follow the JavaScript/TypeScript and Solidity styleguides
* Include screenshots and animated GIFs in your pull request whenever possible
* End all files with a newline
* Avoid platform-dependent code

## Development Process

1. Fork the repository
2. Create a new branch from `develop`:
 ```bash
 git checkout -b feature/your-feature-name
 ```
3. Make your changes
4. Run the tests:
 ```bash
 yarn test
 ```
5. Run the linter:
 ```bash
 yarn lint
 ```
6. Commit your changes using conventional commits:
 ```bash
 git commit -m "feat: add new feature"
 ```
7. Push to your fork
8. Create a Pull Request

### Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

* `feat:` New feature
* `fix:` Bug fix
* `docs:` Documentation only changes
* `style:` Changes that do not affect the meaning of the code
* `refactor:` Code change that neither fixes a bug nor adds a feature
* `perf:` Code change that improves performance
* `test:` Adding missing tests
* `chore:` Changes to the build process or auxiliary tools

## Setting up your development environment

1. Install dependencies:
 ```bash
 yarn install
 ```

2. Copy `.env.example` to `.env`:
 ```bash
 cp .env.example .env
 ```

3. Configure your environment variables

4. Run local hardhat node:
 ```bash
 yarn hardhat node
 ```

5. Deploy contracts locally:
 ```bash
 yarn deploy:local
 ```

## Testing

### Running tests
```bash
# Run all tests
yarn test

# Run specific test file
yarn test test/unit/NFTRental.test.ts

# Run with coverage
yarn test:coverage
```

### Writing tests

- Place unit tests in `test/unit/`
- Place integration tests in `test/integration/`
- Follow the existing test structure
- Use meaningful descriptions
- Test both success and failure cases
- Use fixtures for complex setups

## Documentation

- Update documentation when you change code
- Use JSDoc comments for functions
- Keep the README.md up to date
- Document all events emitted by contracts
- Include inline comments for complex logic

## Questions?

Feel free to ask for help in our [Discord channel](https://discord.gg/your-discord) or create a discussion on GitHub.
