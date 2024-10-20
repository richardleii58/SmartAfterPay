# SmartAfterPay
# README

## Overview

This project implements a smart contract system that simulates an Afterpay-like installment payment system for ETH/USD transactions on the Sepolia testnet. The system consists of multiple Solidity files, including `PriceConsumerV3.sol`, which is used to fetch the latest ETH/USD price using Chainlink data feeds.

## File Structure

- **`PriceConsumerV3.sol`**: Imported from Chainlink's data feed examples. It provides functionality to interact with Chainlink's decentralized price feeds.

---



### Source

This contract is based on the official Chainlink data feed example contracts. It ensures compatibility and reliability by adhering to Chainlink's recommended practices.

- **Chainlink Documentation**: [Get the Latest Price](https://docs.chain.link/data-feeds/price-feeds)
- **GitHub Repository**: [Chainlink Smart Contract Examples](https://github.com/smartcontractkit/chainlink)

### Chainlink Data Feeds

Chainlink data feeds provide decentralized, tamper-resistant price data for smart contracts. By using Chainlink's network of decentralized oracles, `PriceConsumerV3.sol` can fetch the most recent and accurate ETH/USD price, which is crucial for calculating installment amounts in the `AfterPay` contract.

### Sepolia Testnet Configuration

For the Sepolia testnet, the ETH/USD price feed contract address used is:

- **ETH/USD on Sepolia**: `0x694AA1769357215DE4FAC081bf1f309aDC325306`

When deploying `PriceConsumerV3.sol`, ensure that this address is correctly specified to connect to the appropriate data feed on the Sepolia network.


## Additional Resources

- **Chainlink Official Documentation**: Learn more about Chainlink data feeds and how they secure smart contracts.
  - [Chainlink Data Feeds](https://docs.chain.link/data-feeds)
  - [Price Feeds Addresses](https://docs.chain.link/data-feeds/price-feeds/addresses)

- **Sepolia Testnet Faucet**: Get test ETH for deploying and interacting with contracts on the Sepolia network.
  - [Sepolia Faucet](https://sepolia-faucet.pk910.de/)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Disclaimer**: This project is for educational and testing purposes on the Sepolia testnet. It should not be used in production environments without proper security audits and compliance checks.