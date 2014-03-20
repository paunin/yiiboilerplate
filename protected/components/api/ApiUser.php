<?php

class ApiUser extends WebUser{
    public function  loginRequired(){
        YiiRestler::error(403,Yii::t('api','Token required/expired/incorrect'));
    }

    public function init(){
        parent::init();

        $api_key = Yii::app()->getRequest()->getParam('api_key',null);
        if($api_key){
            $identity = new ApiIdentity($api_key);
            if($identity->authenticate()){
                $this->login($identity);
                return;
            }
        }

        if(!$this->getIsGuest()){
            $this->logout(false);
        }
    }


}