<?php
/**
 * Class PostDeleteAction
 * Get tags action
 *
 * @property ApiPostController $controller
 */
class PostDeleteAction extends ApiAction
{
    public function run($id)
    {
        /** @var Post $model */
        $model = Post::model()->findByPk($id, 'user_id =:user_id', array(':user_id' => Yii::app()->user->getId()));

        if(!$model)
            throw new CHttpException(404,Yii::t('api','Post not found'));

        if ($model->delete()) {
            $this->controller->out($model->toArray());
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 