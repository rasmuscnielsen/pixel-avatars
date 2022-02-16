// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";
import "hardhat/console.sol";

/// @author Developer DAO
/// @title The Pixel Avatar smart contract that is compliant to ERC721 standard and is upgradeable
contract PixelAvatars is
    ERC721EnumerableUpgradeable,
    ReentrancyGuardUpgradeable,
    OwnableUpgradeable
{
    string public baseURI;
    uint256 public mintPrice;
    address public serverAddress;

    function initialize() public initializer {
        __ERC721_init("Pixel Avatars", "PXLDEV");
        __Ownable_init();

        baseURI = "ipfs://QmQK8MYcafSRLXTG8azwTs51B7vj7iZGVxGxdEHwUMDXUQ/";
        mintPrice = 12 ether;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setMintPrice(uint256 _newPrice) public onlyOwner {
        // Mint price in wei
        mintPrice = _newPrice;
    }

    function setServerAddress(address _address) public onlyOwner {
        serverAddress = _address;
    }

    event LogTokenMinted(address minter, uint256 tokenId);

    modifier validServerSignature(
        uint256 tokenId,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) {
        bytes memory message = abi.encodePacked(
            "TokenId:",
            StringsUpgradeable.toString(tokenId),
            "Address:",
            msg.sender,
            "Deadline:",
            StringsUpgradeable.toString(deadline)
        );

        address signer = ecrecover(keccak256(message), v, r, s);

        require(signer == serverAddress, string("Invalid server signature"));
        require(block.timestamp <= deadline, "Signature expired");

        _;
    }

    function mintWithSignature(
        uint256 tokenId,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    )
        public
        payable
        nonReentrant
        validServerSignature(tokenId, deadline, v, r, s)
    {
        require(mintPrice <= msg.value, "Not enough ether sent");

        _safeMint(msg.sender, tokenId);

        emit LogTokenMinted(msg.sender, tokenId);
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
