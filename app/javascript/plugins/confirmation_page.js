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
  // const status = document.getElementById("order-status");
  // const container = document.getElementById("order-status");
  // const checkout = document.querySelector(".order-status-container #checkout");
  // const accepted = document.querySelector(".order-status-container #accepted");
  // const collected = document.querySelector(".order-status-container #collected");
  // const return_home = document.querySelector(".order-status-container #return");
  // const rejected = document.querySelector(".confirmation-rejected");

  // Items for the scrolling example:
  let scroll_container = document.getElementById('container');

  if (container) {
    window.setInterval( function() {
      fetch('/check-status', { headers: {accept: "application/json" } })
        .then(response => response.json())
        .then((data) => {
          if (data.status === "checkout") {
            // checkout.classList.add("pending");
            // accepted.classList.add("wait");
            // collected.classList.add("wait");
            test_scroll(0);
            scroll_container.children[0].classList.add('active');
          } else if (data.status === "accepted") {
            // checkout.classList.remove("pending");
            // checkout.classList.add("wait");
            // accepted.classList.remove("wait");
            // accepted.classList.add("pending");
            test_scroll(1);
            scroll_container.children[0].classList.remove('active');
            scroll_container.children[1].classList.add('active');
            // scroll_container.children[0].classList.remove("pending");
            // scroll_container.children[0].classList.add("wait");
            // scroll_container.children[1].classList.remove("wait");
            // scroll_container.children[1].classList.add("pending");
            // scroll_container.children[2].classList.add("wait");
          } else if (data.status === "collected") {
            // checkout.classList.add("wait")
            // accepted.classList.remove("pending");
            // accepted.classList.add("wait");
            // collected.classList.remove("wait");
            // collected.classList.add("pending");
            // return_home.style.display = "block";
            test_scroll(2);
            scroll_container.children[0].classList.remove('active');
            scroll_container.children[1].classList.remove('active');
            scroll_container.children[2].classList.add('active');
            // scroll_container.children[0].classList.add("wait");
            // scroll_container.children[1].classList.remove("pending");
            // scroll_container.children[1].classList.add("wait");
            // scroll_container.children[2].classList.remove("wait");
            // scroll_container.children[2].classList.add("pending");
          }
        });
    }, 2000);
  }
}

const test_scroll = (num) => {
  let display = document.querySelector('.test_scroll #display');
  let container = document.getElementById('container');
  let counter = 0;

  moveContainer(num);

  function moveContainer (num) {
    let choosenOption = container.children[num];
    setTop(-choosenOption.offsetTop + 100);
  }

  function setTop (top) {
    container.style.top = `${top}px`;
  }
}

const testResize = () => {
  const button = document.getElementById("button_scroll")
  const text = document.getElementById("resize_test")

  button.addEventListener('click', () => {
    text.classList.toggle("on");
    text.classList.toggle("off");
  })
}



export { waitingDots, find_status, testResize };
