<?php
return  array(
    'preload' => array(
        'debug',
    ),
    'modules' => array(
        // uncomment the following to enable the Gii tool
        'gii' => array(
            'class' => 'system.gii.GiiModule',
            'generatorPaths' => array(
                'ext.giix-core', // giix generators
            ),
            'password' => 'root',
            'ipFilters' => array("*"),
            'newFileMode' => 0666,
            'newDirMode' => 0777,
        ),
    ),
    'components' => array(
        'urlManager' => array(
            'urlFormat' => 'get',
            'showScriptName' => true
        ),
        'fixture' => array(
            'class' => 'system.test.CDbFixtureManager',
        ),
        'cache' => array(
            //'class' => 'system.caching.CFileCache',
            'class' => 'system.caching.CDummyCache',
        ),

        'db' =>array(
            'enableProfiling' => true,
            'enableParamLogging' => true
        ),
//        'debug' => array(
//            'class' => 'ext.yii2-debug.Yii2Debug',
//        ),


        'log' => array(
            'class' => 'CLogRouter',
            'routes' => array(
                array(
                    'class' => 'CFileLogRoute',
                    'levels' => 'error, warning, trace',
                ),
                array(
                    'class'=>'ext.yii-debug-toolbar.YiiDebugToolbarRoute',
                    'ipFilters'=>array('127.0.0.1','192.168.1.215'),
                ),
//                    array( // configuration for the toolbar
//                        'class' => 'XWebDebugRouter',
//                        'config' => 'alignRight, opaque, runInDebug, fixedPos,  yamlStyle, collapsed',
//                        'levels' => 'error, warning, trace, profile, info',
//                        'allowedIPs' => array('127.0.0.1', '::1', '192.168.1.54', '192\.168\.1[0-5]\.[0-9]{3}'),
//                    ),
//                    array(
//                        'class' => 'CWebLogRoute',
//                    ),
            ),
        ),
//                    'log' => array(
//                        'class' => 'CLogRouter',
//                        'routes' => array(
//                            array(
//                                'class' => 'CFileLogRoute',
//                                'levels' => 'error, warning',
//                            ),
//                        // uncomment the following to show log messages on web pages
//
//                          array(
//                          'class'=>'CWebLogRoute',
//                          ),
//
//                        ),
//                    ),

    ),
    'params' => array(

    )
);
