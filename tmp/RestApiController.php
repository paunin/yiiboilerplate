<?php
Yii::$enableIncludePath =false;
require_once Yii::getPathOfAlias('application').'/vendors/restler/vendor/restler.php';

use Luracast\Restler\Restler;
use Luracast\Restler\Defaults;
////set the defaults to match your requirements
Defaults::$throttle = 20; //time in milliseconds for bandwidth throttling
Defaults::$cacheDirectory = Yii::getPathOfAlias('application').'/runtime/cache';

class RestApiController extends Controller
{
    public function actionIndex(){
        $r = new Restler();
        $r->setAPIVersion(1);
        $r->setSupportedFormats('JsonFormat', 'XmlFormat');

        $r->addAPIClass('Api'); // repeat for more


        $r->addAPIClass('Resources'); //from restler framework for API Explorer
        $r->addFilterClass('RateLimit'); //Add Filters as needed
        $r->handle(); //serve the response

        Yii::app()->end();
    }
}