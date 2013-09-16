<?php

class ProfileController extends Controller
{

    public function filters() {
        return array(
            'accessControl',
        );
    }

    public function accessRules() {
        return array(

            array('allow',
                'actions'=>array('changemail','endchangemail'),
                'users'=>array('@'),
            ),

            array('deny',
                'users'=>array('*'),
            ),
        );
    }

    public function actionChangeMail()
    {
        $model=new ChangeMailForm();

        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax']==='changemail-form')
        {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }

        // collect user input data
        if(isset($_POST['ChangeMailForm']))
        {
            $model->attributes=$_POST['ChangeMailForm'];
            if($model->validate()){
                if($model->changemail()){
                    $model=new ChangeMailForm();
                    $this->redirect(Yii::app()->user->returnUrl);
                }
            }
        }


        $this->render('/profile/changemail',array('model'=>$model));
    }
    public function actionEndChangeMail()
    {
        $model=new EndChangeMailForm();

        // if it is ajax validation request
        if(isset($_POST['ajax']) && $_POST['ajax']==='endchangemail-form')
        {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
        $key = Yii::app()->request->getParam('key');
        if($key && !isset($_POST['EndChangeMailForm'])){
            $model->hash = $key;
        }

        // collect user input data
        if(isset($_POST['EndChangeMailForm']))
        {
            $model->attributes=$_POST['EndChangeMailForm'];
            if($model->validate()){
                if($model->endchange()){
                    $model=new EndChangeMailForm();
                    $this->redirect(Yii::app()->user->returnUrl);
                }
            }
        }
        $this->render('/profile/endchangemail',array('model'=>$model));
    }

}