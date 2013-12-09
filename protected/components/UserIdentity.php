<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
    private $_id;
    private $_username;
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
            $this->assignDbUser($user);
        }

        return ($this->errorCode == self::ERROR_NONE)?true:false;
    }

    /**
     * @param User $user
     * @return bool
     */
    protected  function assignDbUser(User $user){
        $this->_id = $user->id;
        $this->_username = $user->username;
        $user->last_login = date('Y-m-d H:i:s');
        return $user->save();
    }

    public function getId()
    {
        return $this->_id;
    }
    public function getName()
    {
        return $this->_username;
    }
}