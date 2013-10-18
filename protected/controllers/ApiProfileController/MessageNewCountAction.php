<?php
/**
 * Class MessageNewCountAction
 * count new Messages
 *
 * @property ApiProfileController $controller
 */
class MessageNewCountAction extends ApiAction
{
    /**
     *
     */
    public function run()
    {
        $this->controller->out(User::current()->messagesCountNew);
    }
}