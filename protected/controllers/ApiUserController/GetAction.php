<?php
/**
 * Class GetAction
 *
 * @property ApiUserController $controller
 */
class GetAction extends ApiAction
{
    public function run()
    {
        $result = array();
        if(Yii::app()->user->isGuest){
            $result['authorized'] = false;
        }else{
            $result = User::current()->toArray();
            $result['authorized'] = true;
        }


        $this->controller->out(
            $result
        );
    }
}