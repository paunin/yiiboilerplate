<?php
/**
 * Class RadiusGetAction
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
        if(empty($radius)){
            $this->controller->forward('apiV0/error400');
        }

        $user_settings->radius = $radius;
        if($user_settings->validate()){
            $this->controller->out($user_settings->save());
        }else{
            $this->controller->outError($user_settings->getErrors(),ApiController::ERROR_VALIDATION,Yii::t('api','Validation error'));
        }
    }
}