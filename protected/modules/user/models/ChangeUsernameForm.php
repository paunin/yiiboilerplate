<?php

class ChangeUsernameForm extends CFormModel
{
    public $username;
    public function init(){
        $this->attributes = User::current()->attributes;
    }

    /**
     * @return array
     */
    public function rules()
    {
        return array(
            array('username', 'required'),
            array('username', 'length', 'min'=>4, 'max'=>16),
            array('username', 'unique','className'=>'User','attributeName'=>'username'),
            array('username', 'match', 'pattern'=>'/^[a-zA-Z0-9_]{4,12}$/'),
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
                'username' => Yii::t('c_app','Username')
            )
        );
    }


    /**
     * @return bool
     */
    public function change()
    {
        $user = User::current();
        $user->username = $this->username;
        return $user->save();
    }
}
