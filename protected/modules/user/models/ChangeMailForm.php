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
            array()
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
            $user->email,
            Yii::t('registration', 'Change email address'),
            'ch_email',
            array(
                'url' => Cut::createUrl('user/profile/endchangemail', array('key' => $user->key), true),
                'old_email' => $user->email
            )
        );
    }
}
