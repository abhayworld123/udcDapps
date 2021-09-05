
import DOM from './dom';
import Contract from './contract';
import './flightsurety.css';


(async() => {

    let result = null;

    let contract = new Contract('localhost', () => {

        // Read transaction
        contract.isOperational((error, result) => {


           setTimeout(() => {
            //  alert(JSON.stringify(contract.flights));
             let flight;
             let el;
             for(let i=0;i<contract.flights.length+1; i++){
                 el = document.createElement("option");

                flight = contract.flights[i];
                //  alert(JSON.stringify(contract.flights[i]));
                // console.log(contract.flights[0]);
                el.text = `${flight.flight} - ${new Date((flight.timestamp))}`;
                el.value = flight.flight;
                console.log(JSON.stringify(el));
                DOM.flightSelector.add(el);
                
                $('#flights-selector').change(()=>{
                    let val =  $('#flights-selector').val();
                   $('#flight-number').val(val);
                 });  

             }
          

             
           setTimeout(() => {
            //    let yourSelect= document.getElementById("flights-selector");
               $('#flights-selector').change(()=>{
                   let val =  $('#flights-selector').val();
                   alert(2);
                  $('#flight-number').val(val);
                });  
           }, 4700);
    
         
               
           }, 3500);
           

            console.log(error,result);
            display('Operational Status', 'Check if contract is operational', [ { label: 'Operational Status', error: error, value: result} ]);
           
           

        });
    

        // User-submitted transaction
        DOM.elid('submit-oracle').addEventListener('click', () => {
            let flight = DOM.elid('flight-number').value;
            // Write transaction
            contract.fetchFlightStatus(flight, (error, result) => {
                display('Oracles', 'Trigger oracles', [ { label: 'Fetch Flight Status', error: error, value: result.flight + ' ' + result.timestamp} ]);
            });

            
        })
    
    });
    

})();


function display(title, description, results) {
    let displayDiv = DOM.elid("display-wrapper");
    let section = DOM.section();
    section.appendChild(DOM.h2(title));
    section.appendChild(DOM.h5(description));
    results.map((result) => {
        let row = section.appendChild(DOM.div({className:'row'}));
        row.appendChild(DOM.div({className: 'col-sm-4 field'}, result.label));
        row.appendChild(DOM.div({className: 'col-sm-8 field-value'}, result.error ? String(result.error) : String(result.value)));
        section.appendChild(row);
    })
    displayDiv.append(section);
}







