<?php
Yii::import('ext.eauth.custom_services.CustomYandexService');
class MyYandexService extends YandexOAuthService {
    protected function fetchAttributes() {
        $info = (array)$this->makeSignedRequest('https://login.yandex.ru/info');

        $this->attributes['id'] = $info['id'];
        $this->attributes['name'] = $info['real_name'];
        //$this->attributes['login'] = $info['display_name'];
        //$this->attributes['email'] = $info['emails'][0];
        $this->attributes['email'] = $info['default_email'];
        $this->attributes['gender'] = ($info['sex'] == 'male') ? 'M' : 'F';
    }
} 