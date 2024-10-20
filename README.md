# AfterPay

## Introduction

AfterPay is a simplified installment payment smart contract written in Solidity. It allows a seller and a buyer to engage in an installment payment agreement, utilizing Chainlink's ETH/USD price feed for accurate conversions. The contract is designed to be minimalistic, focusing on essential functionalities required for an installment payment system.

## Overview

The project consists of two Solidity files:

1. **`PriceConverter.sol`**: A library that provides utility functions for converting between ETH and USD using Chainlink price feeds.
2. **`AfterPay.sol`**: The main contract that handles the installment payment logic between a seller and a buyer.

## Development Process

### Initial Requirements

- **Installment Payment Functionality**: Enable a buyer to pay for an item in installments until the total price is fully paid.
- **ETH/USD Conversion**: Use real-time price data to calculate the ETH amount required for each installment based on a fixed USD value.
- **Simplicity**: Keep the contract as simple as possible, focusing only on essential functions.

### Iterative Simplifications

1. **Removing Non-Essential Features**: Stripped away any enforcement mechanisms, penalties, and complex ownership logic not critical for the basic functionality.
2. **Utilizing Libraries**: Introduced the `PriceConverter.sol` library to handle price conversions, keeping the main contract clean and focused.
3. **Single Item Focus**: Simplified the contract to handle a single installment agreement between a seller and a buyer, avoiding complexities related to multiple items or users.
4. **Streamlining Code**: Removed unnecessary variables, modifiers, and functions, ensuring that only the bare minimum code necessary for installment payments remained.

### Final Design Choices

- **State Variables**: Limited to tracking essential information such as seller, buyer, total price, installment amount, and payment status.
- **Constructor Parameters**: The seller sets up the contract by specifying the buyer's address, total price, and installment amount in USD.
- **Modifiers**: Used `onlyBuyer` to restrict the `payInstallment` function to the buyer.
- **ETH/USD Conversion**: Implemented using the `PriceConverter` library, which fetches real-time price data from Chainlink.

## Final Solution

### 1. `PriceConverter.sol`

A library that provides two key functions:

- **`getPrice()`**: Fetches the latest ETH/USD price from the Chainlink data feed.
- **`getEthAmountFromUsd(uint256 usdAmount)`**: Converts a USD amount to the equivalent ETH amount in wei.

### 2. `InstallmentPayment.sol`

The main contract with the following features:

- **Participants**: `seller` (contract deployer) and `buyer` (specified in the constructor).
- **Payment Terms**:
  - `totalPriceUSD`: The total price of the item in USD.
  - `installmentAmountUSD`: The amount to be paid in each installment.
  - `totalInstallments`: Calculated using ceiling division based on the total price and installment amount.
- **Payment Tracking**:
  - `amountPaidUSD`: Total amount paid by the buyer.
  - `installmentsPaid`: Number of installments completed.
  - `isFullyPaid`: Boolean indicating if the total price has been fully paid.
- **Core Functions**:
  - **Constructor**: Initializes the contract with the buyer's address and payment terms.
  - **`payInstallment()`**: Allows the buyer to make an installment payment by sending the required ETH amount.
  - **`getInstallmentEthAmount()`**: Returns the ETH amount required for the next installment.


## Usage Instructions

### Deployment

1. **Prepare the Files**: Ensure you have both `PriceConverter.sol` and `InstallmentPayment.sol` in your Solidity development environment.

2. **Compile the Contracts**: Use Solidity compiler version `0.8.18` or higher.

3. **Deploy `InstallmentPayment.sol`**:

   - **Seller Deploys the Contract**: The account deploying the contract becomes the `seller`.
   - **Constructor Arguments**:
     - `_buyer`: Address of the buyer.
     - `_totalPriceUSD`: Total price of the item in USD (e.g., `1000` for $1,000.00).
     - `_installmentAmountUSD`: Installment amount in USD (e.g., `200` for $200.00).

### Buyer Actions

1. **Check Required ETH Amount**:

   - Call `getInstallmentEthAmount()` to get the ETH amount needed for the next installment.

2. **Pay an Installment**:

   - Call `payInstallment()` and send the required ETH amount.
   - Example in Remix IDE:
     - Enter the value in the "Value" field (in wei).
     - Click on `payInstallment` to make the payment.

3. **Repeat Payments**:

   - Continue making payments until `isFullyPaid` becomes `true`.

### Seller Actions

- **Receive Payments**: The seller automatically receives the ETH sent by the buyer for each installment.

### Checking Payment Status

- **Installments Paid**: View `installmentsPaid` to see how many installments have been completed.
- **Total Installments**: View `totalInstallments` to know how many installments are required.
- **Is Fully Paid**: Check `isFullyPaid` to determine if the total price has been paid.

## Conclusion

Through iterative simplifications, we developed a minimalistic installment payment contract called **AfterPay** that meets the essential requirements:

- **Simplified Design**: Focused on core functionality without unnecessary complexity.
- **Accurate Conversions**: Utilized Chainlink price feeds for real-time ETH/USD conversions.
- **Ease of Use**: Provided straightforward deployment and interaction instructions.

This contract serves as a foundational model that can be expanded or customized based on specific needs.

## Additional Notes

- **Chainlink Price Feed Address**: The price feed address used in `PriceConverter.sol` is specific to the Sepolia testnet (`0x694AA1769357215DE4FAC081bf1f309aDC325306`). Ensure to use the appropriate address for your network.

- **Decimals Handling**: All USD amounts are adjusted to 18 decimals to match ETH's wei denomination.

- **Security Considerations**: The contract assumes a level of trust between the seller and buyer. For production use, consider adding security measures and thorough testing.

## License and Attribution

- **License**: This project is licensed under the MIT License.

- **Attribution**:

  - **Chainlink**: The `PriceConverter.sol` library utilizes Chainlink's price feeds. We acknowledge Chainlink's resources and documentation for enabling real-time price data in smart contracts.
    - **Chainlink Documentation**: [Chainlink Data Feeds](https://docs.chain.link/data-feeds)
    - **GitHub Repository**: [Chainlink Smart Contract Examples](https://github.com/smartcontractkit/chainlink)

  - **Cyfrin Upgraded Solidity Course (by Patrick Collins)**: The `PriceConverter.sol` and funding functions are inspired by examples from the Cyfrin Upgraded Solidity Course. We credit Patrick Collins and the Cyfrin team for their educational resources.
    - **GitHub Repository**: [PatrickAlphaC/solidity-course-f23](https://github.com/PatrickAlphaC/solidity-course-f23)
    - **Course Website**: [Cyfrin](https://www.cyfrin.io/)

## Contact Information

If you have any questions or need further assistance, please feel free to reach out.

---

**Disclaimer**: This contract is intended for educational and testing purposes. Before deploying to a production environment, ensure thorough testing and consider security audits. Always comply with relevant laws and regulations when deploying smart contracts.