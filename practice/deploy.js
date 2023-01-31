// Load env
const { config } = require("dotenv");
config();

const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');
const provider = new HDWalletProvider(
  process.env.OWN_PHRASE,
  // remember to change this to your own phrase!
  process.env.NETWORK_ENDPOINT
  // remember to change this to your own endpoint!
);
const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();
  const currentBalance = await web3.eth.getBalance(accounts[0]);
  console.log('Address: ', accounts[0])
  console.log('Balance: ', currentBalance)
  const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({ data: bytecode })
    .send({ gas: '0.1', from: accounts[0] });

  console.log('Contract deployed to', result.options.address);
  provider.engine.stop();
};
deploy();
