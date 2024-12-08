// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

interface INFTLibrary {
    struct LendingTerms {
        uint256 pricePerDay;
        uint256 maxRentDuration;
        bool isRentable;
    }

    struct Rent {
        uint256 rentId;
        address nftContract;
        uint256 tokenId;
        address renter; //Owner of the NFT
        address borrower; //Who is renting the NFT
        uint256 startTime;
        uint256 duration;
        uint256 totalFee;
    }

    event NFTListed(
        address indexed nftContract,
        uint256 indexed tokenId,
        address indexed renter,
        uint256 maxRentDuration
    );

    event NFTRented(
        uint256 indexed rentId,
        address indexed borrower,
        uint256 duration,
        uint256 pricePerDay
    );

    event NFTReturned(
        uint256 indexed rentId,
        address indexed borrower
    );
    
    function listNFT(
        address nftContract,
        uint256 tokenId,
        uint256 pricePerDay,
        uint256 maxDuration
    ) external;

    function rentNFT(
        address nftContract,
        uint256 tokenId,
        uint256 duration
    ) external payable;

    function returnNFT(uint256 rentId) external;
}