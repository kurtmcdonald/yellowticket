const edit_item = () => {
  const item_cards = document.querySelectorAll(".item-card");
  const edit_item_btn = document.querySelectorAll(".edit-item-btn")
  edit_item_btn.forEach((btn) => {
    btn.addEventListener('click', (event) => {
      const item_id = event.currentTarget.dataset.item_id;
      const item = document.getElementById(`item-${item_id}`);
      const item_info = document.querySelector(`#item-${item_id} .item-info`);
      const item_edit_form = document.querySelector(`#item-${item_id} .edit-item-form`);
      item_info.style.display = "none";
      item_edit_form.style.display = "block";
      event.currentTarget.parentNode.style.display = "none";
    })
  })
}

export { edit_item };
