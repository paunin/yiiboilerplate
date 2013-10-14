<?php
/**
 * Class CommentPostAction
 * Get tags action
 *
 * @property ApiPostController $controller
 */
class CommentPostAction extends ApiAction{
    public function run($id)
    {
        $model = new Post();
        $model->setScenario('comment_post');
        $model->post_id = $id;

        $model->setAttributes(Yii::app()->request->getAllParams());

        if ($model->validate(null,false) && $model->save()) {
            $this->controller->out($model->toArray());
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 