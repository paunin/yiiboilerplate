<?php
use \Luracast\Restler\iAuthenticate;
use \Luracast\Restler\Resources;

class YiiRestlerAccessControl implements iAuthenticate
{
    public static $min_requires = 'user';

    public function __isAllowed()
    {
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