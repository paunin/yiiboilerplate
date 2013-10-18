<?php
/**
 * Class MessageReadAction
 * Mark as read one Message
 *
 * @property ApiProfileController $controller
 */
class MessageReadAction extends ApiAction
{
    /**
     * @param $message_id
     * @throws CHttpException
     */
    public function run($message_id)
    {
        $criteria = Message::getBaseCriteria();
        $criteria->addCondition('to_user_id = :first_person_id');
        $criteria->params = array(':first_person_id' => Yii::app()->user->id);

        /** @var Message $message */
        $message = Message::model()->findByPk($message_id, $criteria);
        if(!$message)
            throw new CHttpException(404, Yii::t('app', 'Message not found'));
        if(!$message->read_at) {
            $message->read_at = date('Y-m-d H:i:s');
            $message->save();
        }
        $this->controller->out($message->toArray());

    }
}