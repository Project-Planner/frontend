var date = new Date();
var dateJs = new Date();
var mode = "calendar";
let period = "week";
var add = 7;
var showCalendars = false;

window.onload = function () {
  document.getElementById("calendarFrame").src =
    "/me/c?mode=" +
    mode +
    ";period=" +
    period +
    ";date=" +
    date.getDate() +
    "." +
    (date.getMonth() + 1) +
    "." +
    date.getFullYear();
  changeDate(0);
  setVisibilityTrue();
};

function changeDate(val) {
  var current = new Date();
  var url_string = document.getElementById("calendarFrame").src;
  //Javascript doesn't understand ; as url param splitter
  url_string = url_string.replaceAll(";", "&");
  var url = new URL(url_string);

  if (val != 0) {
    period = url.searchParams.get("period");
    mode = url.searchParams.get("mode");
  }

  switch (period) {
    case "day":
      console.log("test");
      dateJs.setDate(dateJs.getDate() + val);

      y = dateJs.getFullYear();
      m = dateJs.getMonth() + 1;
      d = dateJs.getDate();

      document.getElementById("date").innerHTML = d + "." + m + "." + y;
      break;

    case "week":
      dateJs.setDate(dateJs.getDate() + val);

      var day = dateJs.getDay();
      var diff = dateJs.getDate() - day + (day == 0 ? -6 : 1);
      var limit = new Date(dateJs);

      dateJs.setDate(diff);
      limit.setDate(diff + 6);

      y = dateJs.getFullYear();
      m = dateJs.getMonth() + 1;
      d = dateJs.getDate();

      document.getElementById("date").innerHTML =
        d +
        "." +
        m +
        "." +
        y +
        "\n - " +
        limit.getDate() +
        "." +
        (limit.getMonth() + 1) +
        "." +
        limit.getFullYear();
      break;

    case "month":
      if (dateJs.getMonth() == 11 && val == 1) {
        var current = new Date(dateJs.getFullYear() + 1, 0, 1);
      } else if (dateJs.getMonth() == 0 && val == -1)
        var current = new Date(dateJs.getFullYear() - 1, 11, 1);
      else {
        var current = new Date(
          dateJs.getFullYear(),
          dateJs.getMonth() + val,
          1
        );
      }

      dateJs = current;

      switch (dateJs.getMonth()) {
        case 0:
          limitString = "\n Januar";
          break;
        case 1:
          limitString = "\n Februar";
          break;
        case 2:
          limitString = "\n Maerz";
          break;
        case 3:
          limitString = "\n April";
          break;
        case 4:
          limitString = "\n Mai";
          break;
        case 5:
          limitString = "\n Juni";
          break;
        case 6:
          limitString = "\n Juli";
          break;
        case 7:
          limitString = "\n August";
          break;
        case 8:
          limitString = "\n September";
          break;
        case 9:
          limitString = "\n Oktober";
          break;
        case 10:
          limitString = "\n November";
          break;
        case 11:
          limitString = "\n Dezember";
          break;
      }
      document.getElementById("date").innerHTML = limitString;
      break;
  }

  y = dateJs.getFullYear();
  m = dateJs.getMonth() + 1;
  d = dateJs.getDate();
  ///me/c
  document.getElementById("calendarFrame").src =
    "/me/c?mode=" +
    mode +
    ";period=" +
    period +
    ";date=" +
    d +
    "." +
    m +
    "." +
    y;
}

function changeCalendarMode(val) {
  period = val;
  switch (val) {
    case "week":
      add = 7;
      break;
    default:
      add = 1;
      break;
  }
  changeDate(0);
}

function changeDisplayMode() {
  var url_string = document.getElementById("calendarFrame").src;
  //Javascript doesn't understand ; as url param splitter
  url_string = url_string.replaceAll(";", "&");
  var url = new URL(url_string);
  period = url.searchParams.get("period");
  date = url.searchParams.get("date");

  if (document.getElementById("displayModeCheckbox").checked) {
    document.getElementById("calendarFrame").src =
      "/me/c?mode=project;period=" + period + ";date=" + date;
  } else {
    document.getElementById("calendarFrame").src =
      "/me/c?mode=calendar;period=" + period + ";date=" + date;
  }
}

function setVisibilityTrue() {
  if (showCalendars) {
    document.getElementById("dropdown-content").style.display = "block";
    showCalendars = false;
  } else {
    document.getElementById("dropdown-content").style.display = "none";
    showCalendars = true;
  }
}

function test(){
}
