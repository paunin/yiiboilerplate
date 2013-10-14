<?php
/**
 * Class FavoritePostAction
 * Create Favorite Profile action
 *
 * @property ApiLocationController $controller
 */
class FavoriteDeleteAction extends ApiAction
{
    /**
     * @param $id User id to ad into favs
     * @throws CHttpException
     */
    public function run($id)
    {
        if ($id == Yii::app()->user->getId())
            throw new CHttpException(701, Yii::t('app', "You can't delete yourself from favorites"));

        /** @var User $favUser */
        $favUser = User::model()->findByPk($id);
        if (!$favUser)
            throw new CHttpException(404, Yii::t('app', "User not found"));

        Favorite::model()->deleteAllByAttributes(array('type' => Favorite::TYPE_USER, 'user_id' => Yii::app()->user->getId(), 'favorite_id' => $id));

        $this->controller->out(true);
    }
}