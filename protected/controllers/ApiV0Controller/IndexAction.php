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
            $this->controller->out(
                array(
                    'hello'=>'Wellcome to PlaceMeUp API',
                    'version' => 0,
                    'config' => array(
                        'radius_min' => Yii::app()->params['radius_min'],
                        'radius_max' => Yii::app()->params['radius_max'],
                        'radius_default' => Yii::app()->params['radius_default'],
                    )
                )
            );
        } catch (ApiException $e) {
            $this->controller->out($e->getHash(),502,false,0,"",'json');
        }
    }
}