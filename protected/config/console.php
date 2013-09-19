<?php
$main = require(dirname(__FILE__) . '/main.php');
unset ($main['components']['request']);
$ret = CMap::mergeArray(
    $main,
    array(
        'params' => array(

        ),

        'components' => array(
            'fixture' => array(
                'class' => 'system.test.CDbFixtureManager',
            ),
        )
    )
);


return $ret;