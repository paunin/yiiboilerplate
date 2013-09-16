<?php

$ret = CMap::mergeArray(
    require(dirname(__FILE__) . '/main.php'),
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