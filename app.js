

//initiating main function
function fetchData() {

    let monthInput = document.getElementById("numForMonth").value;
    let dayInput = document.getElementById("numForDay").value;
    const baseUrl = "http://history.muffinlabs.com/date";
    let goFetch = `${baseUrl}/${monthInput}/${dayInput}`;
    //console.log(goFetch)


    
    //chain a dot.then to the promise to deal with its responce using and arrow function at the end.
    fetch(goFetch)
    
    //fetch("http://history.muffinlabs.com/date?/")

        .then(response => {
        //console.log(goFetch);
        //console.log(response);
            mode = "no-cors";
        
            //catching err 
            if (!response.ok) {
                throw Error("ERROR");
            }
            
            // if no error return data when ready in JSON format
            return response.json();
                  

        })
        
        //chain another dot.then to manipulate the data
        .then(data => {
            //testing api call
            //console.log(data.data);
            //console.log(data);
            //console.log(data.data.Events);
            //console.log(data.data.Births);
            //console.log(data.data.Deaths);
        
            //map the content we want and return it.
            const events = data.data.Events.map(event => {
 
                return `<p>In ${event.year} ${event.text}</p>`;
            })   

            .join("");

            const births = data.data.Births.map(birth => {
                
                return `<p>${birth.year} ${birth.text}</p>`
            })
                            
            //lets get rid of the array.
            .join("");

            const deaths = data.data.Deaths.map( deaths => {

                return `<p>${deaths.year} ${deaths.text}</p>`
            })
            .join("");


            //testing
            //console.log(res);
            document
                // inject res into the dom
                //first the events
                document.querySelector("#eventsTile").innerHTML = "These Events occurred throughout history on the same day you were Born!"
                document.querySelector("#events").innerHTML = `${events}`;
                document.querySelector("#birthsTile").innerHTML = "You share your B-Day! with some of these people!"
                document.querySelector("#births").innerHTML = `${births}`;
                document.querySelector("#deathsTile").innerHTML = "These people passed away the day that you were born.";
                document.querySelector("#deaths").innerHTML = `${deaths}`;
        
        })

        // set some err catching next
        .catch(error => {
            console.log(error);
        });
        

}

//call
//fetchData();