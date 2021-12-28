import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";
import { expect } from "chai";


describe("hello world", function() {
    it("should say hi", async function() {
        // TEST STEPS
        //1. Setup
        //2. Deploy
        //3. call function


        //2.
        const HelloWorld = await ethers.getContractFactory("HelloWorld");
        const hello = await HelloWorld.deploy();
        await hello.deployed();
        //3.
        expect(await hello.hello()).to.equal("Hello, World");
    });
})