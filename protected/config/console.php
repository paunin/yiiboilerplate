<?php
$main = require(dirname(__FILE__) . '/main.php');
unset ($main['components']['request']);
$ret = CMap::mergeArray(
    $main,
    array(
        'params' => array(

        ),
        'components' => array(
            'request' => array(
                'hostInfo' => 'http://'.$domain,
                'baseUrl' => $base_url
            ),
        )
    )
);


return $ret;