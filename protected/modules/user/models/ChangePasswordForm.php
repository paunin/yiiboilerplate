<?php

class ChangePasswordForm extends CFormModel
{
    public $password;
    public $newpassword;
    public $newpassword2;


    /**
     * @return array
     */
    public function rules()
    {
        return array(
            array('password', 'required', 'on' => 'withpassword'),
            array('password', 'validatePassword', 'on' => 'withpassword'),

            array('newpassword, newpassword2', 'required'),
            array('newpassword', 'length', 'min' => 4, 'max' => 32),
            array('newpassword2', 'compare', 'compareAttribute' => 'newpassword'),
        );
    }

    /**
     * Declares attribute labels.
     */
    public function attributeLabels()
    {
        return array_merge(
            parent::attributeLabels(),
            array(
                'password' => Yii::t('c_app', 'Current password'),
                'newpassword' => Yii::t('c_app', 'New password'),
                'newpassword2' => Yii::t('c_app', 'New password again'),
            )
        );
    }

    /**
     * @param $attribute
     * @param $params
     * @return bool|void
     */
    public function validatePassword($attribute, $params)
    {
        $pass = $this->$attribute;
        if(User::current()->password != User::encPass($pass))
            $this->addError($attribute, Yii::t('c_app', 'Incorrect Password') /*.User::current()->password .'!='. md5($pass).'('.$pass.')'*/);
    }

    /**
     * @return bool
     */
    public function change()
    {
        /** @var User $user */
        $user = User::current();
        $user->password = User::encPass($this->newpassword);
        return $user->save();
    }
}
