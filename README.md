# Eth Proof: Intermediate EVM Course 
# Smart contract Management 
# Project

After cloning the github, you will want to do the following to get the code running on your computer.

1. Inside the project directory, in the terminal type: npm i  // this will install all the depencance needed 
2. Open two additional terminals in your VS code
3. In the second terminal type: npx hardhat node  // this will get a local hardhat node
4. In the third terminal, type: npx hardhat run --network localhost scripts/deploy.js // this will deploy smart contract to hardhat node from above
5. Back in the first terminal, type npm run dev to launch the front-end.  // this will launch the app to interact with the smart contract running on your local node

After this, the project will be running on your localhost. 
Typically at http://localhost:3000/

Then connect your metamask wallet and you will be able to send 1 or 10 Eth to smart contract and also be able to withdraw.

You will see running count of withdraws and deposits to the account.
