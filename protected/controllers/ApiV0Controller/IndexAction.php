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
        try {
            //throw new ApiException('s');
            $confs = Yii::app()->params;
            unset($confs['private']);
            $this->controller->out(
                array(
                    'hello'=>'Wellcome to PlaceMeUp API',
                    'version' => 0,
                    'config' => $confs,
                )
            );
        } catch (ApiException $e) {
            $this->controller->out($e->getHash(),502,false,0,"",'json');
        }
    }
}