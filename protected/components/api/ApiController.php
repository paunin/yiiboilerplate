<?php
class ApiController extends Controller
{
    /**
     * @param $in
     * @param bool $standart
     *     {
     *          "status":0,
     *          "message":"",
     *          "result": %ANSWER%
     *      }
     * @param int $status
     * @param string $message
     * @param string $type one of
     *      json  - json/jsonp(default)
     *      xml - xml document
     */
    public function out($in, $standart = true,$status = 0, $message = "",$type='json'){
        if($standart)
            $in = array(
                'status' => $status,
                'message' => $message,
                'result' => $in,
            );

        if ( !empty ( $_GET['_debug'] ) ) {
            header('Content-Type: text/html');
            return Yii::app()->controller->render('application.views.api.debug', array('debug' => print_r($in, true)));
        }

        switch ($type){
            case 'json':
                echo self::makeJson($in);
                break;
            case 'xml':
                echo self::makeXml($in);
                break;
        }



    }

    public static function makeXml($in){
        //header('Content-Type: text/xml');
        die('@TODO');
    }

    /**
     * @param mixed $struct
     * @return mixed
     */
    private static function jsonRemoveUnicodeSequences($struct) {
        return str_replace("\/",'/',preg_replace("/\\\\u([a-f0-9]{4})/e", "iconv('UCS-4LE','UTF-8',pack('V', hexdec('U$1')))", json_encode($struct)));
    }

    /**
     * @param $in
     * @return string
     */
    public static  function makeJson($in){
        $json = self::jsonRemoveUnicodeSequences($in);

        // "Tidy"
        $json = str_replace('<br>',   '<br />', $json);
        $json = str_replace('&nbsp;', '&#160;', $json); // for XHTML


        if ( ! Yii::app()->controller->isCachingStackEmpty() ) {
            return Yii::app()->controller->renderDynamic('ApiController::makeJsonp', $json);
        } else {
            return self::makeJsonp($json);
        }
    }
    /**
     * @param $json
     * @return string
     */
    public static function makeJsonp($json){
        header('Content-Type: text/plain');
        return (isset($_GET['callback']))
            ? "{$_GET['callback']}($json)"
            :$json;
    }

    /**
     * @param string $actionID
     */
    public function run($actionID)
    {
        if(YII_DEBUG)
            try {
                return parent::run($actionID);
            } catch (ApiException $e) {
                $this->out($e->getHash());
            }
        else
            parent::run($actionID);
    }

}