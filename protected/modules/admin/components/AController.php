<?php
/**
 * Controller is the customized base controller class.
 * All controller classes for this application should extend from this base class.
 */
class AController extends GxController
{
    public function filters() {
        return array(
            'accessControl',
        );
    }

    public function accessRules() {
        return array(

            array('allow',
                'actions'=>array('index','view'),
                'roles'=>array('admin'),
            ),
            array('allow',
                'actions'=>array('minicreate', 'create','update'),
                'roles'=>array('admin'),
            ),
            array('allow',
                'actions'=>array('admin','delete'),
                'roles'=>array('admin'),
            ),
            array('deny',
                'users'=>array('*'),
            ),
        );
    }

}