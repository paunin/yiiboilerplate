<?php
/**
 * Class IndexAction
 */
class IndexAction extends CAction
{
    public function run()
    {

        $baby = Baby::model()->findByAttributes(array('created_by' => Yii::app()->user->getId()));
        if(!$baby) {
            $baby = new Baby();
            $baby->name = 'My baby';
            $baby->validate();
            $baby->save();
        }

        $model = new BabyActionLogForm();
        $model->date = date('d.m.Y');
        $model->start = date('H:i');
        $model->setAttribute('time_start', date('d.m.Y H:m'));
        $model->setAttribute('time_finish', date('d.m.Y H:m'));

        $model->baby_id = $baby->id;

        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax'] === 'baby-action-log-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        if(isset($_POST['BabyActionLogForm'])) {
            $model->attributes = $_POST['BabyActionLogForm'];
            if($model->validate() && $model->save()) {
                Cut::setFlash(Yii::t('app', 'Event has been saved'), 'success');
                $this->controller->redirect(Cut::createUrl('baby/index'));
            }
        }

        $modelShow = new BabyActionLogShowForm();
        $modelShow->baby_id = $baby->id;
        $modelShow->date_start = date('d.m.Y', strtotime('-1 month'));
        $modelShow->date_end = date('d.m.Y');
        if(isset($_GET['BabyActionLogShowForm'])) {
            $modelShow->attributes = $_GET['BabyActionLogShowForm'];
        }
        if($modelShow->validate()) {
            $stat = $modelShow->getLog();
        }

        $this->controller->render('index', array('model' => $model, 'modelShow' => $modelShow, 'stat' => $stat, 'baby' => $baby));
    }
}