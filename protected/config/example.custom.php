<?php
defined('PROJECT_CUSTOM_DEBUG') or define('PROJECT_CUSTOM_DEBUG',true);
defined('YII_DEBUG') or define('YII_DEBUG',true);
defined('YII_TRACE_LEVEL') or define('YII_TRACE_LEVEL',3);
$domain = 'example.com'; //@ChangeIt
$base_url = ''; //@ChangeIt

return array(
    'components' => array(
        'db' => array(
            'connectionString' => "pgsql:host=localhost;dbname=pumh",
            //'emulatePrepare' => true,
            'username' => 'pumh',
            'password' => '',
            'charset' => 'utf8',
        ),
    ),
    'params' => array(
        'site_url' => "http://$domain",
        'adminEmail' => "admin@$domain",
        'robotEmail' => "robot@$domain",
        'robotEmailName' => "robot@$domain",
    )
);