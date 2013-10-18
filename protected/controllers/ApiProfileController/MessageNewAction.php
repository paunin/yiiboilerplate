<?php
/**
 * Class MessageNewtAction
 * get new inbox Messages
 *
 * @property ApiProfileController $controller
 */
class MessageNewAction extends ApiAction
{
    /**
     *
     */
    public function run()
    {

        $limit = (int)Yii::app()->getRequest()->getParam('limit',0);
        $offset = (int)Yii::app()->getRequest()->getParam('offset',0);

        $messages = Message::getInbox(Yii::app()->user->id,$limit,$offset,true);
        $result = array();
        foreach($messages as $message){
            /** @var Message $message */
            $result[] = $message->toArray();
        }

        $this->controller->out($result);

    }
}