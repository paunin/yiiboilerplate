<?php
/**
 * Class ProfileGetAction
 * Get Profiles action
 *
 * @property ApiLocationController $controller
 */
class ProfileGetAction extends ApiAction
{
    public function run($id)
    {
        /** @var User $user */
        $user = User::model()->findByPk($id);
        if(!$user)
            throw new CHttpException(404,Yii::t('api','User not found'));
        $this->controller->out($user->toFullProfile());
    }
}