<?php
//fix for plain/text
if(!empty($_SERVER['CONTENT_TYPE']) &&  preg_match('/^text\/plain/',$_SERVER['CONTENT_TYPE']))
    unset ($_SERVER['CONTENT_TYPE']);

require_once(dirname(__FILE__) . '/../../../norun.php');
require_once Yii::getPathOfAlias('application') . '/vendors/restler/vendor/restler.php';

use Luracast\Restler\Defaults;
use Luracast\Restler\Restler;
use Luracast\Restler\Format;
use Luracast\Restler\Util;

class YiiRestler extends Restler {
    public function __construct($refreshCache = false){

        Yii::$enableIncludePath =false;
        Yii::app()->setComponent('siteUser', Yii::app()->user);
        Yii::app()->setComponent('user', Yii::app()->apiUser);

        Defaults::$throttle = 20;
        Defaults::$cacheDirectory = Yii::getPathOfAlias('application').'/runtime/cache';
        Defaults::$supportedLanguages = array_keys(Yii::app()->params['translatedLanguages']);
        Defaults::$language = Yii::app()->language;

        $this->setYiiLang();

        parent::__construct(!YII_DEBUG, $refreshCache);
    }


    /**
     * Set lang
     *
     * Set app language from $_SERVER['HTTP_ACCEPT_LANGUAGE'] if not defined in $_GET as used in whole app
     */
    public function setYiiLang(){
        $get_lang = Yii::app()->getRequest()->getParam(Yii::app()->urlManager->languageParam);//check if we have lang in url
        if (!in_array($get_lang,array_keys(Yii::app()->params['translatedLanguages'])) &&
            isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            $langList = Util::sortByPriority($_SERVER['HTTP_ACCEPT_LANGUAGE']);
            foreach ($langList as $lang => $quality) {
                foreach (Defaults::$supportedLanguages as $supported) {
                    if (strcasecmp($supported, $lang) == 0) {
                        Yii::app()->language = $supported;
                        break 2;
                    }
                }
            }
        }
    }

    /**
     * Create api error
     *
     * Proxy method for errors generated in REST API
     *
     * @param $status
     * @param $message
     * @throws Luracast\Restler\RestException
     */
    public static function error($status,$message){
        throw new \Luracast\Restler\RestException($status, $message);
    }

    /**
     * @param $status
     * @return string
     */
    public  static function _getStatusCodeMessage($status)
    {
        $codes = Array(
            200 => 'OK',
            400 => 'Bad Request',
            401 => 'Unauthorized',
            402 => 'Payment Required',
            403 => 'Forbidden',
            404 => 'Not Found',
            500 => 'Internal Server Error',
            501 => 'Not Implemented',
        );
        return (isset($codes[$status])) ? $codes[$status] : 'NOT OKAY';
    }
}