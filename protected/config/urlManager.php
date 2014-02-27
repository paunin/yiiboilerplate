<?php

return array(
    'urlFormat' => 'path',
    'showScriptName' => false,
    'class'     => 'application.components.UrlManager',
    'urlSuffix' => '/',

    'i18nRules' => array( // in these rules your can use lang
        'home' => 'site/index'
    ),
    'rules' => array(

        '<controller:\w+>/<id:\d+>' => '<controller>/view',
        '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
        '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
        '<module:\w+>/<controller:\w+>/<action:\w+>' => '<module>/<controller>/<action>',
    ),
);