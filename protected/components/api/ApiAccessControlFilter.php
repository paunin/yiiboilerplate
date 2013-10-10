<?php
class ApiAccessControlFilter extends CAccessControlFilter{

    protected function preFilter($filterChain)
    {
        if(Yii::app()->getRequest()->getParam('token',null)){
            $identity = new ApiIdentity(Yii::app()->getRequest()->getParam('token',null));
            if($identity->authenticate()){
                Yii::app()->user->login($identity);
            }else{
                Yii::app()->user->logout();
            }
        }
        return parent::preFilter($filterChain);
    }
}