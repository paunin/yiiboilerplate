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
                'hello' => 'Wellcome to API',
                'version' => 0

            )
        );
    }
}