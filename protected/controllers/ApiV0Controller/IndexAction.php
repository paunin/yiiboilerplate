<?php
/**
 * Class IndexAction
 *
 * @property Apiv0Controller $controller
 */
class IndexAction extends ApiAction
{
    public function run()
    {
        $this->controller->out('Wellcome to PlaceMeUp API v0');
    }
}