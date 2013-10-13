<?php
return array(
    'urlFormat' => 'path',
    'showScriptName' => false,
    'rules' => array(


        //<<< REST patterns

        array('apiV0/index', 'pattern' => 'api_v0', 'verb' => 'GET,POST'),

        array('apiOauth/tokenGet', 'pattern' => 'api_v0/oauth/token', 'verb' => 'GET'),


        array('apiUser/get', 'pattern' => 'api_v0/user', 'verb' => 'GET'),
        array('apiUser/radiusGet', 'pattern' => 'api_v0/user/radius', 'verb' => 'GET'),
        array('apiUser/radiusPost', 'pattern' => 'api_v0/user/radius', 'verb' => 'POST'),
        array('apiUser/placeGet', 'pattern' => 'api_v0/user/place', 'verb' => 'GET'),
        array('apiUser/placePost', 'pattern' => 'api_v0/user/place', 'verb' => 'POST'),
        array('apiUser/placePut', 'pattern' => 'api_v0/user/place/<id:\d+>', 'verb' => 'PUT'),
        array('apiUser/placeDelete', 'pattern' => 'api_v0/user/place/<id:\d+>', 'verb' => 'DELETE'),

        array('apiLocation/mapGet', 'pattern' => 'api_v0/location/map', 'verb' => 'GET'),

        array('apiProfile/get', 'pattern' => 'api_v0/profile', 'verb' => 'GET'),
        array('apiProfile/profileGet', 'pattern' => 'api_v0/profile/<id:\d+>', 'verb' => 'GET'),

        array('apiProfile/favoriteGet', 'pattern' => 'api_v0/profile/favorite', 'verb' => 'GET'),
        array('apiProfile/favoritePost', 'pattern' => 'api_v0/profile/favorite/<id:\d+>', 'verb' => 'POST'),
        array('apiProfile/favoriteDelete', 'pattern' => 'api_v0/profile/favorite/<id:\d+>', 'verb' => 'DELETE'),

        array('apiTag/get', 'pattern' => 'api_v0/tag', 'verb' => 'GET'),
        array('apiTag/post', 'pattern' => 'api_v0/tag', 'verb' => 'POST'),

        array('apiTag/myGet', 'pattern' => 'api_v0/tag/my', 'verb' => 'GET'),
        array('apiTag/myDelete', 'pattern' => 'api_v0/tag/my/<id:\d+>', 'verb' => 'DELETE'),

        array('apiPost/post', 'pattern' => 'api_v0/post', 'verb' => 'POST'),

        array('apiPost/postPut', 'pattern' => 'api_v0/post/<id:\d+>', 'verb' => 'PUT'),
        array('apiPost/postDelete', 'pattern' => 'api_v0/post/<id:\d+>', 'verb' => 'DELETE'),




        //Tests
        array('apiLocation/mapGetTest', 'pattern' => 'api_v0/location/map/test'),
        array('apiProfile/getTest', 'pattern' => 'api_v0/profile/test'),

        //404
        array('apiV0/error404', 'pattern' => 'api<whartever:.*>'),
        //>>>REST patterns

        '<controller:\w+>/<id:\d+>' => '<controller>/view',
        '<controller:\w+>/<action:\w+>/<id:\d+>' => '<controller>/<action>',
        '<controller:\w+>/<action:\w+>' => '<controller>/<action>',
        '<module:\w+>/<controller:\w+>/<action:\w+>' => '<module>/<controller>/<action>',
    ),
);