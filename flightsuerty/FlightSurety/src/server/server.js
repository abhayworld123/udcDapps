import FlightSuretyApp from "../../build/contracts/FlightSuretyApp.json";
import Config from "./config.json";
import Web3 from "web3";
import "regenerator-runtime/runtime";

import express from "express";
let oracles_no = 30;
const start_no_or = 10;
let config = Config["localhost"];
let app;
let web3 = new Web3(
  new Web3.providers.WebsocketProvider(config.url.replace("http", "ws"))
);

const airdb =
[
  {
    "id": "AI1",
    "name": "Air India"
  },
  {
    "id": "DA1",
    "name": "Deccan Air"
  },
  {
    "id": "IN1",
    "name": "Indigo Air"
  },
  {
    "id": "MA1",
    "name": "Malasian Air"
  },
  {
    "id": "AC1",
    "name": "Air Canada"
  },
  {
    "id": "US1",
    "name": "US Airlines"
  },
  {
    "id": "ET1",
    "name": "Ethiopian Airlines"
  },
  {
    "id": "BR1",
    "name": "British Airways"
  },
  {
    "id": "LH1",
    "name": "Lufthansa"
  },
  {
    "id": "JA1",
    "name": "Jet Airways"
  }
];





const temp = async () => {
  web3.eth.defaultAccount = web3.eth.accounts[0];

  let flightSuretyApp = new web3.eth.Contract(
    FlightSuretyApp.abi,
    config.appAddress
  );

  let accounts = await web3.eth.getAccounts();
  console.log("all", accounts);

  flightSuretyApp.methods
    .isOperational()
    .call()
    .then((res, err) => {
      console.log("Operational true : ", res);
    })
    .catch(() => {
      console.error("sorry");
    });

  const registration_fee_or = await flightSuretyApp.methods
    .REGISTRATION_FEE()
    .call();

  console.log(registration_fee_or);

  // let oracleObj = [];
  let oracleObj = new Map();

  if (accounts.length >= 40) {
    for (let i = 0; i < oracles_no; i++) {
      let index_or = start_no_or + i;
    //using the method from contract to register the oracle on the chain. for respective address to register for the oracle.
    console.log("oracle no ", i + 1);
      await flightSuretyApp.methods.registerOracle().send({
        from: accounts[index_or],
        value: registration_fee_or,
        gas: 5000000,
      });
      let indexes_call = await flightSuretyApp.methods
        .getMyIndexes()
        .call({ from: accounts[index_or] });
      let indexesArr = [];
      for (let j = 0; j < indexes_call.length; j++) {
        indexesArr.push(Number(indexes_call[j]));
      }

      // oracleObj[accounts[index_or]] = indexesArr;

      oracleObj.set(accounts[index_or], indexesArr);

      // console.log(oracleObj);
      
    }
    console.log("oracleObjMap", oracleObj);
  } else {
    console.log("sorry m");
  }

  flightSuretyApp.events.OracleRequest(
  {
      fromBlock: 0,
  },
   async function (error, event) {

    console.log(32);
      if (error) {
        console.log(error);
      } else {

        let index = parseInt(event.returnValues.index);

        let airlineID = event.returnValues.airline;
        let flightID = event.returnValues.flight;
        let timestamp = event.returnValues.timestamp;
        const statusCode = Math.floor(Math.random() * 6) * 10;


        console.log(
          `index/airline/flight/timestamp : ${index}/${airlineID}/${flightID}/${timestamp}`
        );
        // register all oracles
        for (let i = 0; i < oracles_no; i++) {
          let idx = start_no_or + i;
          // get oracle indexes
          const indexes = oracleObj.get(accounts[idx]);
          for (let j = 0; j < indexes.length; j++) {
            if (indexes[j] === index) {
           // random multiple of 10 in [10;50]
              try {
                await flightSuretyApp.methods.submitOracleResponse(index,airlineID,flightID,timestamp,statusCode).send(
                  { from: accounts[idx], gas: 9999999 });
                console.log(
                  "from"+ JSON.stringify(accounts[idx]) + "statsCode: " + statusCode
                );
              } catch (err) {
            
              }
            }
          }
        }
      }
    }
  );

  const app = express();

  
  const port = 5000;
  app.get("/", (req, res) => {
    res.send({
      message: "firest page",
    });
  });

  app.get("/fly", (req, res) => {
    
      res.send(JSON.stringify(airdb));
    
  });
  app.use(express.json());


  app.listen(port, () => {
    console.log(`FlightSuretyServer now listening at http://localhost:${port}`);
  });
};

temp();

export default app;
