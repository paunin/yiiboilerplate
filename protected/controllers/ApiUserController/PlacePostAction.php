<?php
/**
 * Class PlacePostAction
 * Add user place
 *
 * @property ApiUserController $controller
 */
class PlacePostAction extends ApiAction
{
    public function run()
    {

        $user_place = new UserPlace();
        $user_place->user_id = User::current()->id;

        $user_place->cxy = Yii::app()->getRequest()->getParam('cxy');
        $user_place->is_spirit = Yii::app()->getRequest()->getParam('is_spirit');
        $user_place->name = Yii::app()->getRequest()->getParam('name');
        $user_place->radius = Yii::app()->getRequest()->getParam('radius');


        $user_place->permissions = $user_place->is_spirit ? 2 : 6;
        $user_place->setScenario('place_post');

        //$user_place->setAttributes();
        if ($user_place->validate()) {
            $this->controller->out($user_place->save());
        } else {
            $this->controller->outError($user_place->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
}