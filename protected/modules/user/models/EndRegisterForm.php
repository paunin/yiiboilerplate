<?php

class EndRegisterForm extends User
{

	public $hash;

    /**
     * @return array
     */
    public function rules()
	{
		return array(
			// username and password are required
			array('hash', 'required'),
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


	public function endregister()
	{
        /** @var User $user */
        $user = User::model()->findByAttributes(array('key'=>$this->hash));
        $user->key = Null;
        $user->is_active = true;
        return $user->save();
	}
}
