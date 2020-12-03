const hideActiveOrder = () => {
  const activeLink = document.querySelector(".active_order_link");
  const scroll_container = document.getElementById('container');

  if (scroll_container) {
    activeLink.style.display = "none";
  }
}

const find_status = () => {
  // Items for the scrolling example:
  const scroll_container = document.getElementById('container');
  const map = document.getElementById("map");
  if (scroll_container) {
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
            document.getElementById("your-item-collected").style.display = "inline-block";
          } else if (data.status === "collected") {
            confirmation_scroll(2);
            scroll_container.children[0].classList.remove('active');
            scroll_container.children[1].classList.remove('active');
            scroll_container.children[2].classList.add('active');
            scroll_container.children[4].style.display = "inline-block";
            document.getElementById("your-item-collected").style.display = "none";
          } else if (data.status === "rejected") {
            scroll_container.children[0].style.display = "none";
            scroll_container.children[1].style.display = "none";
            scroll_container.children[2].style.display = "none";
            scroll_container.children[3].style.display = "block";
            scroll_container.children[4].style.display = "inline-block";
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




export { hideActiveOrder, find_status };
