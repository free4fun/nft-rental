// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface INFTRegistry {
    event CreatorRegistred(
        address indexed nftContract,
        uint256 indexed tokenId,
        address indexed creator,
        uint256 royaltyPercentage
    );

    event RoyaltyPercentageUpdated(
        address indexed nftContract,
        uint256 indexed tokenId,
        address indexed creator,
        uint256 royaltyPercentage
    );

    function registerCreator(
        address nftContract,
        uint256 tokenId,
        address creator,
        uint256 royaltyPercentage
    ) external;

    function getCreatorInfo(address nftContract, uint256 tokenId) external view returns (address creator, uint256 royaltyPercentage);

    function updateRoyaltyPercentage(
        address nftContract,
        uint256 tokenId,
        uint256 newRoyaltyPercentage
    ) external;
}