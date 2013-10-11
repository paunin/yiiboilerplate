<?php
/**
 * Class MyGetAction
 * Get tags action
 *
 * @property ApiTagController $controller
 */
class MyGetAction extends ApiAction{
    public function run()
    {
        $model = new TagLocationMap();
        $model->setScenario('radius_limit');

        $model->setAttributes(Yii::app()->request->getAllParams());
        $model->only_my = 1;

        if ($model->validate()) {
            $this->controller->out($model->buildTagMap());
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 