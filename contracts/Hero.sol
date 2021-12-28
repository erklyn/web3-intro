// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Hero {
    enum Class { Mage , Healer , Barbarian}

    mapping(address => uint[]) addressToHeroes;


    function generateRandom() public virtual view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    }      

    function getHeroes() public view returns (uint[] memory){
        return addressToHeroes[msg.sender];
    }

    function addStrength(uint hero) public pure returns (uint32) {
        return uint32((hero >> 2) & 0x1F);
    }
    function addHealth(uint hero) public pure returns (uint32) {
        return uint32((hero >> 7) & 0x1F);
    }   
    function addDexterity(uint hero) public pure returns (uint32) {
        return uint32((hero >> 12) & 0x1F);
    }
    function addIntelligence(uint hero) public pure returns (uint32) {
        return uint32((hero >> 17) & 0x1F);
    }
    function addMagic(uint hero) public pure returns (uint32) {
        return uint32((hero >> 22) & 0x1F);
    } 


    function createHero(Class class) public payable {
        require(msg.value >= 0.05 ether, "Payment is minimum of 0.05");

        uint[] memory stats = new uint[](5);
        stats[0] = 2;
        stats[1] = 7;
        stats[2] = 12;
        stats[3] = 17;
        stats[4] = 22;

        uint len = 5;
        uint hero = uint(class);
        do{
            uint pos = generateRandom() % len;
            uint value = generateRandom() % (13 + len) + 1;
            hero |= value << stats[pos];
            len--;
            stats[pos]=stats[len];

        }while(len > 0);
    
        addressToHeroes[msg.sender].push(hero);


    }
}