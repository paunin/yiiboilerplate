<?php

class EndRecoveryPassForm extends CFormModel
{
    public $hash;
    public $password;
    public $password2;

    /**
     * @return array
     */
    public function rules()
    {
        return array(
            // username and password are required
            array('hash, password, password2', 'required'),
            array('password', 'length', 'min'=>4, 'max'=>32),
            array('password2', 'compare', 'compareAttribute'=>'password'),
            array('hash', 'length', 'min'=>4, 'max'=>256),
            array('hash', 'exist', 'className'=>'User', 'attributeName'=>'key'),
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

    public function endrecovery(){
        /** @var User $user */
        $user = User::model()->findByAttributes(array('key'=>$this->hash));
        $user->key = Null;
        $user->is_active = true;
        $user->password = md5($this->password);
        return $user->save();
    }


}
