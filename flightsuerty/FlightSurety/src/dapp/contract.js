import FlightSuretyApp from '../../build/contracts/FlightSuretyApp.json';
import Config from './config.json';
import Web3 from 'web3';

export default class Contract {
    constructor(network, callback) {

        let config = Config[network];
        this.web3 = new Web3(new Web3.providers.HttpProvider(config.url));
        this.flightSuretyApp = new this.web3.eth.Contract(FlightSuretyApp.abi, config.appAddress);
        this.initialize(callback);
        this.owner = null;
        this.airlines = [];
        this.passengers = [];  
        this.flights = []; 
        this.flightarray = ["AirIndia","British Airways","Air Asia","Malasiyan Airlines","Lufthansa"];
    }

    initialize(callback) {
        this.web3.eth.getAccounts((error, accts) => {
            this.owner = accts[0];

            // alert(JSON.stringify(accts));
            // alert(this.flightarray.length);

            let counter = 1;
            let ctr=0;
            setTimeout(() => {
                for(let i=0;i < this.flightarray.length;i++) {
                    // alert(this.flightarray[i]);
                    this.flights.push({
                        airline: accts[i],
                        flight: this.flightarray[i],
                        timestamp: new Date(Date.now() - 100000)
                    });
    
                // alert(JSON.stringify(this.flights));
            }
                
            }, 2000);
           
            
            while(this.airlines.length < 5) {
                this.airlines.push(accts[counter++]);
            }

            while(this.passengers.length < 5) {
                this.passengers.push(accts[counter++]);
            }
            
           


            callback();
        });
    }

    isOperational(callback) {
       let self = this;
       self.flightSuretyApp.methods
            .isOperational()
            .call({ from: self.owner}, callback);
    }

    fetchFlightStatus(flight, callback) {
        let self = this;
        let payload = {
            airline: self.airlines[0],
            flight: flight,
            timestamp: Math.floor(Date.now() / 1000)
        } 
        self.flightSuretyApp.methods
            .fetchFlightStatus(payload.airline, payload.flight, payload.timestamp)
            .send({ from: self.owner}, (error, result) => {
                callback(error, payload);
            });
    }

    registerAirline(airlineAddress) {
        let self = this;
        self.flightSuretyApp.methods
          .registerAirline(airlineAddress)
          .send({ from: self.owner }, (error, result) => {
    
          });
      }

    fundAirline(airlineAddress) {
        let self = this;
        let fee = this.weiMultiple * this.fund_fee; // fund fee
    
        self.flightSuretyApp.methods
          .fund()
          .send({ from: airlineAddress, value: fee }, (error, result) => {
    
          });
    
      }


      submitOracleResponse(indexes, airline, flight, timestamp, callback) {
        let self = this;
    
        let payload = {
          indexes: indexes,
          airline: self.airlines[2],
          flight: flight,
          timestamp: timestamp,
          statusCode: self.STATUS_CODES[Math.floor(Math.random() * self.STATUS_CODES.length)]
        }
        self.flightSuretyApp.methods
          .submitOracleResponse(payload.indexes, payload.airline, payload.flight, payload.timestamp, payload.statusCode)
          .send({ from: self.owner }, (error, result) => {
            callback(error, payload);
          });
      }

}