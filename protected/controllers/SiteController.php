<?php

class SiteController extends Controller
{
    /**
     * Declares class-based actions.
     */
    public function actions()
    {
        return array(
            // captcha action renders the CAPTCHA image displayed on the contact page
            'captcha' => array(
                'class' => 'CCaptchaAction',
                'backColor' => 0xFFFFFF,
            ),
            // page action renders "static" pages stored under 'protected/views/site/pages'
            // They can be accessed via: index.php?r=site/page&view=FileName
            'page' => array(
                'class' => 'CViewAction',
            ),
        );
    }

    /**
     * Test action
     */
    public function actionIndex()
    {
        $this->render('index');
    }

    public function onSomething(CEvent $event)
    {
        $this->raiseEvent('onSomething', $event);
    }

    /**
     * This is the action to handle external exceptions.
     */
    public function actionError()
    {
        if($error = Yii::app()->errorHandler->error) {
            if(Yii::app()->request->isAjaxRequest)
                echo $error['message'];
            else
                $this->render('error', $error);
        }
    }

    public function filters()
    {
        return array(
            array(
                'application.filters.ExtPreFilter',
                'unit' => 'test',
            ),
            array(
                'application.filters.ExtPostFilter',
                'unit' => 'test',
            ),
        );
    }


}