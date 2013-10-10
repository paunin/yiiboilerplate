<?php

class ApiTagController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('get','post','delete');

    public function filters()
    {
        return array(
            'apiAccessControl'
        );

    }

    public function accessRules()
    {
        return array(

            array('allow',
                'actions' => array('post','delete'),
                'users' => array('@'),
            ),

            array('deny',
                'users' => array('*'),
            ),
        );
    }
}