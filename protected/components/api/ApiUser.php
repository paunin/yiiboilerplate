<?php

class ApiUser extends WebUser{
    public function  loginRequired(){
        YiiRestler::error(403,Yii::t('api','Token required/expired/incorrect'));
    }
}