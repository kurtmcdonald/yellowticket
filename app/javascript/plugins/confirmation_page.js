const waitingDots = () => {
  const dots_container = document.querySelectorAll(".waiting-circle");
  let active = 0;
  if (dots_container.length !== 0) {
    window.setInterval( function(){
      dots_container[active].classList.add("not_active");
      if (active === 2) {
        active = 0;
        dots_container[active].classList.remove("not_active");
      } else {
        active = active + 1;
        dots_container[active].classList.remove("not_active");
      }
    }, 1000);
  }
}

const find_status = () => {
  // Items for the scrolling example:
  const scroll_container = document.getElementById('container');
  const map = document.getElementById("map");
  if (container) {
    window.setInterval( function() {
      fetch('/check-status', { headers: {accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          if (data.status === "checkout") {
            confirmation_scroll(0);
            scroll_container.children[0].classList.add('active');
          } else if (data.status === "accepted") {
            confirmation_scroll(1);
            scroll_container.children[0].classList.remove('active');
            scroll_container.children[1].classList.add('active');
            // map.classList.remove("hide");
          } else if (data.status === "collected") {
            confirmation_scroll(2);
            scroll_container.children[0].classList.remove('active');
            scroll_container.children[1].classList.remove('active');
            scroll_container.children[2].classList.add('active');
            scroll_container.children[3].style.display = "inline-block";
          }
        });
    }, 2000);
  }
}

const confirmation_scroll = (num) => {
  let display = document.querySelector('.test_scroll #display');
  let container = document.getElementById('container');
  let counter = 0;

  moveContainer(num);

  function moveContainer (num) {
    let choosenOption = container.children[num];
    setTop(-choosenOption.offsetTop + 130);
  }

  function setTop (top) {
    container.style.top = `${top}px`;
  }
}




export { waitingDots, find_status };
