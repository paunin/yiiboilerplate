<?php

class Cache {
    public static function makeCcKey($key){
        return 'cc_'.$key;
    }

    public static function getDepExpression($key){
        return "Yii::app()->cache->get('".self::makeCcKey($key)."')&& Yii::app()->cache->delete('".self::makeCcKey($key)."') ";
    }

    public static function begin($key, $duration = 3600)
    {
        return Yii::app()->getController()->beginCache($key, array('duration' => $duration,
                                                           'varyByRoute' =>false,
                                                           'dependency' => array(
                                                               'class' => 'CExpressionDependency',
                                                               'expression' => self::getDepExpression($key),
                                                           ),

                                                      ));
    }

    public static function endCache(){
         return Yii::app()->getController()->endCache();
    }

    public static function delCache($key){
        return Yii::app()->cache->set(self::makeCcKey($key),9);
    }
}
