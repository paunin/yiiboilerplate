<?php
/**
 * Class LikeDeleteAction
 * Get tags action
 *
 * @property ApiPostController $controller
 */
class LikeDeleteAction extends ApiAction
{
    public function run($id)
    {
        /** @var Post $model */
        $model = Post::model()->findByPk($id);

        if(!$model)
            throw new CHttpException(404, Yii::t('api', 'Post not found'));

        Favorite::model()->deleteAllByAttributes(array('type' => Favorite::TYPE_POST, 'user_id' => Yii::app()->user->getId(), 'favorite_id' => $id));

        $this->controller->out(true);

    }
} 