<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
    private $_id;
    const ERROR_NOT_ACTIVE = 5;
    /**
     * @return bool
     */
    public function authenticate()
    {

        $criteria = new CDbCriteria;
        $criteria->select = '*';
        $criteria->condition = '(email=:email OR username=:username)';
        $criteria->params = array(':email' => $this->username, ':username' => $this->username);
        $criteria->limit = '1';
        /** @var User $user */
        $user = User::model()->find($criteria);

        if (!$user)
            $this->errorCode = self::ERROR_USERNAME_INVALID;
        else if (($user->password !== User::encPass($this->password)))
            $this->errorCode = self::ERROR_PASSWORD_INVALID;
        else if (!$user->is_active)
            $this->errorCode = self::ERROR_NOT_ACTIVE;
        else {
            $this->errorCode = self::ERROR_NONE;
            $this->_id = $user->id;
            $user->last_login = date('Y-m-d H:i:s');
            $user->save();
        }

        return $this->errorCode == self::ERROR_NONE;
    }

    public function getId()
    {
        return $this->_id;
    }
}