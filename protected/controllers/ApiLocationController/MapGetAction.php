<?php
/**
 * Class Map GetAction
 * Get Map action
 *
 * @property ApiLocationController $controller
 */
class MapGetAction extends ApiAction
{
    public function run()
    {
        $map = new ProfileLocationMap();
        $map->setScenario('vector_limit');
        $map->setAttributes(Yii::app()->request->getAllParams());

        if ($map->validate()) {
            $this->controller->out($map->buildProfileMap());
        } else {
            $this->controller->outError($map->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
}