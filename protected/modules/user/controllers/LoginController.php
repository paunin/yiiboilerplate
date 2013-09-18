<?php

class LoginController extends Controller
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
                'actions' => array('logout'),
                'users' => array('@'),
            ),
            array('allow',
                'actions' => array('login'),
                'users' => array('?'),
            ),
            array('deny',
                'users' => array('*'),
            ),
        );
    }

    /**
     * @param $serviceName
     */
    private function LoginSocial($serviceName)
    {

        /** @var $eauth EAuthServiceBase */
        $eauth = Yii::app()->eauth->getIdentity($serviceName);
        $eauth->redirectUrl = Yii::app()->user->returnUrl;
        $eauth->cancelUrl = $this->createAbsoluteUrl('site/login');

        try {
            if ($eauth->authenticate()) {
                //var_dump($eauth->getIsAuthenticated(), $eauth->getAttributes());
                $identity = new EAuthUserIdentity($eauth);

                // successful authentication
                if ($identity->authenticate()) {
                    Yii::app()->user->login($identity);
                    //var_dump($identity->id, $identity->name, Yii::app()->user->id);exit;
                    //var_dump( $eauth->attributes);

                    // special redirect with closing popup window
                    Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                    $eauth->redirect();
                } else {
                    // close popup window and redirect to cancelUrl
                    Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
                    $eauth->cancel();
                }
            }

            // Something went wrong, redirect to login page
            $this->redirect(array('site/login'));
        } catch (EAuthException $e) {
            // save authentication error to session
            Yii::app()->user->setFlash('error', 'EAuthException: ' . $e->getMessage());
            Cut::setFlash($this->getAction()->id . " ACTION error".'EAuthException: ' . $e->getMessage(), 'error');
            // close popup window and redirect to cancelUrl
            $eauth->redirect($eauth->getCancelUrl());
        }
    }

    private function LoginSimple()
    {
        $model = new LoginForm();

        // if it is ajax validation request
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'login-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if (isset($_POST['LoginForm'])) {
            $model->attributes = $_POST['LoginForm'];
            // validate user input and redirect to the previous page if valid
            if ($model->validate() && $model->login()) {
                Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
                $this->redirect(Yii::app()->user->returnUrl);
            }
            Cut::setFlash($this->getAction()->id . " ACTION error", 'error');
        }
        // display the login form
        $this->render('/login/login', array('model' => $model));
    }

    public function actionLogin()
    {
        $serviceName = Yii::app()->request->getQuery('service');
        if (isset($serviceName)) {
            $this->LoginSocial($serviceName);
        }
        $this->LoginSimple();
    }

    public function actionLogout()
    {
        Yii::app()->user->logout();
        Cut::setFlash($this->getAction()->id . " ACTION success", 'success');
        $this->redirect(Yii::app()->homeUrl);
    }
}