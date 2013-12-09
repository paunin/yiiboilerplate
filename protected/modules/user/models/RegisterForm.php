<?php

class RegisterForm extends User
{

	public $password2;
    public $validacion;

    /**
     * @return array
     */
    public function rules()
	{
		return array(
			// username and password are required
			array('username, password, password2, email', 'required'),
			array('username', 'length', 'min'=>4, 'max'=>16),
			array('password', 'length', 'min'=>4, 'max'=>32),
			array('username', 'unique','className'=>'User','attributeName'=>'username'),
			array('email', 'unique','className'=>'User','attributeName'=>'email'),
			array('username', 'match', 'pattern'=>'/^[a-zA-Z0-9_]{4,12}$/'),
			array('password2', 'compare', 'compareAttribute'=>'password'),
			array('email', 'email'),
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
            array(
                'password2' => Yii::t('app', 'Password again'),

            )
        );
	}


    /**
     * @return bool
     */
    public function register()
	{
        $this->password = md5($this->password);
        $this->is_active = false;
        $this->role = 'user';
        $this->key = 'register|'.md5(rand(1,99999).$this->username.date('Y-m-d H:i:s'));
        $this->sendMail($this);
        return $this->save(false);
	}

    /**
     * @param $user
     */
    public function sendMail($user){
        return myMail::send($user->email,Yii::t('c_app','Verify your email address'),'register',array('url'=>Cut::createUrl('user/register/endregister',array('key'=>$user->key),true)));
    }
}
