<?php
return  array(
    'class' => 'ext.eauth.EAuth',
    'popup' => true, // Use the popup window instead of redirecting.
    'cache' => false, // Cache component name or false to disable cache. Defaults to 'cache'.
    'cacheExpire' => 0, // Cache lifetime. Defaults to 0 - means unlimited.
    'services' => array( // You can change the providers and their classes.
        'google' => array(
            'class' => 'GoogleOpenIDService',
            //'realm' => '*.example.org',
        ),
        'yandex' => array(
            'class' => 'YandexOpenIDService',
            //'realm' => '*.example.org',
        ),
        'twitter' => array(
            // register your app here: https://dev.twitter.com/apps/new
            'class' => 'TwitterOAuthService',
            'key' => '...',
            'secret' => '...',
        ),
        'google_oauth' => array(
            // register your app here: https://code.google.com/apis/console/
            'class' => 'GoogleOAuthService',
            'client_id' => '...',
            'client_secret' => '...',
            'title' => 'Google (OAuth)',
        ),
        'yandex_oauth' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'YandexOAuthService',
            'client_id' => '...',
            'client_secret' => '...',
            'title' => 'Yandex (OAuth)',
        ),
        'facebook' => array(
            // register your app here: https://developers.facebook.com/apps/
            'class' => 'FacebookOAuthService',
            'client_id' => '...',
            'client_secret' => '...',
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
            'client_id' => '...',
            'client_secret' => '...',
        ),
        'mailru' => array(
            // register your app here: http://api.mail.ru/sites/my/add
            'class' => 'MailruOAuthService',
            'client_id' => '...',
            'client_secret' => '...',
        ),
        'moikrug' => array(
            // register your app here: https://oauth.yandex.ru/client/my
            'class' => 'MoikrugOAuthService',
            'client_id' => '...',
            'client_secret' => '...',
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
    )
);