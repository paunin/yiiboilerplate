<?php
class UserSocialIdentity extends UserIdentity
{
    private $eauth_identity;
    function __construct(EAuthUserIdentity $identity){
        $this->eauth_identity = $identity;
    }

    public function authenticate()
    {
        $user_social = UserSocial::getByService($this->eauth_identity->getId(),$this->eauth_identity->service->getServiceName());
        $this->assignDbUser($user_social->user);
        $this->errorCode = self::ERROR_NONE;
        return ($this->errorCode == self::ERROR_NONE)?true:false;;
    }

}