<?php
Yii::import('ext.eauth.custom_services.CustomYandexService');
class MyOdnoklassnikiService extends OdnoklassnikiOAuthService {
    protected function fetchAttributes() {

        $info = $this->makeSignedRequest('http://api.odnoklassniki.ru/fb.do', array(
            'query' => array(
                'method' => 'users.getCurrentUser',
                'format' => 'JSON',
                'application_key' => $this->client_public,
                'client_id' => $this->client_id,
            ),
        ));

        $this->attributes['id'] = $info->uid;
        $this->attributes['name'] = $info->first_name . ' ' . $info->last_name;
        $this->attributes['url'] = 'http://www.odnoklassniki.ru/profile/' . $info->uid;
    }
} 