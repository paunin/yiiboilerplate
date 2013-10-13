<?php
/**
 * Class PlaceDeleteAction
 * Change user place
 *
 * @property ApiUserController $controller
 */
class PlaceDeleteAction extends ApiAction
{
    /**
     * @param $id
     * @throws CHttpException
     */
    public function run($id)
    {
        $user_place = UserPlace::findByPkForUser($id,Yii::app()->user->getId());

        if (!$user_place)
            throw new CHttpException(404,Yii::t('app','Place not found'));
        $this->controller->out($user_place->delete());
    }
}