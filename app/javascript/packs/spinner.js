const toggleSpinner = () => {
console.log("hello from toggleSpinner")
  const searchButton = document.getElementById("search-icon")
  const spinner = document.getElementsByClassName("search-spinner")[0]
  console.log(searchButton, spinner)
  searchButton.addEventListener("click",()=> {
    spinner.style.display = "block"
  })
}
export {toggleSpinner};
