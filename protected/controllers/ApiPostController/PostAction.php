<?php
/**
 * Class PostAction
 * Get tags action
 *
 * @property ApiPostController $controller
 */
class PostAction extends ApiAction{
    public function run()
    {
        $model = new Post();
        $model->setScenario('post_post');

        $place = User::current()->userCurrentPlace;
        if(!$place){
            $model->addError('_overall',Yii::t('app','You have no place for post'));
        }else{
            $model->point = $place->cx.":".$place->cy;
        }
        $model->setAttributes(Yii::app()->request->getAllParams());

        if ($model->validate(null,false) && $model->save()) {
            $this->controller->out($model->toArray());
        } else {
            $this->controller->outError($model->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
} 