<?php

Yii::import('application.modules.user.models._base.BaseUser');

class User extends BaseUser
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

    /**
     * Returns User model by its email
     *
     * @param string $email
     * @access public
     * @return User
     */
    public function findByEmail($email)
    {
        return self::model()->findByAttributes(array('email' => $email));
    }

    /**
     * Return current authorized user
     *
     * @return User|null
     */
    public static function current(){
        if(Yii::app()->user->isGuest)
            return null;
        return User::model()->findByPk(Yii::app()->user->getId());
    }

    /**
     * @param $password
     * @param string $method
     * @return string
     */
    public static function encPass($password,$method='md5'){
        return md5($password);
    }

    public function __toString(){
        return $this->username.'('.$this->email.')';
    }
}