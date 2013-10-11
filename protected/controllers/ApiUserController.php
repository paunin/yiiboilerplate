<?php

class ApiUserController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('get', 'radiusGet', 'radiusPost', 'placeGet', 'placePost', 'placePut', 'placeDelete');


    public function filters()
    {
        return array(
            'apiAccessControl'
        );

    }

    public function accessRules()
    {
        return array(

            array('deny',
                'actions' => array('radiusGet', 'radiusPost', 'placeGet', 'placePost', 'placePut', 'placeDelete'),
                'users' => array('?'),
            )
        );
    }
}