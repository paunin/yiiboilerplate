<?php
/**
 * Class GetAction
 * Get tags action
 *
 * @property ApiTagController $controller
 */
class PostAction extends ApiAction{
    public function run()
    {
        $model = new TagPlace();
        $model->user_id = Yii::app()->user->getId();
        $model->setScenario('tag_place_post');
        $model->setAttributes(Yii::app()->getRequest()->getAllParams());

        if ($model->validate() && $model->save()) {
            $this->controller->out($model->tag->toArray());
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 