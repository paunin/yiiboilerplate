<?php
use \Luracast\Restler\iAuthenticate;
use \Luracast\Restler\Resources;

class YiiRestlerAccessControl implements iAuthenticate
{
    public static $min_requires = 'user';

    public function __isAllowed()
    {

        $identity = new ApiIdentity(Yii::app()->getRequest()->getParam('api_key',null));
        if($identity->authenticate()){
            Yii::app()->user->login($identity);
        }else{
            Yii::app()->user->logout(false);
        }

        Resources::$accessControlFunction = 'YiiRestlerAccessControl::verifyAccess';

        return Yii::app()->user->checkAccess(self::$min_requires);
    }

    /**
     * @access private
     */
    public static function verifyAccess(array $m)
    {
        $requires =
            isset($m['class']['YiiRestlerAccessControl']['properties']['requires'])
                ? $m['class']['YiiRestlerAccessControl']['properties']['requires']
                : false;

        return $requires?Yii::app()->user->checkAccess($requires):true;
    }
}