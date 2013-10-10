<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class ApiIdentity extends UserIdentity
{
    private $token;

    const ERROR_TOKEN_INCORRECT = 6;
    const ERROR_TOKEN_EXPIRED = 7;

    /**
     * @param string $token
     */
    public function __construct($token){
        $this->token = $token;
    }
    /**
     * @return bool
     */
    public function authenticate()
    {
        if(!$this->token){
            $this->errorCode = self::ERROR_TOKEN_INCORRECT;
            return false;
        }

        $now = date('Y-m-d H:i:s');
        /** @var Token $token */
        $token = Token::model()->find(
            "token = :token",
            array(':token' => $this->token)
        );

        if (!$token)
            $this->errorCode = self::ERROR_TOKEN_INCORRECT;
        else if($token->expire_at <= $now)
            $this->errorCode = self::ERROR_TOKEN_EXPIRED;
        else if (!$token->user->is_active)
            $this->errorCode = self::ERROR_NOT_ACTIVE;
        else {
            $this->errorCode = self::ERROR_NONE;
            $this->assignDbUser($token->user);
        }

        return ($this->errorCode == self::ERROR_NONE)?true:false;
    }

}