import "@nomiclabs/hardhat-ethers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Hero", function() {
    async function createHero(){
        const Hero = await ethers.getContractFactory("TestHero");
        const hero = await Hero.deploy();
        await hero.deployed();

        return hero;
    }
    let hero;
    before(async function() {
        hero = await createHero()
    });

    it("should get a zero hero array.", async function() {
        expect(await hero.getHeroes()).to.deep.equal([]);
    });

    it("should fail at creating hero cause of payment", async () => {
        let e;
        try {
            await hero.createHero(0 , {
                value: ethers.utils.parseEther("0.03")
            })
        } catch (err) {
            e = err;
        }

        expect(e.message.includes("Payment is minimum of 0.05")).to.equal(true);
    });


    it("should create hero without problem", async function() {
        const hero = await createHero();


        await hero.setRandom(69);
        await hero.createHero(0 , {
            value: ethers.utils.parseEther("0.05")
        });
        const hstat = (await hero.getHeroes())[0];
        

        expect(await hero.addMagic(hstat)).to.equal(16);
        expect(await hero.addHealth(hstat)).to.equal(2);
        

    });
});