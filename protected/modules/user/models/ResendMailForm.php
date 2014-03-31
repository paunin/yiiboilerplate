<?php

class ResendMailForm extends RegisterForm
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
    public function resend()
	{
        /** @var User $user */
        $user = User::model()->findByAttributes(array('email'=>$this->email));
        return $this->sendMail($user);
	}
}
