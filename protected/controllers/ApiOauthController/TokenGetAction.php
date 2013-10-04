<?php
/**
 * Class IndexAction
 *
 * @property ApiOauthController $controller
 */
class TokenGetAction extends ApiAction
{
    public function run()
    {
        $this->controller->out(Yii::app()->user->isGuest?'GUEST_TOKEN':md5(Yii::app()->user->getId()).'_TOKEN');
    }
}