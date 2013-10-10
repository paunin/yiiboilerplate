<?php
/**
 * Class RadiusGetAction
 * Get User RADIUS
 *
 * @property ApiUserController $controller
 */
class RadiusGetAction extends ApiAction
{
    public function run()
    {
        $result = Radius::getUserRadius();
        $this->controller->out(
            $result
        );
    }
}