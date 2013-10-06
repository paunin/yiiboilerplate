<?php

class ApiUserController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('get','radiusGet','radiusPost','placeGet','placePost','placePut');


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
                'actions' => array('radiusGet', 'radiusPost','placeGet','placePost','placePut'),
                'users' => array('@'),
            ),

            array('deny',
                'users' => array('*'),
            ),
        );
    }
}