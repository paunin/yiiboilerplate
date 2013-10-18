<?php
/**
 * Class MessageGetOneAction
 * Get one Message
 *
 * @property ApiProfileController $controller
 */
class MessageGetOneAction extends ApiAction
{
    /**
     * @param $message_id
     * @throws CHttpException
     */
    public function run($message_id)
    {
        $message = Message::getOne($message_id,Yii::app()->user->id);
        if(!$message)
            throw new CHttpException(404, Yii::t('app', 'Message not found'));
        $this->controller->out($message->toArray());
    }
}