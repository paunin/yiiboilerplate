<?php
/**
 * Class IndexAction
 */
class IndexAction extends CAction
{
    public function run()
    {
        $this->controller->redirect(Cut::createUrl('baby/baby'));
    }
}