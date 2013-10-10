<?php
/**
 * Class GetAction
 * Get Profiles action
 *
 * @property ApiLocationController $controller
 */
class GetTestAction extends ApiAction
{
    public function run()
    {
        $map = new ProfileLocationMap();
        $map->setScenario('radius_limit');
        $map->setAttributes(Yii::app()->request->getAllParams());

        if ($map->validate()) {
            $this->controller->render('application.views.api.mapGetTest',array('result' => $map->buildProfileMap()));
        } else {
            $this->controller->outError($map->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
}