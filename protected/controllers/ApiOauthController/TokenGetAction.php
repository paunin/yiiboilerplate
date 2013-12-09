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
        $app = Application::model()->findByAttributes(array('slug'=>Yii::app()->params['app_own_slug']));
        $token = User::current()->getToken($app,true);
        $this->controller->out($token->toArray());
    }
}