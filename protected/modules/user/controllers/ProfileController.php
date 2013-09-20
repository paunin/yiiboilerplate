<?php

class ProfileController extends Controller
{

    public function filters()
    {
        return array(
            'accessControl',
        );
    }

    public function accessRules()
    {
        return array(

            array('allow',
                'actions' => array('changemail', 'endchangemail', 'changepassword', 'changeusername', 'index'),
                'users' => array('@'),
            ),

            array('deny',
                'users' => array('*'),
            ),
        );
    }

    public function actionIndex()
    {
        $social_accounts = User::current()->userSocials;
        $this->render('/profile/index',array('social_accounts'=>$social_accounts));
    }

    public function actionChangeMail()
    {
        $model = new ChangeMailForm();

        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax'] === 'changemail-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if(isset($_POST['ChangeMailForm'])) {
            $model->attributes = $_POST['ChangeMailForm'];
            if($model->validate() && $model->changemail()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }


        $this->render('/profile/changemail', array('model' => $model));
    }

    public function actionEndChangeMail()
    {
        $model = new EndChangeMailForm();

        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax'] === 'endchangemail-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
        $key = Yii::app()->request->getParam('key');
        if($key && !isset($_POST['EndChangeMailForm'])) {
            $model->hash = $key;
        }

        // collect user input data
        if(isset($_POST['EndChangeMailForm'])) {
            $model->attributes = $_POST['EndChangeMailForm'];
            if($model->validate() && $model->endchange()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        $this->render('/profile/endchangemail', array('model' => $model));
    }

    public function actionChangePassword()
    {

        $model = new ChangePasswordForm();
        if(User::current()->password)
            $model->setScenario('withpassword');


        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax'] === 'changepassword-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if(isset($_POST['ChangePasswordForm'])) {
            $model->attributes = $_POST['ChangePasswordForm'];
            if($model->validate() && $model->change()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        $this->render('/profile/changepassword', array('model' => $model));
    }

    public function actionChangeUsername()
    {

        $model = new ChangeUsernameForm();

        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax'] === 'changeusername-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if(isset($_POST['ChangeUsernameForm'])) {
            $model->attributes = $_POST['ChangeUsernameForm'];
            if($model->validate() && $model->change()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        $this->render('/profile/changeusername', array('model' => $model));
    }
}