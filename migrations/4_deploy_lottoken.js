const LotToken = artifacts.require("LotToken");
const LotTokenSale = artifacts.require("LotTokenSale")
// artifacts: allows us to create contract abstraction 
// that truffle can use to run in a JS runtime env
module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(LotToken, 1000000)
  const lotToken = await LotToken.deployed()

  await deployer.deploy(LotTokenSale, LotToken.address, 1000000000000000)
  const lotTokenSale = await LotTokenSale.deployed()

  // await lotToken.approve(LotTokenSale.address, 10000)

  // console.log('Balance Before Transfer', await lotToken.balanceOf(accounts[0]))
  console.log('Balance Before Transfer', await lotToken.balanceOf(LotTokenSale.address))
  await lotToken.transfer(LotTokenSale.address, 10000)
  console.log('Balance After Transfer', await lotToken.balanceOf(LotTokenSale.address))

  // console.log('Balance of Lot', await lotToken.balanceOf(accounts[0]))
  // await lotTokenSale.buyTokens(10, {value: 10000000000000000})
  // console.log('Balance of Lot', await lotToken.balanceOf(accounts[0]))
};