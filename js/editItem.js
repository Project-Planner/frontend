function showEditItemView(id, calendarID) {
  console.log("test");
  document.getElementById("EditItemView").style.display = "block";
  var iframe = document.getElementById("editItem");
  iframe.src = iframe.src;
  document.getElementById("editItem").src =
    "/me/c/" + calendarID + "?mode=edit;id=" + id;
}
