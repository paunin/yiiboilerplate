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
                array('radius', 'application.validators.RadiusValidator'),
            )
        );
    }
}