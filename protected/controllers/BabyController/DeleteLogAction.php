<?php
/**
 * Class IndexAction
 */
class DeleteLogAction extends CAction
{
    /**
     * @param $id
     * @throws CHttpException
     */
    public function run($id)
    {
        /** @var BabyActionLog $log */
        $log = BabyActionLog::model()->with(array(
            'baby' => array('together' => true)
        ))->findByPk($id);

        if(!$log || $log->baby->created_by != Yii::app()->user->getId())
            throw new CHttpException(404,Yii::t('c_app','Event not found'));
        $log->delete();
        if(!Yii::app()->getRequest()->getIsAjaxRequest()){
            Cut::setFlash(Yii::t('c_app','Event has been removed successful'),'error');
            $this->controller->redirect(Yii::app()->user->returnUrl);
        }else{
            ApiController::out(true);
        }
    }
}