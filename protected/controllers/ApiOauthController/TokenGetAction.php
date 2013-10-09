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
        $result = null;
        if(!Yii::app()->user->isGuest){
            //User::
        }else{
            $result = 'gg';
        }
        $this->controller->out($result);
    }
}