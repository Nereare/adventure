<?php
require "common.php";

if (isset($_GET["action"]) && isset($chat)) {
  switch ($_GET["action"]) {
    case "":
      # code...
      break;
    default:
      loggy("debug", "Action not valid", "chat", "start");
      die("428");
  }
} else {
  loggy("error", "Missing action field", "chat", "start");
  die("428");
}
