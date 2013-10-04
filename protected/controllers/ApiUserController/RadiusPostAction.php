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
        if(
            empty($radius)
            ||
            $radius > Yii::app()->params['radius_max']
            ||
            $radius < Yii::app()->params['radius_min']
        ){
            $this->controller->out(
                false,200,true,1,Yii::t('api','Incorrect radius')
            );
            return;
        }

        $user_settings->radius = $radius;
        $user_settings->save();
        $this->controller->out(
            true
        );
    }
}