<?php
/**
 * Class LikePostAction
 * Get tags action
 *
 * @property ApiPostController $controller
 */
class LikePostAction extends ApiAction
{
    public function run($id)
    {
        /** @var Post $model */
        $model = Post::model()->findByPk($id);

        if(!$model)
            throw new CHttpException(404,Yii::t('api','Post not found'));

        $fav = new Favorite();
        $fav->user_id = Yii::app()->user->getId();
        $fav->type = Favorite::TYPE_POST;
        $fav->favorite_id = $model->id;

        if ($fav->validate()) {
            $this->controller->out($fav->save());
        } else {
            $this->controller->out(true);//silent skip
            //$this->controller->outError($fav->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }

    }
} 