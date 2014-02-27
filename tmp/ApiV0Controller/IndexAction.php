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



        $this->controller->out(
            array(
                'hello' => Yii::t('api','Wellcome to API').' - '.Yii::app()->createAbsoluteUrl('apiV0/index'),
                'version' => 0

            )
        );
    }
}