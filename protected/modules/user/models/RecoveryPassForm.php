<?php

class RecoveryPassForm extends User
{
    public $validacion;

    /**
     * @return array
     */
    public function rules()
	{
		return array(
			// username and password are required
			array('email', 'required'),
            array('email', 'exist', 'className'=>'User', 'attributeName'=>'email'),
            array('validacion', 'application.extensions.recaptcha.EReCaptchaValidator', 'privateKey'=>Yii::app()->params['captcha_private_key'], 'on' => 'registerwcaptcha'),

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
    public function recovery()
	{
        /** @var User $user */
        $user = User::model()->findByAttributes(array('email'=>$this->email));
        if(!$user->key){
            $user->key = 'recoverypassword|'.md5(rand(1,99999).$this->username.date('Y-m-d H:i:s'));
            $user->save();
        }
        return myMail::send($user->email,Yii::t('c_app','Recovery password'),'recovery_pass',array('url'=>Yii::app()->createAbsoluteUrl('user/register/endrecoverypass',array('key'=>$user->key))));
	}
}
