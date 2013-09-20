<?php

class ChangePasswordForm extends User
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
            // username and password are required
            array('password, newpassword, newpassword2', 'required'),
            array('password', 'validatePassword'),
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
            array()
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
            $this->addError($attribute, 'Incorrect Password'/*.User::current()->password .'!='. md5($pass).'('.$pass.')'*/);
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
