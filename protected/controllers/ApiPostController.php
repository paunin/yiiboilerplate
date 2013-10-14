<?php

class ApiPostController extends ApiController
{
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('post', 'postGet', 'postPut', 'postDelete', 'likePost', 'likeDelete', 'commentPost');


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
                'actions' => array('post', 'postPut', 'postDelete', 'likePost', 'likeDelete', 'commentPost'),
                'users' => array('?'),
            )
        );
    }
}