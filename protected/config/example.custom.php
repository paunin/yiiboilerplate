<?php
//defined('PROJECT_CUSTOM_DEBUG') or define('PROJECT_CUSTOM_DEBUG',true);
//defined('YII_DEBUG') or define('YII_DEBUG',true);
defined('YII_TRACE_LEVEL') or define('YII_TRACE_LEVEL',3);
$domain = 'example.com'; //@ChangeIt

$sqlDb = 'pumh';
$sqlUser = 'pumh';
$sqlPassword = '';
return array(
    'components' => array(
        'db' => array(
            'connectionString' => "pgsql:host=localhost;dbname=$sqlDb",
            'emulatePrepare' => true,
            'username' => $sqlUser,
            'password' => $sqlPassword,
            'charset' => 'utf8',
        ),
    ),
    'params' => array(
        'pgsqlDb'=>"$sqlDb",
        'pgsqlUser'=>"$sqlUser",
        'pgsqlPassword'=>"$sqlPassword",

        'site_url' => "http://$domain",
        'adminEmail' => "admin@$domain",
        'robotEmail' => "robot@$domain",
        'robotEmailName' => "robot@$domain",
    )
);