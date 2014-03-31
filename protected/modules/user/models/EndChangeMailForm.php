<?php

class EndChangeMailForm extends CFormModel
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
            array('hash', 'length', 'min' => 4, 'max' => 256),
            array('hash', 'exist', 'className' => 'User', 'attributeName' => 'key'),
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

    public function endchange()
    {
        $user = User::current();
        if ($user->key == $this->hash) {
            $hash_parts = explode('|', $user->key);
            if (!empty($hash_parts[0]) && $hash_parts[0] == 'changemail' && !empty($hash_parts[1])) {
                $user->email = $hash_parts[1];
                $user->key = null;
                return $user->save();
            }
        } else {
            return false;
        }
    }


}
