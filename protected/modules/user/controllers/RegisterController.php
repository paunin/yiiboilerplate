<?php

class RegisterController extends Controller
{


    public function actionRegister()
    {
        $model = new RegisterForm();

        // if it is ajax validation request
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'register-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if (isset($_POST['RegisterForm'])) {
            $model->attributes = $_POST['RegisterForm'];
            $model->scenario = 'registerwcaptcha';
            if ($model->validate()) {
                $model->scenario = NULL;
                if ($model->register()) {
                    Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                    $this->redirect(Yii::app()->user->returnUrl);
                }
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        $this->render('/register/register', array('model' => $model));
    }

    public function actionEndregister()
    {

        $model = new EndRegisterForm();

        // if it is ajax validation request
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'endregister-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        $key = Yii::app()->request->getParam('key');
        if ($key && !isset($_POST['EndRegisterForm'])) {
            $_POST['EndRegisterForm']['hash'] = $key;
        }

        if (isset($_POST['EndRegisterForm'])) {
            $model->attributes = $_POST['EndRegisterForm'];
            if ($model->validate() && $model->endregister()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }


        $this->render('/register/endregister', array('model' => $model));
    }

    public function actionResendMail()
    {
        $model = new ResendMailForm();

        // if it is ajax validation request
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'resendmail-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if (isset($_POST['ResendMailForm'])) {
            $model->attributes = $_POST['ResendMailForm'];
            $model->scenario = 'registerwcaptcha';
            if ($model->validate()) {
                $model->scenario = NULL;
                if ($model->resend()) {
                    Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                    $this->redirect(Yii::app()->user->returnUrl);
                }
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        $this->render('/register/resendmail', array('model' => $model));
    }

    public function actionRecoveryPass()
    {
        $model = new RecoveryPassForm();

        // if it is ajax validation request
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'recoverypass-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        if (isset($_POST['RecoveryPassForm'])) {
            $model->attributes = $_POST['RecoveryPassForm'];
            $model->scenario = 'registerwcaptcha';
            if ($model->validate()) {
                $model->scenario = NULL;
                if ($model->recovery()) {
                    Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                    $this->redirect(Yii::app()->user->returnUrl);
                }
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        $this->render('/register/recoverypass', array('model' => $model));
    }


    public function actionEndRecoveryPass()
    {
        $model = new EndRecoveryPassForm();

        // if it is ajax validation request
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'endrecoverypass-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
        $key = Yii::app()->request->getParam('key');
        if ($key && !isset($_POST['EndRecoveryPassForm'])) {
            $model->hash = $key;
        }

        // collect user input data
        if (isset($_POST['EndRecoveryPassForm'])) {
            $model->attributes = $_POST['EndRecoveryPassForm'];
            if ($model->validate() && $model->endrecovery()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id." ACTION error",'error');
        }
        $this->render('/register/endrecoverypass', array('model' => $model));
    }

}