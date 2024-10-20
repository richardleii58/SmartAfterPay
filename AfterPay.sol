// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

/**
 * @title AfterPay
 * @notice Simplified contract for handling installment payments
 */
contract InstallmentPayment {
    using PriceConverter for uint256;

    address public seller;
    address public buyer;
    uint256 public totalPriceUSD;        // Total price in USD (18 decimals)
    uint256 public installmentAmountUSD; // Installment amount in USD (18 decimals)
    uint256 public amountPaidUSD;        // Amount paid so far in USD (18 decimals)
    uint256 public installmentsPaid;
    uint256 public totalInstallments;
    bool public isFullyPaid;

    /**
     * @notice Constructor initializes the installment payment agreement
     * @param _buyer Address of the buyer
     * @param _totalPriceUSD Total price of the item in USD (e.g., $1000.00 -> 1000)
     * @param _installmentAmountUSD Amount per installment in USD (e.g., $200.00 -> 200)
     */
    constructor(
        address _buyer,
        uint256 _totalPriceUSD,
        uint256 _installmentAmountUSD
    ) {
        seller = msg.sender; // The deployer is the seller
        buyer = _buyer;
        totalPriceUSD = _totalPriceUSD * 1e18; // Adjust to 18 decimals
        installmentAmountUSD = _installmentAmountUSD * 1e18; // Adjust to 18 decimals
        require(_installmentAmountUSD > 0, "Installment amount must be greater than zero");
        require(_totalPriceUSD >= _installmentAmountUSD, "Total price must be greater than installment amount");
        totalInstallments = (totalPriceUSD + installmentAmountUSD - 1) / installmentAmountUSD; // Ceiling division
    }

    /**
     * @notice Modifier to restrict function access to the buyer
     */
    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this function");
        _;
    }

    /**
     * @notice Buyer pays an installment
     */
    function payInstallment() public payable onlyBuyer {
        require(!isFullyPaid, "Item already fully paid");
        require(installmentsPaid < totalInstallments, "All installments paid");

        // Calculate required ETH amount for the installment
        uint256 requiredEth = installmentAmountUSD.getEthAmountFromUsd();

        require(msg.value >= requiredEth, "Insufficient ETH amount for installment");

        // Update amount paid and installments paid
        amountPaidUSD += installmentAmountUSD;
        installmentsPaid++;

        // Check if the item is fully paid
        if (amountPaidUSD >= totalPriceUSD) {
            isFullyPaid = true;
        }

        // Transfer the payment to the seller
        (bool success, ) = payable(seller).call{value: msg.value}("");
        require(success, "Payment transfer failed");
    }

    /**
     * @notice Gets the ETH amount required for the next installment
     * @return requiredEth Amount in wei
     */
    function getInstallmentEthAmount() public view returns (uint256) {
        uint256 requiredEth = installmentAmountUSD.getEthAmountFromUsd();
        return requiredEth;
    }
}
