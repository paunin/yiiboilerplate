<?php

class ChangeMailForm extends User
{
    public $newemail;

    /**
     * @return array
     */
    public function rules()
    {
        return array(
            // username and password are required
            array('newemail', 'required'),
            array('newemail', 'unique', 'className' => 'User', 'attributeName' => 'email'),
            array('newemail', 'email'),
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
                'newemail' => Yii::t('c_app', 'New email')
            )
        );
    }

    /**
     * @return bool
     */
    public function changemail()
    {
        /** @var User $user */
        $user = User::current();
        $user->key = 'changemail|' . $this->newemail . '|' . md5(rand(1, 99999) . $this->username . date('Y-m-d H:i:s'));
        $user->save();

        return myMail::send(
            $this->newemail,
            Yii::t('c_app', 'Change email address'),
            'ch_email',
            array(
                'url' => Yii::app()->createAbsoluteUrl('user/profile/endchangemail', array('key' => $user->key)),
                'old_email' => $user->email
            )
        );
    }
}
