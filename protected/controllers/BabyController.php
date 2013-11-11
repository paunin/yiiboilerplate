<?php
/**
 * User: paunin
 * Date: 11.11.13
 * Time: 15:04
 */

class BabyController extends Controller {
    /**
     * Declares class-based actions.
     */
    protected $_actions = array('index');

    public function filters()
    {
        return array(
            'accessControl'
        );

    }

    public function accessRules()
    {
        return array(
            array('deny',
                'actions' => array('index', 'myDelete', 'myGet'),
                'users' => array('?'),
            ),
        );
    }
} 