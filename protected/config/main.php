<?php



// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.

$domain = 'pickupmyhome.com'; //@ChangeIt
$pgsqlDb = 'pumh';
$pgsqlUser = 'pumh';
$pgsqlPassword = '';


return array(
    'basePath' => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..',
    'name' => 'My Web Application', //@ChangeIt

    // preloading 'log' component
    'preload' => array('log'),

    // autoloading model and component classes
    'import' => array(

        'application.models.*',
        'application.models.raw.*',
        'application.models.forms.*',
        'application.components.*',
        'application.helpers.*',

        'ext.giix-components.*',
        'ext.image.Image',
        'ext.yii-mail.YiiMailMessage',
        'ext.ExtendedClientScript.jsmin.*',

        'application.modules.user.models.*'
    ),

    'modules' => array(
        'user',
        'admin'
    ),


    // application components
    'components' => array(
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
        ),

        'clientScript' => array(
            'class' => 'ext.ExtendedClientScript.ExtendedClientScript',
            'combineCss' => true,
            'compressCss' => true,
            'combineJs' => true,
            'compressJs' => true,
            'excludeJsFiles' => array('jquery-1.10.2.min.js','bootstrap.min.js'),
            'excludeCssFiles' => array('bootstrap-theme.min.css','bootstrap.min.css',),
        ),
        'request' => array(
            'enableCookieValidation' => true,
            'enableCsrfValidation' => true,
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
            'itemTable' => 'Auth_Item',
            'itemChildTable' => 'Auth_ItemChild',
            'assignmentTable' => 'Auth_Assignment',
            'defaultRoles' => array('guest'),
        ),

        'urlManager' => array(
            'urlFormat' => 'path',
            'showScriptName' => false,
            'rules' => array(

                'gii' => 'gii',
                'gii/<controller:\w+>' => 'gii/<controller>',
                'gii/<controller:\w+>/<action:\w+>' => 'gii/<controller>/<action>',

                'register' => 'user/register/register',
                'login' => 'user/login/login',

                '<controller:\w+>/<id:\d+>' => '<controller>/view',
                '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
                '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
                '<module:\w+>/<controller:\w+>/<action:\w+>' => '<module>/<controller>/<action>',
            ),
        ),
        'cache' => array(
            'class' => 'system.caching.CFileCache',
        ),
        'db' => array(
            'connectionString' => "pgsql:host=localhost;dbname=$pgsqlDb",
            'emulatePrepare' => true,
            'username' => $pgsqlUser,
            'password' => $pgsqlPassword,
            'charset' => 'utf8',
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
    // using Yii::app()->params['paramName']
    'params' => array(
        'site_url' => "http://$domain",
        'adminEmail' => "admin@$domain",
        'robotEmail' => "robot@$domain",
        'robotEmailName' => "robot@$domain",
        'slogan' => 'Slogan for Application', //@ChangeIt
        'captcha_private_key' => '6LdcgucSAAAAAPgfSO8ul_wvBVc9Uc0G-lhjHHV9',
        'captcha_public_key' => '6LdcgucSAAAAAASnIGDjFIFz64SocERXRaVnxa7O',
        'pgsqlDb'=>"$pgsqlDb",
        'pgsqlUser'=>"$pgsqlUser",
        'pgsqlPassword'=>"$pgsqlPassword",

    ),
);