// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.28;

interface IFeeManager {
    event FeeDistributed(
        address indexed nftContract,
        uint256 indexed tokenId,
        address indexed renter,
        uint256 creatorFee,
        uint256 renterFee,
        uint256 protocolFee
    );

    event ProtocolFeeUpdated(uint256 newFee);
    event MinimunRentalFeeUpdated(uint256 newFee);
    event WithdrawalExecuted(address indexed to, uint256 amount);

    function distributeFee(
        address nftContract,
        uint256 tokenId,
        address renter,
        uint256 rentalFee
    ) external payable;

    function updateProtocolFee(uint256 newFee) external;
    function withdrawProtocolFees(address payable recipient) external;
}