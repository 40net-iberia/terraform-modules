<?php
require '/var/www/vendor/autoload.php';
use Aws\Lambda\LambdaClient;

$dotenv = Dotenv\Dotenv::createImmutable('/var/www/');
$dotenv->load();

$key=$_ENV['ACCESSKEY'];
$secret=$_ENV['SECRETKEY'];

$client = LambdaClient::factory([
    'version' => 'latest',
    'region'  => 'us-east-1',
    'credentials' => [
        'key'    => $key,
        'secret' => $secret
     ]
]);

$result = $client->invoke([
    'FunctionName' => 'ab3-joviber-count-instances',
]);

echo $result->get('Payload');

?>
