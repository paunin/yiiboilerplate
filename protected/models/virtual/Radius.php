<?php

class Radius extends CModel
{
    /**
     * @return int
     */
    public static function getTagRadius(){
        return Yii::app()->params['tag_one_name_radius_weight'];
    }
    /**
     * @return string
     */
    public static function getUserRadius(){
        $user_settings = User::current()->getUserSettings();
        return $user_settings->radius ? $user_settings->radius : Yii::app()->params['radius_default'];
    }

    /**
     * @param LocationPoint $point
     * @return mixed
     */
    public static function getUserRadiusForPoint(LocationPoint $point = null){
        if($point){
            $place = User::current()->getPlace($point);
            if($place && $place->radius)
                return $place->radius;
        }
        $user_settings = User::current()->getUserSettings();
        return $user_settings->radius ? $user_settings->radius : Yii::app()->params['radius_default'];
    }

    public function attributeNames(){
        return array();
    }
}