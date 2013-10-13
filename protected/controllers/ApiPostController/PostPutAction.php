<?php
/**
 * Class PostPutAction
 * Get tags action
 *
 * @property ApiTagController $controller
 */
class PostPutAction extends ApiAction
{
    public function run($id)
    {

        $model = Post::model()->findByPk($id, 'user_id =:user_id', array(':user_id' => Yii::app()->user->getId()));

        if(!$model)
            throw new CHttpException(404,Yii::t('api','Post not found'));

        $model->setScenario('post_put');

        $model->setAttributes(Yii::app()->getRequest()->getAllParams());

        if ($model->validate() && $model->save()) {
            $this->controller->out(true);
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 