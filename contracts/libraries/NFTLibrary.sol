// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

import "../interfaces/INFTLibrary.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./SafeNFTTransferLibrary.sol";

contract NFTLibrary is INFTLibrary, ReentrancyGuard {
    using SafeNFTTransferLibrary for address;

    //Constants
    uint256 public constant CREATOR_FEE = 1000; //10%
    uint256 public constant PROTOCOL_FEE = 500; //5%
    uint256 public constant BASIS_POINTS = 10000;

    //Mappings
    mapping(address => mapping(uint256 => LendingTerms)) public lendingTerms;
    mapping(uint256 => Rent)  public rents;
    mapping(address => mapping(uint256 => address)) public nftCreators;

    uint256 private _rentCounter;

    error PricePerDayMustBeGreaterThanZero();
    error MaxDurationMustBeGreaterThanZero();
    error NFTNotAvailable();
    error DurationExceedsMaxRentDuration();
    error InsufficientFunds();
    error OnlyRenterCanReturn();
    error RentDurationNotOver();

    constructor() {
        _rentCounter = 0;
    }

    function listNFT(
        address nftContract,
        uint256 tokenId
    ) external override nonReentrant {
        if (pricePerDay <= 0) revert PricePerDayMustBeGreaterThanZero();
        if (maxDuration <= 0) revert MaxDurationMustBeGreaterThanZero();
        if (pricePerDay <= 0) revert PricePerDayMustBeGreaterThanZero();
        if (maxDuration <= 0) revert MaxDurationMustBeGreaterThanZero();

        // Transfer the NFT to this contract
        nftContract.safeTransferNFT(msg.sender, address(this), tokenId);

        // Register rental terms
        lendingTerms[nftContract][tokenId] = LendingTerms({
            pricePerDay: pricePerDay,
            maxRentDuration: maxDuration,
            isAvailable: true
        });

        emit NFTListed(nftContract, tokenId, msg.sender, maxDuration);
    }

    function rentNFT(
        uint256 duration
    ) external payable override nonReentrant {
        LendingTerms memory terms = lendingTerms[nftContract][tokenId];
        if (!terms.isAvailable) revert NFTNotAvailable();
        if (duration > terms.maxRentDuration) revert DurationExceedsMaxRentDuration();
        if (msg.value < totalFee) revert InsufficientFunds();
        if (!terms.isAvailable) revert NFTNotAvailable();
        if (duration > terms.maxRentDuration) revert DurationExceedsMaxRentDuration();

        uint256 totalFee = terms.pricePerDay * duration;
        if (msg.value < totalFee) revert InsufficientFunds();

        // Create rent
        uint256 rentId = _rentCounter++;
        rents[rentId] = Rent({
            rentId: rentId,
            nftContract: nftContract,
            tokenId: tokenId,
            renter: msg.sender,
            borrower: msg.sender,
            startTime: block.timestamp,
            duration: duration,
            totalFee: totalFee
        });

        // Distribute fees
        _diasburseFees(nftContract, tokenId, totalFee);

        // Transfer NFT to borrower
        IERC71(nftContract).safeTransferFrom(address(this), msg.sender, tokenId);

        terms.isAvailable = false;

        emit NFTRented(rentId, msg.sender, duration, totalFee);
    }

    function _distributeFees(
        address nftContract,
        uint256 tokenId,
        uint256 totalFee
    ) internal {
        address creator = nftCreators[nftContract][tokenId];
        address owner = IERC71(nftContract).ownerOf(tokenId);
        
        // Calculate fees
        uint256 creatorFee = (totalFee * CREATOR_FEE) / BASIS_POINTS;
        uint256 protocolFee = (totalFee * PROTOCOL_FEE) / BASIS_POINTS;
        uint256 ownerFee = totalFee - creatorFee - protocolFee;

        // Transfer fees
        if (creator != address(0)) {
            payable(creator).transfer(creatorFee);
        }
        payable(owner).transfer(ownerFee);
    }

    function returnNFT(uint256 rentId) external override nonReentrant {
        Rent memory rent = rents[rentId];
        if (rent.borrower != msg.sender) revert OnlyRenterCanReturn();
        if (block.timestamp < rent.startTime + rent.duration * 1 days) revert RentDurationNotOver();
        
        // Transfer NFT back to renter
        IERC71(rent.nftContract).safeTransferFrom(
            msg.sender,
            address(this),
            rent.tokenId
        );

        // Mark NFT as available
        lendingTerms[rent.nftContract][rent.tokenId].isAvailable = true;

        emit NFTReturned(rentId, msg.sender);
    }

}