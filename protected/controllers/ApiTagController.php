<?php

class ApiTagController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('get', 'post', 'myDelete','myGet');

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
                'actions' => array('post', 'myDelete', 'myGet'),
                'users' => array('?'),
            ),
        );
    }
}