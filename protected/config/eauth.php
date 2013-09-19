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
            'client_id' => '82343d009b4a48cab6a5832e17a7ffa3',
            'client_secret' => 'bc40e6991b4b4e368af6ce2c55d0e8a9',
            'title' => 'Yandex',
        ),

         'linkedin' => array(
             // register your app here: https://www.linkedin.com/secure/developer
             'class' => 'LinkedinOAuthService',
             'key' => '...',
             'secret' => '...',
         ),
         'github' => array(
             // register your app here: https://github.com/settings/applications
             'class' => 'GitHubOAuthService',
             'client_id' => 'b07f27a05c78edda4e74',
             'client_secret' => 'c4356c16360653c6837883db60cd0ca2de06709d',
         ),
//         'live' => array(
//             // register your app here: https://manage.dev.live.com/Applications/Index
//             'class' => 'LiveOAuthService',
//             'client_id' => '...',
//             'client_secret' => '...',
//         ),
        'vkontakte' => array(
            // register your app here: https://vk.com/editapp?act=create&site=1
            'class' => 'VKontakteOAuthService',
            'client_id' => '3886566',
            'client_secret' => '8EPeW9B3evETBPCEtsRH',
        ),
        'mailru' => array(
            // register your app here: http://api.mail.ru/sites/my/add
            'class' => 'MailruOAuthService',
            'client_id' => '710430',
            'client_secret' => '24e0be987b297f3fed60c59c4d48bcbe',
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