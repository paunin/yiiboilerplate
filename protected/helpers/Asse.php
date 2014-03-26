<?php

class Asse {

    /**
     * @param $file
     * @param null $path
     * @param bool $in_ajax
     * @param null $position
     * @param array $htmlOptions
     * @return bool
     */
    public static function addJs($file,$path = null,$in_ajax = false,$position=null,array $htmlOptions=array()){
        if(Yii::app()->getRequest()->getIsAjaxRequest() && !$in_ajax)
            return false;
        if(!$path)
            $path = Yii::getPathOfAlias('webroot.js');
        $pub = self::publish($file,$path);
        return Yii::app()->getClientScript()->registerScriptFile($pub,$position,$htmlOptions);
    }

    /**
     * @param $file
     * @param null $path
     * @param bool $in_ajax
     * @param string $media
     * @return bool
     */
    public static function addCss($file,$path = null,$in_ajax = false,$media = ''){
        if(Yii::app()->getRequest()->getIsAjaxRequest() && !$in_ajax)
            return false;
        if(!$path)
            $path = Yii::getPathOfAlias('webroot.css');
        $pub = self::publish($file,$path);
        return Yii::app()->getClientScript()->registerCssFile($pub,$media);
    }

    /**
     * @static
     * @param $file
     * @param null $path
     * @return boolean
     */
    private static function publish($file,$path = null){
        if(is_file($path.'/'.$file))
            return Yii::app()->getAssetManager()->publish($path.'/'.$file);
        else
            return false;
    }
}
