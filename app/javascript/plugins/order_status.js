// Find the elements that displays the current status on confirmation page
// If present
// Set_time_out from JS
    // call our endpoint (/order-status)
    // if different from current status then update
    // Make changes here ( classes etc )

const find_status = () => {
  const status = document.getElementById("order-status");
  const collected = document.querySelector(".confirmation-collected");
  const my_default = document.querySelector(".confirmation-default");
  const rejected = document.querySelector(".confirmation-rejected");
  if (status) {
    window.setInterval( function() {
      fetch('/check-status', { headers: {accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          if (data.status === "collected") {
            my_default.style.display = "none";
            rejected.style.display = "none";
            collected.style.display = "block";
          } else if (data.status === "rejected") {
            my_default.style.display = "none";
            collected.style.display = "none";
            rejected.style.display = "block";
          } else {
            my_default.style.display = "block";
            my_default.innerHTML = data.status;
            collected.style.display = "none";
            rejected.style.display = "none";
          }
        });
    }, 2000);
  }
}


export { find_status };
