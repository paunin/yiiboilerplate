<?php
/**
 * Class RadiusPostAction
 * Set User RADIUS
 *
 * @property ApiUserController $controller
 */
class RadiusPostAction extends ApiAction
{
    public function run()
    {

        $user_settings = User::current()->getOrCreateUserSettings();
        $radius = Yii::app()->getRequest()->getParam('radius');

        $user_settings->setScenario('radius_post');

        $user_settings->setAttribute('radius',$radius);
        if($user_settings->validate()){
            $this->controller->out($user_settings->save());
        }else{
            $this->controller->outError($user_settings->getErrors(),ApiController::ERROR_VALIDATION,Yii::t('api','Validation error'));
        }
    }
}