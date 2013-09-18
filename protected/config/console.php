<?php

$ret = CMap::mergeArray(
    require(dirname(__FILE__) . '/dev.php'),
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