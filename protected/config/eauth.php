<?php
return array(
    'class' => 'ext.eauth.EAuth',
    'popup' => true, // Use the popup window instead of redirecting.
    'cache' => false, // Cache component name or false to disable cache. Defaults to 'cache'.
    'cacheExpire' => 0, // Cache lifetime. Defaults to 0 - means unlimited.
    'services' => array( // You can change the providers and their classes.

          /*'yandex' => array(
              'class' => 'YandexOpenIDService',
          ),*/
          'twitter' => array(
              // register your app here: https://dev.twitter.com/apps/new
              'class' => 'application.components.eauth_custom.TwitterService',
              'key' => 'ajufPaApWJRzImDaIicVg',
              'secret' => 'k0xL84sdzfAYiIItKLQk7GEB7VFqTiCYP1rIxObA',
          ),
//        'google' => array(
//            'class' => 'GoogleOpenIDService',
//            'title' => 'OpenID',
//        ),
        'google_oauth' => array(
            // register your app here: https://code.google.com/apis/console/
            'class' => 'GoogleOAuthService',
            'client_id' => '566633457378.apps.googleusercontent.com',
            'client_secret' => 'Q_F_clAfBYKBghvRUlJvLdGK',
            'title' => 'Google',
        ),
        'facebook' => array(
            // register your app here: https://developers.facebook.com/apps/
            'class' => 'FacebookOAuthService',
            'client_id' => '256908007791921',
            'client_secret' => '58b6a16741f7e5f5080950330faa9ae7',
        ),
        'linkedin' => array(
            // register your app here: https://www.linkedin.com/secure/developer
            'class' => 'LinkedinOAuthService',
            'key' => '75t22hpvnf4wq7',
            'secret' => '5RgD2LFB2TFZNMrl',
        ),
        'github' => array(
            // register your app here: https://github.com/settings/applications
            'class' => 'GitHubOAuthService',
            'client_id' => '809be3829a20cc140ca3',
            'client_secret' => 'c3be21a41ea68e74a6e83dd69c30fe21034135f3',
        ),
        'vkontakte' => array(
            // register your app here: https://vk.com/editapp?act=create&site=1
            'class' => 'VKontakteOAuthService',
            'client_id' => '3993150',
            'client_secret' => 'XLyA4x3FAjSyzqomCUbj',
        ),
        'yandex_oauth' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'YandexOAuthService',
            'client_id' => '5c48f9984ea040929f07ee36538ddf9b',
            'client_secret' => '1632b16e68d64255a3ab67219a6f1d20',
            'title' => 'Yandex',
        ),
        'moikrug' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'MoikrugOAuthService',
            'client_id' => '6f52596769e8420aadd0b7fefaa0968c',
            'client_secret' => 'e34ab10802fc4b1e8b0fb2b48bec2045',
            'title' => 'Moikrug.ru',
        ),



//         'live' => array(
//             // register your app here: https://manage.dev.live.com/Applications/Index
//             'class' => 'LiveOAuthService',
//             'client_id' => '...',
//             'client_secret' => '...',
//         ),

        'mailru' => array(
            // register your app here: http://api.mail.ru/sites/my/add
            'class' => 'MailruOAuthService',
            'client_id' => '713009',
            'client_secret' => '7b638c8c34ca431ebb6a6cad04ffe119',
        ),


        'odnoklassniki' => array(
            // register your app here: http://dev.odnoklassniki.ru/wiki/pages/viewpage.action?pageId=13992188
            // ... or here: http://www.odnoklassniki.ru/dk?st.cmd=appsInfoMyDevList&st._aid=Apps_Info_MyDev
            'class' => 'OdnoklassnikiOAuthService',
            'client_id' => '201041408',
            'client_public' => 'CBAHKMPMABABABABA',
            'client_secret' => '76FF105AD6EB10AF49C535AF',
            'title' => 'Odnokl.',
        ),
    ),
);