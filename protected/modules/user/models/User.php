<?php

Yii::import('application.modules.user.models._base.BaseUser');

class User extends BaseUser
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    /**
     * @return User
     */
    public static function current(){
        return User::model()->findByPk(Yii::app()->user->getId());
    }
}