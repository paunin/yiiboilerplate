<?php

class ApiUser extends WebUser{
    public function  loginRequired(){
        throw new CHttpException(403,Yii::t('api','Token required/expired/incorrect'));
    }
}