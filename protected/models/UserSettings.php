<?php

Yii::import('application.models._base.BaseUserSettings');

class UserSettings extends BaseUserSettings
{
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    public function rules()
    {
        return array_merge(
            parent::rules(),
            array(

                array('radius', 'required', 'on' => 'radius_post', 'message' => Yii::t('app', 'Radius is required')),

                array(
                    'radius', 'numerical', 'integerOnly' => true,
                    'min' => Yii::app()->params['radius_min'],
                    'tooSmall' => Yii::t('app', 'Radius should be more than or equal {radius_min}', array('{radius_min}' => Yii::app()->params['radius_min'])),
                    'max' => Yii::app()->params['radius_max'],
                    'tooBig' => Yii::t('app', 'Radius should be less than or equal {radius_max}', array('{radius_max}' => Yii::app()->params['radius_max']))
                )
            )
        );
    }
}