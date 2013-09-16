<?php

class Asse {

    /**
     * @static
     * @param $file
     * @param null $path
     * @param bool $in_ajax
     * @return bool
     */
    public static function addJs($file,$path = null,$in_ajax = false){
        if(Yii::app()->getRequest()->getIsAjaxRequest() && !$in_ajax)
            return false;
        if(!$path)
            $path = Yii::getPathOfAlias('webroot.js');
        $pub = self::publish($file,$path);
        return Yii::app()->getClientScript()->registerScriptFile($pub);
    }

    /**
     * @static
     * @param $file
     * @param null $path
     * @param bool $in_ajax
     * @return bool
     */
    public static function addCss($file,$path = null,$in_ajax = false){
        if(Yii::app()->getRequest()->getIsAjaxRequest() && !$in_ajax)
            return false;
        if(!$path)
            $path = Yii::getPathOfAlias('webroot.css');
        $pub = self::publish($file,$path);
        return Yii::app()->getClientScript()->registerCssFile($pub);
    }

    /**
     * @static
     * @param $file
     * @param null $path
     * @return boolean
     */
    private static function publish($file,$path = null){
        return Yii::app()->getAssetManager()->publish($path.'/'.$file);
    }

}
