<?php
$main = array(

    'basePath' => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..',
    'name' => 'PlaceMeUp',
    'language'=>'en',

    // preloading 'log' component
    'preload' => array('log'),

    // autoloading model and component classes
    'import' => array(

        'application.validators.*',
        'application.models.*',
        'application.models.raw.*',
        'application.models.forms.*',
        'application.components.*',
        'application.components.api.*',
        'application.helpers.*',
        'application.modules.user.models.*',

        //Extensions
        'ext.giix-components.*',

        'ext.image.Image',

        'ext.yii-mail.YiiMailMessage',

        'ext.ExtendedClientScript.jsmin.*',

        'ext.eoauth.*',
        'ext.eoauth.lib.*',
        'ext.lightopenid.*',
        'ext.eauth.*',
        'ext.eauth.services.*',

    ),

    'modules' => array(
        'user',
        'admin'
    ),


    // application components
    'components' => array(
        'loid' => array(
            'class' => 'application.extensions.lightopenid.loid',
        ),
        'eauth' => require(dirname(__FILE__) . '/eauth.php'),
        'mail' => array(
            'class' => 'ext.yii-mail.YiiMail',
            'transportType' => 'php',
            'viewPath' => 'application.views.mail',
            'logging' => true,
            'dryRun' => false,
        ),
        'user' => array(
            // enable cookie-based authentication
            'allowAutoLogin' => true,
            'loginUrl'=>array('user/login/login'),
        ),
        'db' =>array(
            'pdoClass' => 'NestedPDO',
            'emulatePrepare' => false
        ),

/*        'clientScript' => array(
            'class' => 'ext.ExtendedClientScript.ExtendedClientScript',
            'combineCss' => true,
            'compressCss' => true,
            'combineJs' => true,
            'compressJs' => true,
            'excludeJsFiles' => array('jquery-1.10.2.min.js','bootstrap.min.js','jquery.cookie.js','auth.css'),
            'excludeCssFiles' => array('bootstrap-theme.min.css','bootstrap.min.css',),
        ),*/
        'request' => array(
            'enableCookieValidation' => true,
            'enableCsrfValidation' => true,
            'class' => 'HttpRequest',
            'noCsrfValidationRoutes' => array('admin','apiV0','apiOauth','apiUser'),
        ),
        'image' => array(
            'class' => 'ext.image.CImageComponent',
            // GD or ImageMagick
            'driver' => 'GD',
            // ImageMagick setup path
            //'params'=>array('directory'=>'/opt/local/bin'),
        ),

        'authManager' => array(
            //'class' => 'CPhpAuthManager',
            'class' => 'CDbAuthManager',
            'itemTable' => 'AuthItem',
            'itemChildTable' => 'AuthItemChild',
            'assignmentTable' => 'AuthAssignment',
            'defaultRoles' => array('guest'),
        ),

        'urlManager' => array(
            'urlFormat' => 'path',
            'showScriptName' => false,
            'rules' => array(


                //<<< REST patterns

                array('apiV0/index', 'pattern'=>'api_v0', 'verb'=>'GET,POST'),

                array('apiOauth/tokenGet', 'pattern'=>'api_v0/token', 'verb'=>'GET'),

                array('apiUser/get', 'pattern'=>'api_v0/user', 'verb'=>'GET'),
                array('apiUser/radiusGet', 'pattern'=>'api_v0/user/radius', 'verb'=>'GET'),
                array('apiUser/radiusPost', 'pattern'=>'api_v0/user/radius', 'verb'=>'POST'),
                array('apiUser/placeGet', 'pattern'=>'api_v0/user/place', 'verb'=>'GET'),
                array('apiUser/placePost', 'pattern'=>'api_v0/user/place', 'verb'=>'POST'),
                array('apiUser/placePut', 'pattern'=>'api_v0/user/place/<id:\d+>', 'verb'=>'PUT'),
                array('apiUser/placeDelete', 'pattern'=>'api_v0/user/place/<id:\d+>', 'verb'=>'DELETE'),

                array('apiV0/error404', 'pattern'=>'api<whartever:.*>'),

                //>>>REST patterns


                '<controller:\w+>/<id:\d+>' => '<controller>/view',
                '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
                '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
                '<module:\w+>/<controller:\w+>/<action:\w+>' => '<module>/<controller>/<action>',
            ),
        ),
        'cache' => array(
            'class' => 'system.caching.CFileCache',
        ),
        'errorHandler' => array(
            // use 'site/error' action to display errors
            'errorAction' => 'site/error',
        ),
        'log' => array(
            'class' => 'CLogRouter',
            'routes' => array(
                array(
                    'class' => 'CFileLogRoute',
                    'levels' => 'error, warning',
                ),
                // uncomment the following to show log messages on web pages
                /*
                array(
                    'class'=>'CWebLogRoute',
                ),
                */
            ),
        ),
    ),

    // application-level parameters that can be accessed
    // using Yii::app()->params['coordinate_min']
    'params' => array(
        'slogan' => 'You place in Web', 
        'captcha_public_key' => '6LeViucSAAAAAICVEHUbu7VNTzYjerwqO5U5e_kC',


        'radius_min' => 5,
        'radius_max' => 50,
        'radius_default' => 50,
        'places_count_max' => 100,
        'coordinate_max' => 900000000000000000,
        'coordinate_min' => -900000000000000000,

        'limit_feed_max'=>200,
        'limit_feed_default'=>20,
        'private' => array(
            'captcha_private_key' => '6LeViucSAAAAAIhOg1ZNLVVQarj-9jea4jk-1uB-',
        )
    ),
);

if(is_file(dirname(__FILE__) . '/solr.php')){
    $solr = require(dirname(__FILE__) . '/solr.php');
    $main = CMap::mergeArray(
        $main,
        $solr
    );
}

if(is_file(dirname(__FILE__) . '/custom.php')){
    $custom = require(dirname(__FILE__) . '/custom.php');
    $main = CMap::mergeArray(
        $main,
        $custom
    );

    if(defined('PROJECT_CUSTOM_DEBUG') && PROJECT_CUSTOM_DEBUG==true){
        unset($main['components']['clientScript']);
        $dev = require(dirname(__FILE__) . '/dev.php');
        $main = CMap::mergeArray(
            $main,
            $dev
        );
    }
}

return $main;