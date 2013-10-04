<?php

class ApiUserController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('get','radiusGet','radiusPost');


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
                'actions' => array('radiusGet', 'radiusPost'),
                'users' => array('@'),
            ),

            array('deny',
                'users' => array('*'),
            ),
        );
    }
}