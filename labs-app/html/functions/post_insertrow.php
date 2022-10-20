<?php
require '/var/www/vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable('/var/www/');
$dotenv->load();

$dbhost = $_ENV['DBCLUSTER'];
$dbuser = $_ENV['DBUSER']; 
$dbpass = $_ENV['DBPASS']; 
$db = $_ENV['DBNAME'];
$table = $_ENV['DBTABLE'];

$mysqli = new mysqli($dbhost, $dbuser, $dbpass, $db);

if ($mysqli->connect_errno) {
    echo "Error: connecting DB: ".gethostname($dbhost);
    exit;
}

function generateRandomString($length = 5) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

$valueC1 = date("H:i:s");
$valueC2 = generateRandomString();
$insertQuery = "INSERT INTO ".$table." (Name, Lastname) VALUES ('".$valueC1."', '".$valueC2."');";

if ($result = $mysqli->query($insertQuery)) {
   echo $valueC1." Row inserted correctly (random string: " . $valueC2 . ")";
}
else
{
   echo "<tr>Error inserting data</tr>";
}
?>
