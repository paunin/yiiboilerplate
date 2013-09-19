<?php
return array(
    'class' => 'ext.eauth.EAuth',
    'popup' => true, // Use the popup window instead of redirecting.
    'cache' => false, // Cache component name or false to disable cache. Defaults to 'cache'.
    'cacheExpire' => 0, // Cache lifetime. Defaults to 0 - means unlimited.
    'services' => array( // You can change the providers and their classes.
        /*  'google' => array(
              'class' => 'GoogleOpenIDService',
          ),
          'yandex' => array(
              'class' => 'YandexOpenIDService',
          ),*/
          'twitter' => array(
              // register your app here: https://dev.twitter.com/apps/new
              'class' => 'application.components.eauth_custom.TwitterService',
              'key' => '6Ae8XbMXBb93KDmTG6kaQ',
              'secret' => 'hjq4QWIaZOCeuYFv3DjxWTDTr9dN0HId7iZETKkY',
          ),
        'google_oauth' => array(
            // register your app here: https://code.google.com/apis/console/
            'class' => 'GoogleOAuthService',
            'client_id' => '620690907725.apps.googleusercontent.com',
            'client_secret' => 'tULdcRqXhDw0N_zMcf5usE4M',
            'title' => 'Google',
        ),
        'facebook' => array(
            // register your app here: https://developers.facebook.com/apps/
            'class' => 'FacebookOAuthService',
            'client_id' => '606392652746197',
            'client_secret' => '8208ae757a903d25a1cb18cb15b5da7a',
        ),
        'yandex_oauth' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'YandexOAuthService',
            'client_id' => 'db2b0087b35b45b2b6dcd97cc1d755ea',
            'client_secret' => '7353f3d8b2da44ec9a892fa2424f3889',
            'title' => 'Yandex',
        ),
/*        'yandex_api' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'YandexOAuthService',
            'client_id' => '4c81260212e14272b2a294ede2cfe53c',
            'client_secret' => '1f1b50e247ca4a818285f6e8a99b25bc',
            'title' => 'Yandex',
        ),*/
         'linkedin' => array(
             // register your app here: https://www.linkedin.com/secure/developer
             'class' => 'LinkedinOAuthService',
             'key' => '...',
             'secret' => '...',
         ),
         'github' => array(
             // register your app here: https://github.com/settings/applications
             'class' => 'GitHubOAuthService',
             'client_id' => '...',
             'client_secret' => '...',
         ),
         'live' => array(
             // register your app here: https://manage.dev.live.com/Applications/Index
             'class' => 'LiveOAuthService',
             'client_id' => '...',
             'client_secret' => '...',
         ),
        'vkontakte' => array(
            // register your app here: https://vk.com/editapp?act=create&site=1
            'class' => 'VKontakteOAuthService',
            'client_id' => '3232874',
            'client_secret' => 'BkW7lRbPPpZBnzyNCw5z',
        ),
        'mailru' => array(
            // register your app here: http://api.mail.ru/sites/my/add
            'class' => 'MailruOAuthService',
            'client_id' => '690883',
            'client_secret' => '8727b4b3b2ab702c0e36183357919a76',
        ),

        'moikrug' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'MoikrugOAuthService',
            'client_id' => '4c81260212e14272b2a294ede2cfe53c',
            'client_secret' => '1f1b50e247ca4a818285f6e8a99b25bc',
        ),
        'odnoklassniki' => array(
            // register your app here: http://dev.odnoklassniki.ru/wiki/pages/viewpage.action?pageId=13992188
            // ... or here: http://www.odnoklassniki.ru/dk?st.cmd=appsInfoMyDevList&st._aid=Apps_Info_MyDev
            'class' => 'OdnoklassnikiOAuthService',
            'client_id' => '...',
            'client_public' => '...',
            'client_secret' => '...',
            'title' => 'Odnokl.',
        ),
    ),
);