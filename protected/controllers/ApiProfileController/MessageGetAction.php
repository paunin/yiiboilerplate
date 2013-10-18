<?php
/**
 * Class MessageGetAction
 * Create Message
 *
 * @property ApiProfileController $controller
 */
class MessageGetAction extends ApiAction
{
    /**
     * @param $id
     * @throws CHttpException
     */
    public function run($id)
    {
        $user = User::model()->findByPk($id);
        if(!$user)
            throw new CHttpException(404,Yii::t('app','User not found'));

        $limit = (int)Yii::app()->getRequest()->getParam('limit',0);
        $offset = (int)Yii::app()->getRequest()->getParam('offset',0);

        $messages = Message::getDialog(Yii::app()->user->id,$id,$limit,$offset);
        $result = array();
        foreach($messages as $message){
            /** @var Message $message */
            $result[] = $message->toArray();
        }

        $this->controller->out($result);

    }
}