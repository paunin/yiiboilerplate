<?php

class ApiV0Controller extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('index');

    public function filters()
    {
        return array_merge(
            parent::filters(),
            array(
                //array('COutputCache + index', 'duration' => 3600, 'varyByParam' => array('v')),
            ),
            array('apiAccessControl')
        );
    }




    public function accessRules()
    {
        return array(
            array('deny',
                'actions' => array('index'),
                'users' => array('?'),
            )
        );
    }
}