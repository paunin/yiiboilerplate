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
        $user_settings->setScenario('radius_post');
        $user_settings->setAttributes(Yii::app()->getRequest()->getAllParams());

        if($user_settings->validate()){
            $this->controller->out($user_settings->save());
        }else{
            $this->controller->outError($user_settings->getErrors(),ApiController::ERROR_VALIDATION,Yii::t('api','Validation error'));
        }
    }
}