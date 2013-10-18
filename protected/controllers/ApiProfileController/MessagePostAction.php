<?php
/**
 * Class MessagePostAction
 * Create Message
 *
 * @property ApiProfileController $controller
 */
class MessagePostAction extends ApiAction
{
    /**
     * @param int $id UserId
     */
    public function run($id)
    {
        $message = new Message();
        $message->setScenario('message_post');
        $message->to_user_id = $id;
        $message->from_user_id = Yii::app()->user->getId();
        $message->setAttributes(Yii::app()->getRequest()->getAllParams());
        if($message->validate() && $message->save()){
            $this->controller->out($message->toArray());
        }else{
            $this->controller->outError($message->getErrors(), ApiController::ERROR_VALIDATION, Yii::t('api', 'Validation error'));
        }
    }
}