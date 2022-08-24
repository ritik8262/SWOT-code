const main = async () => {
  const tokenFactory = await hre.ethers.getContractFactory("Token")
  const myNftFactory = await hre.ethers.getContractFactory("MyNFT")
  const [deployer] = await hre.ethers.getSigners()

  const token = await tokenFactory.deploy()
  const myNft = await myNftFactory.deploy(token.address)

  await token.deployed()
  await myNft.deployed()

  console.log("Token Contract deployed to: ", token.address)
  console.log("NFT Contract deployed to: ", myNft.address)

  var amount = 500 * 10 ** 18

  const tx = await token.mint()
  await tx.wait()
  console.log("Minted Token successfully")

  const tx1 = await myNft.mint()
  await tx1.wait()
  console.log("Minted NFT successfully")

  const approve = await token
    .connect(deployer)
    .approval(myNft.address, { value: 500 * 10 ** 18 })
  await approve.wait()
  console.log("Approved!!")

  const buyNFT = await myNft.buy()
  await buyNFT.wait()
  console.log("NFT bought successfully")

  const sell = await myNft.sell()
  await sell.wait()
  console.log("NFT sold successfully")
}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}

runMain()
