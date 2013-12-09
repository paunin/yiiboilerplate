<?php
return array(
    'urlFormat' => 'path',
    'showScriptName' => false,
    'rules' => array(


        //<<< REST patterns

        array('apiV0/index', 'pattern' => 'api_v0', 'verb' => 'GET,POST'),

        array('apiOauth/tokenGet', 'pattern' => 'api_v0/oauth/token', 'verb' => 'GET'),


        //404
        array('apiV0/error404', 'pattern' => 'api<whartever:.*>'),
        //>>>REST patterns

        '<controller:\w+>/<id:\d+>' => '<controller>/view',
        '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
        '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
        '<module:\w+>/<controller:\w+>/<action:\w+>' => '<module>/<controller>/<action>',
    ),
);