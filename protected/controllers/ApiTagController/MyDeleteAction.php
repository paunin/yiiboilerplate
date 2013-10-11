<?php
/**
 * Class MyDeleteAction
 * Get tags action
 *
 * @property ApiTagController $controller
 */
class MyDeleteAction extends ApiAction
{
    /**
     * @param int $id of tag
     * @throws CHttpException
     */
    public function run($id)
    {
        /** @var Tag $tag */
        $tag = Tag::model()->findByPk($id);
        if(!$tag)
            throw new CHttpException(404, Yii::t('api', 'Tag not found'));

        $model = new TagLocationMap();
        $model->setScenario('radius_limit');

        $model->setAttributes(Yii::app()->getRequest()->getAllParams());

        if($model->validate()) {
            $this->controller->out((bool)$model->deleteTag($tag, User::current()));
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 