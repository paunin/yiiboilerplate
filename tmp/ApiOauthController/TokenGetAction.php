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
        $app = Application::model()->findByAttributes(array('id'=>Yii::app()->params['app_own_id']));

        $token = User::current()->getToken($app,true);
        $this->controller->out($token->toArray());

    }
}