<?php
require "common.php";

if (isset($_GET["action"]) && isset($tasks)) {
  switch ($_GET["action"]) {
    case "get":
      echo json_encode($tasks->get());
      loggy("debug", "Tasks retrieved", "tasks", "get");
      exit();
    case "finish":
      if (isset($_GET["id"])) {
        $tid = $_GET["id"];
        $tasks->complete($tid);
        loggy("debug", "Task with ID #" . $tid . " set as finished", "tasks", "finish");
        echo "0";
      } else {
        loggy("error", "Missing task's field", "tasks", "finish");
        die("428");
      }
      exit();
    case "add":
      if (isset($_GET["who"]) && isset($_GET["what"])) {
        $who = $_GET["who"];
        $what = $_GET["what"];
        $tasks->add($who, $what, $auth->getUserId());
        loggy("debug", "New task added", "tasks", "add");
        echo "0";
      } else {
        loggy("error", "Missing task's field", "tasks", "add");
        die("428");
      }
      exit();
    default:
      loggy("error", "No valid action field", "tasks", "fields");
      die("428");
  }
} else {
  loggy("error", "No action field", "tasks", "fields");
  die("428");
}
