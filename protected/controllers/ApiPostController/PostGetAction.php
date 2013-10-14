 <?php
/**
 * Class PostGetAction
 * Get tags action
 *
 * @property ApiPostController $controller
 */
class PostGetAction extends ApiAction
{
    public function run($id)
    {
        /** @var Post $model */
        $model = Post::model()->findByPk($id);

        if(!$model)
            throw new CHttpException(404,Yii::t('api','Post not found'));

        if ($model->delete()) {
            $this->controller->out($model->toMiddleFormat(Yii::app()->getRequest()->getParam('comments_limit',0,true),Yii::app()->getRequest()->getParam('comments_offset',0,true)));
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 