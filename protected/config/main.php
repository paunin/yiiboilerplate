<?php
date_default_timezone_set("Europe/London");
$main = array(

    'basePath' => dirname(__FILE__) . DIRECTORY_SEPARATOR . '..',
    'name' => 'PlaceMeUp',
    'language' => 'en',

    // preloading 'log' component
    'preload' => array('log'),

    // autoloading model and component classes
    'import' => array(

        'application.validators.*',
        'application.models.*',
        'application.models.raw.*',
        'application.models.virtual.*',
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
            'class' => 'application.components.WebUser',
            'allowAutoLogin' => true,
            'loginUrl' => array('user/login/login'),
            'stateKeyPrefix' => 'frontend_',
        ),
        'apiUser' => array(
            'class' => 'application.components.api.ApiUser',
            'allowAutoLogin' => false,
            'stateKeyPrefix' => 'api_',
            'loginUrl' => array('user/login/login'),
            'authTimeout' => 60
        ),
        'db' => array(
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
            'noCsrfValidationRoutes' => array('admin', 'apiV0', 'apiOauth', 'apiUser', 'apiTag', 'apiProfile', 'apiPost'),
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

        'urlManager' => require(dirname(__FILE__) . '/urlManager.php'),
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
    // using Yii::app()->params['map_scale_max']
    'params' => null //,
);

$public_params = array(
    'slogan' => 'Your place in Web',
    'captcha_public_key' => '6LeViucSAAAAAICVEHUbu7VNTzYjerwqO5U5e_kC',


    'radius_min' => 1,
    'radius_max' => 100,
    'radius_default' => 50,
    'places_count_max' => 100,
    'coordinate_max' => 900000000000000000,
    'coordinate_min' => -900000000000000000,

    'post_edit_time_limit' => 300,

    'map_scale_min' => 1,
    'map_scale_max' => 1000,
    'map_resolution_max' => 100,

    'tag_length_min' => 2,
    'tag_length_max' => 25,
    'tag_pattern' => '[a-zA-Z_а-яА-Я0-9]{2,25}?',

    'tag_one_user_radius_allow' => 20,
    'tag_one_name_radius_weight' => 30,
    'tag_get_limit_default' => 10,
    'tag_get_limit_max' => 30,
    'tag_get_limit_min' => 1,
    'tag_per_message_limit' => 15,

    'limit_feed_max' => 200,
    'limit_feed_default' => 20,

    'post_allow_edit_time' => 300,
    'post_limit_max' => 50,

    'message_limit_max' =>50,

    'user_username_pattern' => '[a-zA-Z0-9_]{4,12}?',

    'user_username_per_message_limit' => 15,

    'user_avatars_sizes' => array(
        's' => array('w' => 50, 'h' => 50),
        'm' => array('w' => 150, 'h' => 150),
        'l' => array('w' => 300, 'h' => 300),
        //'xl'=>array('w'=>400,'h'=>400),
        //'xxl'=>array('w'=>550,'h'=>550),
    )
);

$main['params'] = array_merge(
    $public_params,

    array(
        'public' => $public_params,
        'path_avatars' => "external/user/avatars",
        'path_img_cache' => 'assets/img_cache',
        'rand_key' => 'S4DF5^$#fv^*32F{}sAdtKdtyHh%#6($35H3as',
        'app_own_slug' => 'placemeup',
        'app_token_ttl' => '6 hours',
        'captcha_private_key' => '6LeViucSAAAAAIhOg1ZNLVVQarj-9jea4jk-1uB-',
    )
);

if(is_file(dirname(__FILE__) . '/solr.php')) {
    $solr = require(dirname(__FILE__) . '/solr.php');
    $main = CMap::mergeArray(
        $main,
        $solr
    );
}

if(is_file(dirname(__FILE__) . '/custom.php')) {
    $custom = require(dirname(__FILE__) . '/custom.php');
    $main = CMap::mergeArray(
        $main,
        $custom
    );

    if(defined('PROJECT_CUSTOM_DEBUG') && PROJECT_CUSTOM_DEBUG == true) {
        unset($main['components']['clientScript']);
        $dev = require(dirname(__FILE__) . '/dev.php');
        $main = CMap::mergeArray(
            $main,
            $dev
        );
    }
}

return $main;