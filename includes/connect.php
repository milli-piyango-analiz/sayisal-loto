<?php

try {
    $dbh = new PDO('mysql:host=localhost;dbname=milli_piyango', 'root', '', [
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'UTF8';",
    ]);
} catch (PDOException $e) {
    print "Pdo Error: " . $e->getMessage();
    die();
}