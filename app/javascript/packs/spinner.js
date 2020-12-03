const toggleSpinner = () => {
  const searchButton = document.getElementById("search-icon");
  const spinner = document.getElementsByClassName("search-spinner")[0]
  if (searchButton) {
    searchButton.addEventListener("click",()=> {
      spinner.style.display = "block";
    })
  }
}
export {toggleSpinner};
