<?php

return array(
    'urlFormat' => 'path',
    'showScriptName' => false,
    'class'     => 'application.components.UrlManager',
    'urlSuffix' => '/',

    'i18nRules' => array( // in these rules your can use lang
        //<<< REST patterns
        array('apiOauth/tokenGet', 'pattern' => 'api_v0/oauth/token', 'verb' => 'GET'),
        array('apiV0/index', 'pattern' => 'api_v0', 'verb' => 'GET,POST'),
        //404
        array('restApi/index', 'pattern' => 'restapi/*'),
        //>>>REST patterns
    ),
    'rules' => array(

        array('apiV0/error404', 'pattern' => 'api_v<whartever:.*>'),
        '<controller:\w+>/<id:\d+>' => '<controller>/view',
        '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
        '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
        '<module:\w+>/<controller:\w+>/<action:\w+>' => '<module>/<controller>/<action>',
    ),
);