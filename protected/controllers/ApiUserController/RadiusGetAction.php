<?php
/**
 * Class RadiusGetAction
 * Get User RADIUS
 *
 * @property ApiUserController $controller
 */
class RadiusGetAction extends ApiAction
{
    public function run()
    {
        $user_settings = User::current()->getUserSettings();
        $result = $user_settings->radius ? $user_settings->radius : Yii::app()->params['radius_default'];


        $this->controller->out(
            $result
        );
    }
}