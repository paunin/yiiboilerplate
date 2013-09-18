<?php
defined('PROJECT_CUSTOM_DEBUG') or define('PROJECT_CUSTOM_DEBUG',true);
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
        'pgsqlPassword'=>"$sqlPassword"
    )
);