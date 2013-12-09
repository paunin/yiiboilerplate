<?php
// change the following paths if necessary
$yii = dirname(__FILE__) . '/yii/framework/yii.php';
$config_path = dirname(__FILE__) . '/protected/config/';
$config = $config_path . '/main.php';

if(is_file($config_path.'/custom.php'))
    $config_arr = require($config_path.'/custom.php');

require_once($yii);
require_once(dirname(__FILE__).'/protected/components/WebApplication.php');
Yii::createApplication('WebApplication',$config);
