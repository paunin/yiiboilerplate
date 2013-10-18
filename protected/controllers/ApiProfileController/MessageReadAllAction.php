<?php
/**
 * Class MessageReadAllAction
 * Create Message
 *
 * @property ApiProfileController $controller
 */
class MessageReadAllAction extends ApiAction
{
    /**
     * @param $id
     * @throws CHttpException
     */
    public function run($id)
    {
        $user = User::model()->findByPk($id);
        if(!$user)
            throw new CHttpException(404, Yii::t('app', 'User not found'));

        $message_id = Yii::app()->getRequest()->getParam('message_id',null);
        if($message_id){
            $message = Message::getOneWithUser($message_id,Yii::app()->user->getId(),$id);
            if(!$message)
                throw new CHttpException(404, Yii::t('app', 'Message not found'));
        }

        $this->controller->out(Message::readAll(Yii::app()->user->getId(),$id,$message_id));

    }
}