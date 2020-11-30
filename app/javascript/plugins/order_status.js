// Find the elements that displays the current status on confirmation page
// If present
// Set_time_out from JS
    // call our endpoint (/order-status)
    // if different from current status then update
    // Make changes here ( classes etc )

const find_status = () => {
  const status = document.getElementById("order-status")
  if (status) {
    setTimeout( function() {
      fetch('/check-status', { headers: {accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          console.log(data.status)
        });
    }, 1000);
  }
}


export { find_status };
