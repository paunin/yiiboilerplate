<?php

class ApiOauthController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('tokenGet');

    public function init()
    {
        //
    }

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
                'actions' => array('tokenGet'),
                'users' => array('?'),
            )
        );
    }


}