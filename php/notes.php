<?php
require "common.php";

if (isset($_GET["notes"]) && isset($notes)) {
  $notes->set($_GET["notes"]);
  echo "0";
  loggy("debug", "Notes automatically saved", "notes", "save");
} else {
  loggy("error", "Missing notes field", "notes", "save");
  die("428");
}
