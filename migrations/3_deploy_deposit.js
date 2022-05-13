const DepositContract = artifacts.require('Deposit')

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(DepositContract)
    const deposit = await DepositContract.deployed()
    await deposit.deposit(deposit.address, '0x0324202', {value: '1000'})
    
    console.log(await deposit.getBalance2(deposit.address))
    console.log(await deposit.deposits(deposit.address))
    console.log(await deposit.getBalance())
}