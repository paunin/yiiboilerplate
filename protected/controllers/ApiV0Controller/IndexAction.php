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

        //throw new ApiException('s');

        $confs = Yii::app()->params['public'];

        $this->controller->out(
            array(
                'hello' => 'Wellcome to API',
                'version' => 0,
                'config' => $confs,
            )
        );
    }
}