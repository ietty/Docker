<?php
function adminer_object() {

  class AdminerSoftware extends Adminer {

    function name() {
      // custom name in title and heading
      return $_ENV['TITLE'];
    }

    function credentials() {
      // server, username and password for connecting to database
      return array($_ENV['DB_HOST'], $_ENV['DB_USER'], $_ENV['DB_PASS']);
    }

    function database() {
      // database name, will be escaped by Adminer
      return $_ENV['DB_NAME'];
    }

#    function login($login, $password) {
#      // validate user submitted credentials
#      return ($login == 'admin' && $password == '');
#    }

  }

  return new AdminerSoftware;
}

include "./adminer.php";
