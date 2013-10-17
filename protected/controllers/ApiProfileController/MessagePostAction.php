<?php
/**
 * Class MessagePostAction
 * Create Message
 *
 * @property ApiLocationController $controller
 */
class MessagePostAction extends ApiAction
{

    /**
     * @param int $id UserId
     */
    public function run($id)
    {
            $this->controller->out(true);//silent skip
    }
}