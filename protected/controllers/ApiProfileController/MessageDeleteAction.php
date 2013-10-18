<?php
/**
 * Class MessageDeleteAction
 * Delete one Message
 *
 * @property ApiProfileController $controller
 */
class MessageDeleteAction extends ApiAction
{
    /**
     * @param $message_id
     * @throws CHttpException
     */
    public function run($message_id)
    {
        $message = Message::getOne($message_id, Yii::app()->user->id);
        if(!$message)
            throw new CHttpException(404, Yii::t('app', 'Message not found'));

        if($message->to_user_id == Yii::app()->user->getId())
            $message->to_deleted_at = date('Y-m-d H:i:s');
        else
            $message->from_deleted_at = date('Y-m-d H:i:s');

        $message->save();

        $this->controller->out($message->toArray());
    }
}