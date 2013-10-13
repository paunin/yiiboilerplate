<?php
/**
 * Class PostAction
 * Get tags action
 *
 * @property ApiTagController $controller
 */
class PostAction extends ApiAction{
    public function run()
    {

        $model = new Post();
        $model->setScenario('post_post');

        $model->setAttributes(Yii::app()->request->getAllParams());

        if ($model->validate() && $model->save()) {
            $this->controller->out(true);
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 