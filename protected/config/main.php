<?php
$main = array(

    'basePath' => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..',
    'name' => 'PlaceMeUp',
    'language'=>'ru',

    // preloading 'log' component
    'preload' => array('log'),

    // autoloading model and component classes
    'import' => array(

        'application.models.*',
        'application.models.raw.*',
        'application.models.forms.*',
        'application.components.*',
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
            'noCsrfValidationRoutes' => array('admin'),
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

                'gii' => 'gii',
                'gii/<controller:\w+>' => 'gii/<controller>',
                'gii/<controller:\w+>/<action:\w+>' => 'gii/<controller>/<action>',


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
    // using Yii::app()->params['site_url']
    'params' => array(
        'slogan' => 'You place in Web', 
        'captcha_public_key' => '6LeViucSAAAAAICVEHUbu7VNTzYjerwqO5U5e_kC',
        'captcha_private_key' => '6LeViucSAAAAAIhOg1ZNLVVQarj-9jea4jk-1uB-',
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