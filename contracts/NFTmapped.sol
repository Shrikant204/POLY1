
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721A.sol";

contract NFTmapped is ERC721A, Ownable {
    using Strings for uint256;
    string[] description=["pixel art of a kitsune","a 2d 16-bit pixel orange cat with purple stripes on its arms walking right.","Shibu Inu dog excited and happy in Miami at Club Space with a laptop writing code","fluffy cute pink water dragon smoking a cigarette","a family snake flag by style  of adam adamowicz illustration design concept, unreal 5, daz, hyperrealistic, octane render,, fantasy symbol dynamic lighting, intricate detail, harvest fall vibrancy, cinematic volume inner glowing aura global illumination ray tracing hdr, green and black scheme color,  coat of arms  green and black color, snake symbol"];
    uint _mintAmount=5;
    string public baseURI="ipfs://bafybeie7scvr4aolzssbiqtao4h3kdfhkwie62pxb6wcanuhhmynjzwdvq/";
    string public baseExtension = ".json";
    uint tokenNo;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721A(_name, _symbol) {
        mintCollection(msg.sender);
    }

    // internal
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    // public
    function mintCollection(address _to) public onlyOwner{
        _mint(_to,_mintAmount);
        
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        (tokenId%5).toString(),
                        baseExtension
                    )
                )
                : "";
    }
    function promptDescription(uint tokenId) public view returns(string memory desc){
        return description[tokenId%5];
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }
}