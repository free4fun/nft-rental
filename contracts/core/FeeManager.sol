// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

import "../interfaces/IFeeManager.sol";
import "../interfaces/INFTRegistry.sol";

abstract contract FeeManager is IFeeManager, Ownable, ReentrancyGuard {

    //Constants
    uint256 private constant _BASIS_POINTS = 10000;
    uint256 public constant MAX_PROTOCOL_FEE = 500; // 5% maximum protocol fee

    //State variables
    uint256 public protocolFee = 250; // 2.5% protocol fee
    uint256 public minimumRentalFee; // Minimum rental fee
    uint256 public accumulatedProtocolFees; // Accumulated protocol fees

    INFTRegistry public nftRegistry;

    // Additional Events
    event FeeDistributionFailed(
        address indexed recipient,
        uint256 amount,
        string reason
    );

    error InvalidNFTRegistryAddress();
    error ProtocolFeeExceedsMaximum();
    error WithdrawFailed();
    error InvalidRecipient();
    error RentalFeeBelowMinimum();

    constructor(
        address _nftRegistry,
        uint256 _initalProtocolFee
    ) Ownable(msg.sender) {
        if (_nftRegistry == address(0)) {
            revert InvalidNFTRegistryAddress();
        }
        if (_initalProtocolFee > MAX_PROTOCOL_FEE) {
            revert ProtocolFeeExceedsMaximum();
        }

        nftRegistry = INFTRegistry(_nftRegistry);
        protocolFee = _initalProtocolFee;
    }
            
    
    
    /**
    * @dev Distributes the rental fee between the creator, renter and protocol
    * @param nftContract Address of the NFT contract
    * @param tokenId ID of the NFT token
    * @param renter Address of the renter
    * @param rentalFee Amount of the rental fee
    */
    function distributeFee(
        address nftContract,
        uint256 tokenId,
        address renter,
        uint256 rentalFee
    ) external payable override nonReentrant {
        if (rentalFee < minimumRentalFee) {
            revert RentalFeeBelowMinimum();
        }

        // Get creaton information
        (address creator, uint256 royaltyPercentage) = nftRegistry.getCreatorInfo(nftContract, tokenId);

        // Calculate fees
        uint256 protocolAmount = rentalFee * protocolFee / _BASIS_POINTS;
        uint256 creatorAmount = creator != address(0) ? rentalFee * royaltyPercentage / _BASIS_POINTS : 0;
        uint256 renterAmount = rentalFee - protocolAmount - creatorAmount;

        // Update accumulated protocol fees
        accumulatedProtocolFees = accumulatedProtocolFees + protocolAmount;

        // Distribute fees
        bool success;

        // Pay the creator
        if (creator != address(0) && creatorAmount > 0) {
            (success, ) = payable(creator).call{value: creatorAmount}("");
            if (!success) {
                emit FeeDistributionFailed(creator, creatorAmount, "Failed to pay creator");
                accumulatedProtocolFees = accumulatedProtocolFees + creatorAmount;
            }
        }

        // Pay the renter
        (success, ) = payable(renter).call{value: renterAmount}("");
        if (!success) {
            emit FeeDistributionFailed(renter, renterAmount, "Failed to pay renter");
            accumulatedProtocolFees = accumulatedProtocolFees + renterAmount;
        }

        emit FeeDistributed(nftContract, tokenId, renter, creatorAmount, renterAmount, protocolAmount);
    }

    /**
    * @dev Updates the protocol fee
    * @param newFee New protocol fee in 10000 basis points
    */
    function updateProtocolFee(uint256 newFee) external override onlyOwner {
        if (newFee > MAX_PROTOCOL_FEE) {
            revert ProtocolFeeExceedsMaximum();
        }
        emit ProtocolFeeUpdated(newFee);
        protocolFee = newFee;
    }

    /**
    * @dev Update the minimum rental fee
    * @param newFee New minimum rental fee
    */
    function updateMinimumRentalFee(uint256 newFee) external onlyOwner {
        emit MinimunRentalFeeUpdated(newFee);
        minimumRentalFee = newFee;
    }

    /**
    * @dev Withdraw accumulated protocol fees
    * @param recipient Address to receive the protocol fees
    */
    function withdrawProtocolFees(address recipient) external onlyOwner {
        if (recipient == address(0)) {
            revert InvalidRecipient();
        }
        uint256 amount = accumulatedProtocolFees;
        accumulatedProtocolFees = 0;
            
        (bool success, ) = recipient.call{value: amount}("");
        if (!success) {
            revert WithdrawFailed();
        }
        
        emit WithdrawalExecuted(recipient, amount);
    }

    /**
    * @dev Get actual balance of the contract
    */
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
        
    /**
    * @dev Allow to receive ether
    */
    receive() external payable {}
}